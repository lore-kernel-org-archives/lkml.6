Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933887AbeCBV3Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:29:25 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46325 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933687AbeCBV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:29:23 -0500
X-Google-Smtp-Source: AG47ELsDJoj3w0WVYYDbM6gs2cRSl87df+QM+ZQf7OO+Vm5wwsaKAGoH7QknLebvKnuahB+RTmElGQ==
Date: Fri, 2 Mar 2018 18:29:19 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Samuel Ortiz <samuel@sortiz.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/58] net/irda: Convert timers to use timer_setup()
Message-ID: <20180302212919.GJ3887@localhost.localdomain>
References: <1508200182-104605-1-git-send-email-keescook@chromium.org>
 <1508200182-104605-10-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1508200182-104605-10-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2017 at 05:28:53PM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Samuel Ortiz <samuel@sortiz.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  .../staging/irda/include/net/irda/irlmp_event.h    |  6 +--
>  drivers/staging/irda/include/net/irda/timer.h      | 11 ++---
>  drivers/staging/irda/net/af_irda.c                 |  7 ++-
>  drivers/staging/irda/net/ircomm/ircomm_tty.c       |  2 +-
>  .../staging/irda/net/ircomm/ircomm_tty_attach.c    |  8 ++--
>  drivers/staging/irda/net/irda_device.c             | 10 ++--
>  drivers/staging/irda/net/iriap.c                   | 10 ++--
>  drivers/staging/irda/net/irlan/irlan_client.c      |  6 +--
>  drivers/staging/irda/net/irlan/irlan_common.c      |  4 +-
>  drivers/staging/irda/net/irlap.c                   | 16 +++----
>  drivers/staging/irda/net/irlap_event.c             |  6 +--
>  drivers/staging/irda/net/irlmp.c                   |  8 ++--
>  drivers/staging/irda/net/irlmp_event.c             | 10 ++--
>  drivers/staging/irda/net/irttp.c                   | 11 ++---
>  drivers/staging/irda/net/timer.c                   | 54 +++++++++++-----------
>  15 files changed, 79 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/staging/irda/include/net/irda/irlmp_event.h b/drivers/staging/irda/include/net/irda/irlmp_event.h
> index 9e4ec17a7449..a1a082fe384e 100644
> --- a/drivers/staging/irda/include/net/irda/irlmp_event.h
> +++ b/drivers/staging/irda/include/net/irda/irlmp_event.h
> @@ -82,9 +82,9 @@ typedef enum {
>  extern const char *const irlmp_state[];
>  extern const char *const irlsap_state[];
>  
> -void irlmp_watchdog_timer_expired(void *data);
> -void irlmp_discovery_timer_expired(void *data);
> -void irlmp_idle_timer_expired(void *data);
> +void irlmp_watchdog_timer_expired(struct timer_list *t);
> +void irlmp_discovery_timer_expired(struct timer_list *t);
> +void irlmp_idle_timer_expired(struct timer_list *t);
>  
>  void irlmp_do_lap_event(struct lap_cb *self, IRLMP_EVENT event, 
>  			struct sk_buff *skb);
> diff --git a/drivers/staging/irda/include/net/irda/timer.h b/drivers/staging/irda/include/net/irda/timer.h
> index d784f242cf7b..a6635f0afae9 100644
> --- a/drivers/staging/irda/include/net/irda/timer.h
> +++ b/drivers/staging/irda/include/net/irda/timer.h
> @@ -72,14 +72,11 @@ struct lap_cb;
>  
>  #define WATCHDOG_TIMEOUT        (20*HZ)       /* 20 sec */
>  
> -typedef void (*TIMER_CALLBACK)(void *);
> -
> -static inline void irda_start_timer(struct timer_list *ptimer, int timeout, 
> -				    void* data, TIMER_CALLBACK callback)
> +static inline void irda_start_timer(struct timer_list *ptimer, int timeout,
> +				    void (*callback)(struct timer_list *))
>  {
> -	ptimer->function = (void (*)(unsigned long)) callback;
> -	ptimer->data = (unsigned long) data;
> -	
> +	ptimer->function = (TIMER_FUNC_TYPE) callback;
> +
>  	/* Set new value for timer (update or add timer).
>  	 * We use mod_timer() because it's more efficient and also
>  	 * safer with respect to race conditions - Jean II */
> diff --git a/drivers/staging/irda/net/af_irda.c b/drivers/staging/irda/net/af_irda.c
> index 23fa7c8b09a5..b82a47b9ef0b 100644
> --- a/drivers/staging/irda/net/af_irda.c
> +++ b/drivers/staging/irda/net/af_irda.c
> @@ -429,11 +429,11 @@ static void irda_selective_discovery_indication(discinfo_t *discovery,
>   * We were waiting for a node to be discovered, but nothing has come up
>   * so far. Wake up the user and tell him that we failed...
>   */
> -static void irda_discovery_timeout(u_long priv)
> +static void irda_discovery_timeout(struct timer_list *t)
>  {
>  	struct irda_sock *self;
>  
> -	self = (struct irda_sock *) priv;
> +	self = from_timer(self, t, watchdog);
>  	BUG_ON(self == NULL);
>  
>  	/* Nothing for the caller */
> @@ -2505,8 +2505,7 @@ static int irda_getsockopt(struct socket *sock, int level, int optname,
>  
>  			/* Set watchdog timer to expire in <val> ms. */
>  			self->errno = 0;
> -			setup_timer(&self->watchdog, irda_discovery_timeout,
> -					(unsigned long)self);
> +			timer_setup(&self->watchdog, irda_discovery_timeout, 0);
>  			mod_timer(&self->watchdog,
>  				  jiffies + msecs_to_jiffies(val));
>  
> diff --git a/drivers/staging/irda/net/ircomm/ircomm_tty.c b/drivers/staging/irda/net/ircomm/ircomm_tty.c
> index ec157c3419b5..473abfaffe7b 100644
> --- a/drivers/staging/irda/net/ircomm/ircomm_tty.c
> +++ b/drivers/staging/irda/net/ircomm/ircomm_tty.c
> @@ -395,7 +395,7 @@ static int ircomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>  		self->max_data_size = IRCOMM_TTY_DATA_UNINITIALISED;
>  
>  		/* Init some important stuff */
> -		init_timer(&self->watchdog_timer);
> +		timer_setup(&self->watchdog_timer, NULL, 0);
>  		spin_lock_init(&self->spinlock);
>  
>  		/*
> diff --git a/drivers/staging/irda/net/ircomm/ircomm_tty_attach.c b/drivers/staging/irda/net/ircomm/ircomm_tty_attach.c
> index 0a411019c098..e2d5ce8ba0db 100644
> --- a/drivers/staging/irda/net/ircomm/ircomm_tty_attach.c
> +++ b/drivers/staging/irda/net/ircomm/ircomm_tty_attach.c
> @@ -52,7 +52,7 @@ static void ircomm_tty_getvalue_confirm(int result, __u16 obj_id,
>  					struct ias_value *value, void *priv);
>  static void ircomm_tty_start_watchdog_timer(struct ircomm_tty_cb *self,
>  					    int timeout);
> -static void ircomm_tty_watchdog_timer_expired(void *data);
> +static void ircomm_tty_watchdog_timer_expired(struct timer_list *timer);
>  
>  static int ircomm_tty_state_idle(struct ircomm_tty_cb *self,
>  				 IRCOMM_TTY_EVENT event,
> @@ -587,7 +587,7 @@ static void ircomm_tty_start_watchdog_timer(struct ircomm_tty_cb *self,
>  	IRDA_ASSERT(self != NULL, return;);
>  	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
>  
> -	irda_start_timer(&self->watchdog_timer, timeout, (void *) self,
> +	irda_start_timer(&self->watchdog_timer, timeout,
>  			 ircomm_tty_watchdog_timer_expired);
>  }
>  
> @@ -597,9 +597,9 @@ static void ircomm_tty_start_watchdog_timer(struct ircomm_tty_cb *self,
>   *    Called when the connect procedure have taken to much time.
>   *
>   */
> -static void ircomm_tty_watchdog_timer_expired(void *data)
> +static void ircomm_tty_watchdog_timer_expired(struct timer_list *t)
>  {
> -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) data;
> +	struct ircomm_tty_cb *self = from_timer(self, t, watchdog_timer);
>  
>  	IRDA_ASSERT(self != NULL, return;);
>  	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
> diff --git a/drivers/staging/irda/net/irda_device.c b/drivers/staging/irda/net/irda_device.c
> index d33de8a8762a..682b4eea15e0 100644
> --- a/drivers/staging/irda/net/irda_device.c
> +++ b/drivers/staging/irda/net/irda_device.c
> @@ -57,7 +57,7 @@ static void __irda_task_delete(struct irda_task *task);
>  static hashbin_t *dongles;
>  static hashbin_t *tasks;
>  
> -static void irda_task_timer_expired(void *data);
> +static void irda_task_timer_expired(struct timer_list *timer);
>  
>  int __init irda_device_init(void)
>  {
> @@ -233,7 +233,7 @@ static int irda_task_kick(struct irda_task *task)
>  		}
>  		irda_task_delete(task);
>  	} else if (timeout > 0) {
> -		irda_start_timer(&task->timer, timeout, (void *)task,
> +		irda_start_timer(&task->timer, timeout,
>  				 irda_task_timer_expired);
>  		finished = FALSE;
>  	} else {
> @@ -251,11 +251,9 @@ static int irda_task_kick(struct irda_task *task)
>   *    Task time has expired. We now try to execute task (again), and restart
>   *    the timer if the task has not finished yet
>   */
> -static void irda_task_timer_expired(void *data)
> +static void irda_task_timer_expired(struct timer_list *t)
>  {
> -	struct irda_task *task;
> -
> -	task = data;
> +	struct irda_task *task = from_timer(task, t, timer);
>  
>  	irda_task_kick(task);
>  }
> diff --git a/drivers/staging/irda/net/iriap.c b/drivers/staging/irda/net/iriap.c
> index 1138eaf5c682..d64192e9db8b 100644
> --- a/drivers/staging/irda/net/iriap.c
> +++ b/drivers/staging/irda/net/iriap.c
> @@ -76,12 +76,12 @@ static void iriap_connect_confirm(void *instance, void *sap,
>  static int iriap_data_indication(void *instance, void *sap,
>  				 struct sk_buff *skb);
>  
> -static void iriap_watchdog_timer_expired(void *data);
> +static void iriap_watchdog_timer_expired(struct timer_list *t);
>  
>  static inline void iriap_start_watchdog_timer(struct iriap_cb *self,
>  					      int timeout)
>  {
> -	irda_start_timer(&self->watchdog_timer, timeout, self,
> +	irda_start_timer(&self->watchdog_timer, timeout,
>  			 iriap_watchdog_timer_expired);

I'm having build issues on current net-next:

  CC [M]  drivers/staging/irda/net/iriap.o
In file included from /home/mleitner/linux/include/net/irda/iriap.h:35:0,
                 from /home/mleitner/linux/drivers/staging/irda/net/iriap.c:44:
/home/mleitner/linux/include/net/irda/timer.h: In function ‘irda_start_timer’:
/home/mleitner/linux/include/net/irda/timer.h:80:19: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
  ptimer->function = (void (*)(unsigned long)) callback;
                   ^
/home/mleitner/linux/include/net/irda/timer.h:81:8: error: ‘struct timer_list’ has no member named ‘data’
  ptimer->data = (unsigned long) data;
        ^~
/home/mleitner/linux/drivers/staging/irda/net/iriap.c: In function ‘iriap_start_watchdog_timer’:
/home/mleitner/linux/drivers/staging/irda/net/iriap.c:84:2: error: too few arguments to function ‘irda_start_timer’
  irda_start_timer(&self->watchdog_timer, timeout,
  ^~~~~~~~~~~~~~~~
In file included from /home/mleitner/linux/include/net/irda/iriap.h:35:0,
                 from /home/mleitner/linux/drivers/staging/irda/net/iriap.c:44:
/home/mleitner/linux/include/net/irda/timer.h:77:20: note: declared here
 static inline void irda_start_timer(struct timer_list *ptimer, int timeout,
                    ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Note how it is using the irda_start_timer definition from
include/net/irda/timer.h instead of
drivers/staging/irda/include/net/irda/timer.h which was patched in
this patch.

  Marcelo
