Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA44AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71DA24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71DA24001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeGFMUZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:20:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932668AbeGFMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:20:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66CEJK8070148
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 08:20:23 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k24u58enb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:20:23 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 6 Jul 2018 08:20:22 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 08:20:20 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w66CKJfB10355358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 12:20:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D334EB205F;
        Fri,  6 Jul 2018 08:19:58 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1C00B2067;
        Fri,  6 Jul 2018 08:19:58 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jul 2018 08:19:58 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 145B616CA59C; Fri,  6 Jul 2018 05:22:36 -0700 (PDT)
Date:   Fri, 6 Jul 2018 05:22:36 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
 <20180629132638.GD5963@dhcp22.suse.cz>
 <20180630170522.GZ3593@linux.vnet.ibm.com>
 <20180702213714.GA7604@linux.vnet.ibm.com>
 <20180703072413.GD16767@dhcp22.suse.cz>
 <20180703160101.GC3593@linux.vnet.ibm.com>
 <20180706053942.GF32658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706053942.GF32658@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070612-0060-0000-0000-00000288640E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009318; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057372; UDB=6.00542491; IPR=6.00835293;
 MB=3.00022024; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-06 12:20:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070612-0061-0000-0000-000045B3AB5D
Message-Id: <20180706122236.GB3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=940 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:39:42AM +0200, Michal Hocko wrote:
> On Tue 03-07-18 09:01:01, Paul E. McKenney wrote:
> > On Tue, Jul 03, 2018 at 09:24:13AM +0200, Michal Hocko wrote:
> > > On Mon 02-07-18 14:37:14, Paul E. McKenney wrote:
> > > [...]
> > > > commit d2b8d16b97ac2859919713b2d98b8a3ad22943a2
> > > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > Date:   Mon Jul 2 14:30:37 2018 -0700
> > > > 
> > > >     rcu: Remove OOM code
> > > >     
> > > >     There is reason to believe that RCU's OOM code isn't really helping
> > > >     that much, given that the best it can hope to do is accelerate invoking
> > > >     callbacks by a few seconds, and even then only if some CPUs have no
> > > >     non-lazy callbacks, a condition that has been observed to be rare.
> > > >     This commit therefore removes RCU's OOM code.  If this causes problems,
> > > >     it can easily be reinserted.
> > > >     
> > > >     Reported-by: Michal Hocko <mhocko@kernel.org>
> > > >     Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > 
> > > I would also note that waiting in the notifier might be a problem on its
> > > own because we are holding the oom_lock and the system cannot trigger
> > > the OOM killer while we are holding it and waiting for oom_callback_wq
> > > event. I am not familiar with the code to tell whether this can deadlock
> > > but from a quick glance I _suspect_ that we might depend on __rcu_reclaim
> > > and basically an arbitrary callback so no good.
> > > 
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > 
> > > Thanks!
> > 
> > Like this?
> 
> Thanks!

Very good, queued for the merge window after next, that is, whatever
number after v4.19.  ;-)

							Thanx, Paul

