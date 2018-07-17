Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3D520C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3D520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGQN2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:28:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731198AbeGQN2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:28:17 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HCtbDN014829
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:55:44 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9djn0kk3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:55:42 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 08:54:33 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 08:54:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HCsT2k10027452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 12:54:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15892B206B;
        Tue, 17 Jul 2018 08:54:21 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E954CB2066;
        Tue, 17 Jul 2018 08:54:20 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.221.157])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 08:54:20 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6D3D216C1A90; Tue, 17 Jul 2018 05:56:53 -0700 (PDT)
Date:   Tue, 17 Jul 2018 05:56:53 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
 <9ee4d6fd-02e2-2c73-36a7-36ef4f6413b0@de.ibm.com>
 <20180711201759.GB3593@linux.vnet.ibm.com>
 <1531340384.8759.86.camel@infradead.org>
 <20180711210828.GD3593@linux.vnet.ibm.com>
 <1531396842.8759.125.camel@infradead.org>
 <20180712125351.GP3593@linux.vnet.ibm.com>
 <20180712161704.GA20726@linux.vnet.ibm.com>
 <20180716154015.GA21419@linux.vnet.ibm.com>
 <1531815548.19223.23.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531815548.19223.23.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071712-0068-0000-0000-000003196345
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009379; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062049; UDB=6.00545287; IPR=6.00839954;
 MB=3.00022167; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 12:54:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071712-0069-0000-0000-00004510074A
Message-Id: <20180717125653.GH12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:19:08AM +0200, David Woodhouse wrote:
> On Mon, 2018-07-16 at 08:40 -0700, Paul E. McKenney wrote:
> > Most of the weekend was devoted to testing today's upcoming pull request,
> > but I did get a bit more testing done on this.
> > 
> > I was able to make this happen more often by tweaking rcutorture a
> > bit, but I still do not yet have statistically significant results.
> > Nevertheless, I have thus far only seen failures with David's patch or
> > with both David's and my patch.  And I actually got a full-up rcutorture
> > failure (a too-short grace period) in addition to the aforementioned
> > close calls.
> > 
> > Over this coming week I expect to devote significant testing time to
> > the commit just prior to David's in my stack.  If I don't see failures
> > on that commit, we will need to spent some quality time with the KVM
> > folks on whether or not kvm_x86_ops->run() and friends have the option of
> > failing to return, but instead causing control to pop up somewhere else.
> > Or someone could tell me how I am being blind to some obvious bug in
> > the two commits that allow RCU to treat KVM guest-OS execution as an
> > extended quiescent state.  ;-)
> 
> One thing we can try, if my patch is implicated, is moving the calls to
> rcu_kvm_en{ter,xit} closer to the actual VM entry. Let's try putting
> them around the large asm block in arch/x86/kvm/vmx.c::vmx_vcpu_run()
> for example. If that fixes it, then we know we've missed something else
> interesting that's happening in the middle.

I don't have enough data to say anything with too much certainty, but
my patch has rcu_kvm_en{ter,xit}() quite a bit farther apart than yours
does, and I am not seeing massive increases in error rate in my patch
compared to yours.  Which again might or might not mean anything.

Plus I haven't proven that your patch isn't an innocent bystander yet.
If it isn't just an innocent bystander, that will take most of this
week do demonstrate given current failure rates.

I am also working on improving rcutorture diagnostics which should help
me work out how to change rcutorture so as to find this more quickly.

> Testing on Skylake shows a guest CPUID goes from ~3000 cycles to ~3500
> with this patch, so in the next iteration it definitely needs to be
> ifdef CONFIG_NO_HZ_FULL anyway, because it's actually required there
> (AFAICT) and it's too expensive otherwise as Christian pointed out.

Makes sense!

							Thanx, Paul

