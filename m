Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4C7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A5D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A5D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbeGRQMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:12:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731068AbeGRQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:12:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IFT11V078069
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:34:09 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ka79dk2by-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:34:08 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 18 Jul 2018 11:34:07 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 11:34:04 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6IFY3gp9437444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 15:34:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21FD7B2067;
        Wed, 18 Jul 2018 11:33:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E81A5B205F;
        Wed, 18 Jul 2018 11:33:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jul 2018 11:33:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 797BA16C194E; Wed, 18 Jul 2018 08:36:28 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:36:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <9ee4d6fd-02e2-2c73-36a7-36ef4f6413b0@de.ibm.com>
 <20180711201759.GB3593@linux.vnet.ibm.com>
 <1531340384.8759.86.camel@infradead.org>
 <20180711210828.GD3593@linux.vnet.ibm.com>
 <1531396842.8759.125.camel@infradead.org>
 <20180712125351.GP3593@linux.vnet.ibm.com>
 <20180712161704.GA20726@linux.vnet.ibm.com>
 <20180716154015.GA21419@linux.vnet.ibm.com>
 <1531815548.19223.23.camel@infradead.org>
 <20180717125653.GH12945@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180717125653.GH12945@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071815-0060-0000-0000-0000028E2414
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009387; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062625; UDB=6.00545606; IPR=6.00840480;
 MB=3.00022187; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-18 15:34:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071815-0061-0000-0000-000045D7DBD3
Message-Id: <20180718153628.GA24359@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 05:56:53AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 17, 2018 at 10:19:08AM +0200, David Woodhouse wrote:
> > On Mon, 2018-07-16 at 08:40 -0700, Paul E. McKenney wrote:
> > > Most of the weekend was devoted to testing today's upcoming pull request,
> > > but I did get a bit more testing done on this.
> > > 
> > > I was able to make this happen more often by tweaking rcutorture a
> > > bit, but I still do not yet have statistically significant results.
> > > Nevertheless, I have thus far only seen failures with David's patch or
> > > with both David's and my patch.  And I actually got a full-up rcutorture
> > > failure (a too-short grace period) in addition to the aforementioned
> > > close calls.
> > > 
> > > Over this coming week I expect to devote significant testing time to
> > > the commit just prior to David's in my stack.  If I don't see failures
> > > on that commit, we will need to spent some quality time with the KVM
> > > folks on whether or not kvm_x86_ops->run() and friends have the option of
> > > failing to return, but instead causing control to pop up somewhere else.
> > > Or someone could tell me how I am being blind to some obvious bug in
> > > the two commits that allow RCU to treat KVM guest-OS execution as an
> > > extended quiescent state.  ;-)
> > 
> > One thing we can try, if my patch is implicated, is moving the calls to
> > rcu_kvm_en{ter,xit} closer to the actual VM entry. Let's try putting
> > them around the large asm block in arch/x86/kvm/vmx.c::vmx_vcpu_run()
> > for example. If that fixes it, then we know we've missed something else
> > interesting that's happening in the middle.
> 
> I don't have enough data to say anything with too much certainty, but
> my patch has rcu_kvm_en{ter,xit}() quite a bit farther apart than yours
> does, and I am not seeing massive increases in error rate in my patch
> compared to yours.  Which again might or might not mean anything.
> 
> Plus I haven't proven that your patch isn't an innocent bystander yet.
> If it isn't just an innocent bystander, that will take most of this
> week do demonstrate given current failure rates.

And I finally did get some near misses from an earlier commit, so we
should consider your patch to be officially off the hook.

							Thanx, Paul

> I am also working on improving rcutorture diagnostics which should help
> me work out how to change rcutorture so as to find this more quickly.
> 
> > Testing on Skylake shows a guest CPUID goes from ~3000 cycles to ~3500
> > with this patch, so in the next iteration it definitely needs to be
> > ifdef CONFIG_NO_HZ_FULL anyway, because it's actually required there
> > (AFAICT) and it's too expensive otherwise as Christian pointed out.
> 
> Makes sense!
> 
> 							Thanx, Paul

