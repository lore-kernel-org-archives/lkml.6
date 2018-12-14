Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A92CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC36206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeLNP6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:58:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727540AbeLNP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:58:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBEFmfG4079462
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:58:16 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pccs70ut6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:58:15 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Dec 2018 15:58:15 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 15:58:12 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBEFwBs917367216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 15:58:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB100B2064;
        Fri, 14 Dec 2018 15:58:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88586B2066;
        Fri, 14 Dec 2018 15:58:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 15:58:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8DCE216C11E1; Fri, 14 Dec 2018 07:58:11 -0800 (PST)
Date:   Fri, 14 Dec 2018 07:58:11 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/hung_task.c: Break RCU locks based on jiffies.
Reply-To: paulmck@linux.ibm.com
References: <1544800658-11423-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544800658-11423-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121415-0040-0000-0000-000004A2C318
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010224; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131707; UDB=6.00577119; IPR=6.00911838;
 MB=3.00024690; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 15:58:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121415-0041-0000-0000-000008ABE679
Message-Id: <20181214155811.GV4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 12:17:38AM +0900, Tetsuo Handa wrote:
> check_hung_uninterruptible_tasks() is currently calling rcu_lock_break()
> for every 1024 threads. But check_hung_task() is very slow if printk()
> was called, and is very fast otherwise. If many threads within some 1024
> threads called printk(), the RCU grace period might be extended enough
> to trigger RCU stall warnings. Therefore, calling rcu_lock_break() for
> every some fixed jiffies will be safer.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  kernel/hung_task.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index cb8e3e8..444b8b5 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -34,7 +34,7 @@
>   * is disabled during the critical section. It also controls the size of
>   * the RCU grace period. So it needs to be upper-bound.
>   */
> -#define HUNG_TASK_BATCHING 1024
> +#define HUNG_TASK_LOCK_BREAK (HZ / 10)
> 
>  /*
>   * Zero means infinite timeout - no checking done:
> @@ -173,7 +173,7 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
>  static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  {
>  	int max_count = sysctl_hung_task_check_count;
> -	int batch_count = HUNG_TASK_BATCHING;
> +	unsigned long last_break = jiffies;
>  	struct task_struct *g, *t;
> 
>  	/*
> @@ -188,10 +188,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  	for_each_process_thread(g, t) {
>  		if (!max_count--)
>  			goto unlock;
> -		if (!--batch_count) {
> -			batch_count = HUNG_TASK_BATCHING;
> +		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
>  			if (!rcu_lock_break(g, t))
>  				goto unlock;
> +			last_break = jiffies;
>  		}
>  		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
>  		if (t->state == TASK_UNINTERRUPTIBLE)
> -- 
> 1.8.3.1
> 

