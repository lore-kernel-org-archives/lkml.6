Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeEaCvo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 22:51:44 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:56320 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932621AbeEaCvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 22:51:42 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [RFC] rcu: Check the range of jiffies_till_xxx_fqs on setting
 them
From: Byungchul Park <byungchul.park@lge.com>
To: paulmck@linux.vnet.ibm.com
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
References: <1527578616-5595-1-git-send-email-byungchul.park@lge.com>
 <20180529120155.GC3803@linux.vnet.ibm.com>
 <07271222-2e1d-2dc8-1648-4c53d710a092@lge.com>
Message-ID: <3d2d8dec-445a-da31-dbe0-34b2331523ed@lge.com>
Date: Thu, 31 May 2018 11:51:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <07271222-2e1d-2dc8-1648-4c53d710a092@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-31 11:18, Byungchul Park wrote:
> On 2018-05-29 21:01, Paul E. McKenney wrote:
> 
>> One approach would be to embed the kernel_params_ops structure inside
>> another structure containing the limits, then just have two structures.
>> Perhaps something like this already exists?  I don't see it right off,
>> but then again, I am not exactly an expert on module_param.
>>
>> Thoughts?
> 
> Unfortunately, I couldn't find it. There might be no way to verify
> range of a variable except the way I did. Could you give your opinion
> about whether I should go on it?

Like..

----->8-----
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4e96761..eb54d7d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -518,8 +518,38 @@ void rcu_all_qs(void)
  static ulong jiffies_till_next_fqs = ULONG_MAX;
  static bool rcu_kick_kthreads;

-module_param(jiffies_till_first_fqs, ulong, 0644);
-module_param(jiffies_till_next_fqs, ulong, 0644);
+static int param_set_first_fqs_jiffies(const char *val, const struct 
kernel_param *kp)
+{
+       ulong j;
+       int ret = kstrtoul(val, 0, &j);
+
+       if (!ret)
+               WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
+       return ret;
+}
+
+static int param_set_next_fqs_jiffies(const char *val, const struct 
kernel_param *kp)
+{
+       ulong j;
+       int ret = kstrtoul(val, 0, &j);
+
+       if (!ret)
+               WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
+       return ret;
+}
+
+static struct kernel_param_ops first_fqs_jiffies_ops = {
+       .set = param_set_first_fqs_jiffies,
+       .get = param_get_ulong,
+};
+
+static struct kernel_param_ops next_fqs_jiffies_ops = {
+       .set = param_set_next_fqs_jiffies,
+       .get = param_get_ulong,
+};
+
+module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, 
&jiffies_till_first_fqs, 0644);
+module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, 
&jiffies_till_next_fqs, 0644);
  module_param(rcu_kick_kthreads, bool, 0644);

  /*
@@ -2129,10 +2159,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
                 /* Handle quiescent-state forcing. */
                 first_gp_fqs = true;
                 j = jiffies_till_first_fqs;
-               if (j > HZ) {
-                       j = HZ;
-                       jiffies_till_first_fqs = HZ;
-               }
                 ret = 0;
                 for (;;) {
                         if (!ret) {
@@ -2167,13 +2193,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
                                 WRITE_ONCE(rsp->gp_activity, jiffies);
                                 ret = 0; /* Force full wait till next 
FQS. */
                                 j = jiffies_till_next_fqs;
-                               if (j > HZ) {
-                                       j = HZ;
-                                       jiffies_till_next_fqs = HZ;
-                               } else if (j < 1) {
-                                       j = 1;
-                                       jiffies_till_next_fqs = 1;
-                               }
                         } else {
                                 /* Deal with stray signal. */
                                 cond_resched_tasks_rcu_qs();


-- 
Thanks,
Byungchul
