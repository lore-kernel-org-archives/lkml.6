Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbeFCFiI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 01:38:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33107 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeFCFiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 01:38:06 -0400
X-Google-Smtp-Source: ADUXVKI8XB0t7qvIOL4DNqDpcxiXeXeTD96Nmy3OZ2W4I2nTIqNwXrUjoZmRlUeygBwywzFpHj44dAVhLkL2WFFWRnk=
MIME-Version: 1.0
In-Reply-To: <20180603035848.GA76941@joelaf.mtv.corp.google.com>
References: <1527818589-13476-1-git-send-email-byungchul.park@lge.com> <20180603035848.GA76941@joelaf.mtv.corp.google.com>
From: Byungchul Park <max.byungchul.park@gmail.com>
Date: Sun, 3 Jun 2018 14:38:04 +0900
Message-ID: <CANrsvRNeMc8JppnP53ordMkzw+HDdPn0VsiF0j3YdWbQe1+sUg@mail.gmail.com>
Subject: Re: [PATCH] rcu: Check the range of jiffies_till_{first,next}_fqs
 when setting them
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>, josh@joshtriplett.org,
        rostedt@goodmis.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 3, 2018 at 12:58 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Jun 01, 2018 at 11:03:09AM +0900, Byungchul Park wrote:
>> Currently, the range of jiffies_till_{first,next}_fqs are checked and
>> adjusted on and on in the loop of rcu_gp_kthread on runtime.
>>
>> However, it's enough to check them only when setting them, not every
>> time in the loop. So make them handled on a setting time via sysfs.
>>
>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>> ---
>>  kernel/rcu/tree.c | 45 ++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 32 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 4e96761..eb54d7d 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -518,8 +518,38 @@ void rcu_all_qs(void)
>>  static ulong jiffies_till_next_fqs = ULONG_MAX;
>>  static bool rcu_kick_kthreads;
>>
>> -module_param(jiffies_till_first_fqs, ulong, 0644);
>> -module_param(jiffies_till_next_fqs, ulong, 0644);
>> +static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
>> +{
>> +     ulong j;
>> +     int ret = kstrtoul(val, 0, &j);
>> +
>> +     if (!ret)
>> +             WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
>> +     return ret;
>> +}
>> +
>> +static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param *kp)
>> +{
>> +     ulong j;
>> +     int ret = kstrtoul(val, 0, &j);
>> +
>> +     if (!ret)
>> +             WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
>> +     return ret;
>> +}
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Also, can we not combine the 2 param_set_ handlers as well?
>
> Only thing we would be giving up is that jiffies_till_first_fqs = 0 wouldn't
> be allowed (if we go with the param_set_next handler to be the common one)
> but don't think that's a useful/valid usecase since jiffies_till_first_fqs is
> set to a sane non-0 value anyway at boot up because of rcu_init_geometry
> anyway.. Thoughts?

Excuse me. Which code in rcu_init_geometry() makes jiffies_till_first_fqs
be a non-zero in case called with jiffies_till_first_fqs == 0?

Furthermore, what if we want to change the value through sysfs to zero
on runtime?

> If you agree, the below patch could be applied on top of rcu/dev (tested on
> rcu/dev), it saves another 20 lines.
>
> thanks,
>
> - Joel
>
> ---8<-----------------------
>
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Sat, 2 Jun 2018 20:47:06 -0700
> Subject: [PATCH] rcu: Use common handler for setting
>  jiffies_till_{first,next}_fqs
>
> Recently the checking of jiffies_till_{first,next}_fqs during forcing of
> quiescent states was changed to be done whenever the parameters are set.
>
> Looking at how jiffies_till_first_fqs is used on my system, I noticed a
> value of 0 for it doesn't make much sense and is infact set to a non-0
> value at boot up. In this case, we can combine the module_param handlers
> for setting both these and keep code size small. This patch attempts it.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index deb2508be923..6550040f8d46 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -498,17 +498,7 @@ static ulong jiffies_till_first_fqs = ULONG_MAX;
>  static ulong jiffies_till_next_fqs = ULONG_MAX;
>  static bool rcu_kick_kthreads;
>
> -static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> -{
> -       ulong j;
> -       int ret = kstrtoul(val, 0, &j);
> -
> -       if (!ret)
> -               WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
> -       return ret;
> -}
> -
> -static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param *kp)
> +static int param_set_fqs_jiffies(const char *val, const struct kernel_param *kp)
>  {
>         ulong j;
>         int ret = kstrtoul(val, 0, &j);
> @@ -518,18 +508,13 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
>         return ret;
>  }
>
> -static struct kernel_param_ops first_fqs_jiffies_ops = {
> -       .set = param_set_first_fqs_jiffies,
> -       .get = param_get_ulong,
> -};
> -
> -static struct kernel_param_ops next_fqs_jiffies_ops = {
> -       .set = param_set_next_fqs_jiffies,
> +static struct kernel_param_ops fqs_jiffies_ops = {
> +       .set = param_set_fqs_jiffies,
>         .get = param_get_ulong,
>  };
>
> -module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
> -module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
> +module_param_cb(jiffies_till_first_fqs, &fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
> +module_param_cb(jiffies_till_next_fqs, &fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
>  module_param(rcu_kick_kthreads, bool, 0644);
>
>  /*
> --
> 2.17.1.1185.g55be947832-goog
>



-- 
Thanks,
Byungchul
