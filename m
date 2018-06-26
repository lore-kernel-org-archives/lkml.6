Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A7FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDF026A15
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDF026A15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755024AbeFZXsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:48:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752242AbeFZXsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:48:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QNi406064137
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 19:48:14 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2juxjf9kdq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 19:48:14 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 19:48:13 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 19:48:10 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QNm9cd15270376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 23:48:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79036B2066;
        Tue, 26 Jun 2018 19:48:02 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57FCAB2064;
        Tue, 26 Jun 2018 19:48:02 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 19:48:02 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E99C016CA169; Tue, 26 Jun 2018 16:50:14 -0700 (PDT)
Date:   Tue, 26 Jun 2018 16:50:14 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40d85e0-1d90-2261-99a4-4db315df4860@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062623-2213-0000-0000-000002C06595
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009260; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052801; UDB=6.00539748; IPR=6.00830726;
 MB=3.00021871; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 23:48:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062623-2214-0000-0000-00005A9E808B
Message-Id: <20180626235014.GS3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=894 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 05:10:48AM +0900, Tetsuo Handa wrote:
> On 2018/06/27 2:03, Paul E. McKenney wrote:
> > There are a lot of ways it could be made concurrency safe.  If you need
> > me to do this, please do let me know.
> > 
> > That said, the way it is now written, if you invoke rcu_oom_notify()
> > twice in a row, the second invocation will wait until the memory from
> > the first invocation is freed.  What do you want me to do if you invoke
> > me concurrently?
> > 
> > 1.	One invocation "wins", waits for the earlier callbacks to
> > 	complete, then encourages any subsequent callbacks to be
> > 	processed more quickly.  The other invocations return
> > 	immediately without doing anything.
> > 
> > 2.	The invocations serialize, with each invocation waiting for
> > 	the callbacks from previous invocation (in mutex_lock() order
> > 	or some such), and then starting a new round.
> > 
> > 3.	Something else?
> > 
> > 							Thanx, Paul
> 
> As far as I can see,
> 
> -	atomic_set(&oom_callback_count, 1);
> +	atomic_inc(&oom_callback_count);
> 
> should be sufficient.

I don't see how that helps.  For example, suppose that two tasks
invoked rcu_oom_notify() at about the same time.  Then they could
both see oom_callback_count equal to zero, both atomically increment
oom_callback_count, then both do the IPI invoking rcu_oom_notify_cpu()
on each online CPU.

So far, so good.  But rcu_oom_notify_cpu() enqueues a per-CPU RCU
callback, and enqueuing the same callback twice in quick succession
would fatally tangle RCU's callback lists.

What am I missing here?

							Thanx, Paul

