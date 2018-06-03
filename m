Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeFCD6x (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 23:58:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33876 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFCD6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 23:58:51 -0400
X-Google-Smtp-Source: ADUXVKLIz9/XjKpMq8gNqaN/ukjkXTDdfYyeMMJPnGoKlAIkWE88KPdm8XxufDegwVDlgLcUYyd8Qw==
Date: Sat, 2 Jun 2018 20:58:48 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, kernel-team@android.com
Subject: Re: [PATCH] rcu: Check the range of jiffies_till_{first,next}_fqs
 when setting them
Message-ID: <20180603035848.GA76941@joelaf.mtv.corp.google.com>
References: <1527818589-13476-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527818589-13476-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 11:03:09AM +0900, Byungchul Park wrote:
> Currently, the range of jiffies_till_{first,next}_fqs are checked and
> adjusted on and on in the loop of rcu_gp_kthread on runtime.
> 
> However, it's enough to check them only when setting them, not every
> time in the loop. So make them handled on a setting time via sysfs.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/rcu/tree.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4e96761..eb54d7d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -518,8 +518,38 @@ void rcu_all_qs(void)
>  static ulong jiffies_till_next_fqs = ULONG_MAX;
>  static bool rcu_kick_kthreads;
>  
> -module_param(jiffies_till_first_fqs, ulong, 0644);
> -module_param(jiffies_till_next_fqs, ulong, 0644);
> +static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> +{
> +	ulong j;
> +	int ret = kstrtoul(val, 0, &j);
> +
> +	if (!ret)
> +		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
> +	return ret;
> +}
> +
> +static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param *kp)
> +{
> +	ulong j;
> +	int ret = kstrtoul(val, 0, &j);
> +
> +	if (!ret)
> +		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
> +	return ret;
> +}

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Also, can we not combine the 2 param_set_ handlers as well?

Only thing we would be giving up is that jiffies_till_first_fqs = 0 wouldn't
be allowed (if we go with the param_set_next handler to be the common one)
but don't think that's a useful/valid usecase since jiffies_till_first_fqs is
set to a sane non-0 value anyway at boot up because of rcu_init_geometry
anyway.. Thoughts?

If you agree, the below patch could be applied on top of rcu/dev (tested on
rcu/dev), it saves another 20 lines.

thanks,

- Joel

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Sat, 2 Jun 2018 20:47:06 -0700
Subject: [PATCH] rcu: Use common handler for setting
 jiffies_till_{first,next}_fqs

Recently the checking of jiffies_till_{first,next}_fqs during forcing of
quiescent states was changed to be done whenever the parameters are set.

Looking at how jiffies_till_first_fqs is used on my system, I noticed a
value of 0 for it doesn't make much sense and is infact set to a non-0
value at boot up. In this case, we can combine the module_param handlers
for setting both these and keep code size small. This patch attempts it.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index deb2508be923..6550040f8d46 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -498,17 +498,7 @@ static ulong jiffies_till_first_fqs = ULONG_MAX;
 static ulong jiffies_till_next_fqs = ULONG_MAX;
 static bool rcu_kick_kthreads;
 
-static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
-{
-	ulong j;
-	int ret = kstrtoul(val, 0, &j);
-
-	if (!ret)
-		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
-	return ret;
-}
-
-static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param *kp)
+static int param_set_fqs_jiffies(const char *val, const struct kernel_param *kp)
 {
 	ulong j;
 	int ret = kstrtoul(val, 0, &j);
@@ -518,18 +508,13 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	return ret;
 }
 
-static struct kernel_param_ops first_fqs_jiffies_ops = {
-	.set = param_set_first_fqs_jiffies,
-	.get = param_get_ulong,
-};
-
-static struct kernel_param_ops next_fqs_jiffies_ops = {
-	.set = param_set_next_fqs_jiffies,
+static struct kernel_param_ops fqs_jiffies_ops = {
+	.set = param_set_fqs_jiffies,
 	.get = param_get_ulong,
 };
 
-module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
-module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
+module_param_cb(jiffies_till_first_fqs, &fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
+module_param_cb(jiffies_till_next_fqs, &fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
 module_param(rcu_kick_kthreads, bool, 0644);
 
 /*
-- 
2.17.1.1185.g55be947832-goog
