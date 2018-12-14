Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45597C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFFE2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbeLNVBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:01:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731063AbeLNVBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:01:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBEKs69w040299
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:01:34 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pchv3nh1f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:01:33 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Dec 2018 21:01:31 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 21:01:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBEL1QvB20906104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 21:01:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43241B2064;
        Fri, 14 Dec 2018 21:01:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16A3AB2067;
        Fri, 14 Dec 2018 21:01:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 21:01:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 48E1B16C2C26; Fri, 14 Dec 2018 13:01:26 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:01:26 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/hung_task.c: Break RCU locks based on jiffies.
Reply-To: paulmck@linux.ibm.com
References: <1544800658-11423-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181214123111.266cae10f71ea6b277d634c6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214123111.266cae10f71ea6b277d634c6@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121421-0052-0000-0000-0000036773E4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010225; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131808; UDB=6.00588228; IPR=6.00911939;
 MB=3.00024694; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 21:01:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121421-0053-0000-0000-00005F1C2EBF
Message-Id: <20181214210126.GX4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:31:11PM -0800, Andrew Morton wrote:
> On Sat, 15 Dec 2018 00:17:38 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
> > check_hung_uninterruptible_tasks() is currently calling rcu_lock_break()
> > for every 1024 threads. But check_hung_task() is very slow if printk()
> > was called, and is very fast otherwise. If many threads within some 1024
> > threads called printk(), the RCU grace period might be extended enough
> > to trigger RCU stall warnings. Therefore, calling rcu_lock_break() for
> > every some fixed jiffies will be safer.
> > 
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -34,7 +34,7 @@
> >   * is disabled during the critical section. It also controls the size of
> >   * the RCU grace period. So it needs to be upper-bound.
> >   */
> > -#define HUNG_TASK_BATCHING 1024
> > +#define HUNG_TASK_LOCK_BREAK (HZ / 10)
> 
> This won't work correctly if rcu_cpu_stall_timeout is set to something
> stupidly small.  Perhaps is would be better to make this code aware of
> the current rcu_cpu_stall_timeout setting?

Good point.

However, the reason that I wasn't worried because any settings of
rcu_cpu_stall_timeout less than 3 seconds are cheerfully bumped up to
3 seconds, so we have a safety factor of 30 as things stand.

I could export the minimum, though, if that would be helpful.

							Thanx, Paul

