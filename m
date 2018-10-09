Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5DAC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF9D2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF9D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeJIU5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:57:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbeJIU5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:57:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w99DdgCn015974
        for <linux-kernel@vger.kernel.org>; Tue, 9 Oct 2018 09:40:06 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n0u23xxes-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:39:45 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 9 Oct 2018 09:36:55 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Oct 2018 09:36:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w99Dap8n63045736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Oct 2018 13:36:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBFFEB2065;
        Tue,  9 Oct 2018 09:34:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F02CB205F;
        Tue,  9 Oct 2018 09:34:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.157.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Oct 2018 09:34:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A511C16C4242; Tue,  9 Oct 2018 06:36:50 -0700 (PDT)
Date:   Tue, 9 Oct 2018 06:36:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Lance Roy <ldr709@gmail.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 12/16] locking/mutex: Replace spin_is_locked() with
 lockdep
Reply-To: paulmck@linux.ibm.com
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-13-ldr709@gmail.com>
 <20181009121809.GG6248@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009121809.GG6248@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100913-0064-0000-0000-0000035CA7A4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009848; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01100154; UDB=6.00569182; IPR=6.00880202;
 MB=3.00023679; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-09 13:36:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100913-0065-0000-0000-00003AEBEEA7
Message-Id: <20181009133650.GO2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=874 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810090135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 01:18:10PM +0100, Will Deacon wrote:
> On Tue, Oct 02, 2018 at 10:38:58PM -0700, Lance Roy wrote:
> > lockdep_assert_held() is better suited to checking locking requirements,
> > since it won't get confused when someone else holds the lock. This is
> > also a step towards possibly removing spin_is_locked().
> > 
> > Signed-off-by: Lance Roy <ldr709@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  kernel/locking/mutex-debug.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
> > index 9aa713629387..771d4ca96dda 100644
> > --- a/kernel/locking/mutex-debug.c
> > +++ b/kernel/locking/mutex-debug.c
> > @@ -36,7 +36,7 @@ void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
> >  
> >  void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
> >  {
> > -	SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
> > +	lockdep_assert_held(&lock->wait_lock);
> >  	DEBUG_LOCKS_WARN_ON(list_empty(&lock->wait_list));
> >  	DEBUG_LOCKS_WARN_ON(waiter->magic != waiter);
> >  	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
> > @@ -51,7 +51,7 @@ void debug_mutex_free_waiter(struct mutex_waiter *waiter)
> >  void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
> >  			    struct task_struct *task)
> >  {
> > -	SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
> > +	lockdep_assert_held(&lock->wait_lock);
> 
> I think it's a good idea to replace debug usage of spin_is_locked() with
> calls to lockdep, but I wonder whether that means that DEBUG_MUTEXES should
> select LOCKDEP so that we don't lose coverage?
> 
> What do you think?

Makes sense to me!

But given that this was accepted into -tip, I have dropped it from my tree.

							Thanx, Paul

