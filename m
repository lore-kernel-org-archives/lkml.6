Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A243C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55571276CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55571276CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754828AbeF1V3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:29:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751750AbeF1V3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:29:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SLT21q109831
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:29:05 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jw62mkyja-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:29:04 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Jun 2018 17:29:03 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 17:28:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5SLSwgE19333594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 21:28:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AE2FB2065;
        Thu, 28 Jun 2018 17:28:49 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CFB9B2064;
        Thu, 28 Jun 2018 17:28:49 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 17:28:49 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B5D3116C5F24; Thu, 28 Jun 2018 14:31:05 -0700 (PDT)
Date:   Thu, 28 Jun 2018 14:31:05 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
 <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628113942.GD32348@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062821-0060-0000-0000-000002840703
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009273; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053715; UDB=6.00540296; IPR=6.00831637;
 MB=3.00021913; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-28 21:29:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062821-0061-0000-0000-0000459C13F1
Message-Id: <20180628213105.GP3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:39:42PM +0200, Michal Hocko wrote:
> On Wed 27-06-18 07:31:25, Paul E. McKenney wrote:
> > On Wed, Jun 27, 2018 at 09:22:07AM +0200, Michal Hocko wrote:
> > > On Tue 26-06-18 10:03:45, Paul E. McKenney wrote:
> > > [...]
> > > > 3.	Something else?
> > > 
> > > How hard it would be to use a different API than oom notifiers? E.g. a
> > > shrinker which just kicks all the pending callbacks if the reclaim
> > > priority reaches low values (e.g. 0)?
> > 
> > Beats me.  What is a shrinker?  ;-)
> 
> This is a generich mechanism to reclaim memory that is not on standard
> LRU lists. Lwn.net surely has some nice coverage (e.g.
> https://lwn.net/Articles/548092/).

"In addition, there is little agreement over what a call to a shrinker
really means or how the called subsystem should respond."  ;-)

Is this set up using register_shrinker() in mm/vmscan.c?  I am guessing
that the many mentions of shrinker in DRM are irrelevant.

If my guess is correct, the API seems a poor fit for RCU.  I can
produce an approximate number of RCU callbacks for ->count_objects(),
but a given callback might free a lot of memory or none at all.  Plus,
to actually have ->scan_objects() free them before returning, I would
need to use something like rcu_barrier(), which might involve longer
delays than desired.

Or am I missing something here?

> > More seriously, could you please point me at an exemplary shrinker
> > use case so I can see what is involved?
> 
> Well, I am not really sure what is the objective of the oom notifier to
> point you to the right direction. IIUC you just want to kick callbacks
> to be handled sooner under a heavy memory pressure, right? How is that
> achieved? Kick a worker?

That is achieved by enqueuing a non-lazy callback on each CPU's callback
list, but only for those CPUs having non-empty lists.  This causes
CPUs with lists containing only lazy callbacks to be more aggressive,
in particular, it prevents such CPUs from hanging out idle for seconds
at a time while they have callbacks on their lists.

The enqueuing happens via an IPI to the CPU in question.

						Thanx, Paul

