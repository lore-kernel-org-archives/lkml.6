Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB264C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7661626182
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7661626182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965294AbeF0O0V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:26:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964916AbeF0O0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:26:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5REK6CG064544
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:26:20 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvb5wumnq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:26:19 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 10:26:19 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 10:26:16 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5REQFlP7864596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 14:26:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEAEBB206A;
        Wed, 27 Jun 2018 10:26:07 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB88EB2064;
        Wed, 27 Jun 2018 10:26:07 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 10:26:07 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2791116CA20F; Wed, 27 Jun 2018 07:28:22 -0700 (PDT)
Date:   Wed, 27 Jun 2018 07:28:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
 <20180621073142.GA10465@dhcp22.suse.cz>
 <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <f40d85e0-1d90-2261-99a4-4db315df4860@i-love.sakura.ne.jp>
 <20180626235014.GS3593@linux.vnet.ibm.com>
 <c0aeb719-ccb7-46c7-2ad9-b0630bf4d542@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0aeb719-ccb7-46c7-2ad9-b0630bf4d542@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062714-0060-0000-0000-0000028345B1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009263; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053094; UDB=6.00539924; IPR=6.00831018;
 MB=3.00021880; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 14:26:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062714-0061-0000-0000-00004598059B
Message-Id: <20180627142822.GV3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=866 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 07:52:23PM +0900, Tetsuo Handa wrote:
> On 2018/06/27 8:50, Paul E. McKenney wrote:
> > On Wed, Jun 27, 2018 at 05:10:48AM +0900, Tetsuo Handa wrote:
> >> As far as I can see,
> >>
> >> -	atomic_set(&oom_callback_count, 1);
> >> +	atomic_inc(&oom_callback_count);
> >>
> >> should be sufficient.
> > 
> > I don't see how that helps.  For example, suppose that two tasks
> > invoked rcu_oom_notify() at about the same time.  Then they could
> > both see oom_callback_count equal to zero, both atomically increment
> > oom_callback_count, then both do the IPI invoking rcu_oom_notify_cpu()
> > on each online CPU.
> > 
> > So far, so good.  But rcu_oom_notify_cpu() enqueues a per-CPU RCU
> > callback, and enqueuing the same callback twice in quick succession
> > would fatally tangle RCU's callback lists.
> > 
> > What am I missing here?
> 
> You are pointing out that "number of rsp->call() is called" > "number of
> rcu_oom_callback() is called" can happen if concurrently called, aren't you?

Yes.  Reusing an rcu_head before invocation of the earlier use is
very bad indeed.  ;-)

> Then, you are not missing anything. You will need to use something equivalent
> to oom_lock even if you can convert rcu_oom_notify() to use shrinkers.

What should I look at to work out whether it makes sense to convert
rcu_oom_notify() to shrinkers, and if so, how to go about it?

Or are you simply asking me to serialize rcu_oom_notify()?  (Which is
of course not difficult, so please just let me know.)

							Thanx, Paul

