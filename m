Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A753CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282E8208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282E8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbeGPQF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:05:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729612AbeGPQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:05:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GFXoHx118942
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 11:37:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k8uww6sfv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 11:37:55 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 11:37:55 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 11:37:53 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6GFbqaC15335820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 15:37:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D436B2066;
        Mon, 16 Jul 2018 11:37:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F86DB2064;
        Mon, 16 Jul 2018 11:37:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 11:37:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 759C216C2611; Mon, 16 Jul 2018 08:40:15 -0700 (PDT)
Date:   Mon, 16 Jul 2018 08:40:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180711144303.GQ3593@linux.vnet.ibm.com>
 <20180711164952.GA29994@linux.vnet.ibm.com>
 <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
 <9ee4d6fd-02e2-2c73-36a7-36ef4f6413b0@de.ibm.com>
 <20180711201759.GB3593@linux.vnet.ibm.com>
 <1531340384.8759.86.camel@infradead.org>
 <20180711210828.GD3593@linux.vnet.ibm.com>
 <1531396842.8759.125.camel@infradead.org>
 <20180712125351.GP3593@linux.vnet.ibm.com>
 <20180712161704.GA20726@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712161704.GA20726@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071615-0040-0000-0000-0000044F9253
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009375; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01061681; UDB=6.00545066; IPR=6.00839585;
 MB=3.00022159; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-16 15:37:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071615-0041-0000-0000-00000855BC0E
Message-Id: <20180716154015.GA21419@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 09:17:04AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 12, 2018 at 05:53:51AM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 12, 2018 at 01:00:42PM +0100, David Woodhouse wrote:
> > > 
> > > 
> > > On Wed, 2018-07-11 at 14:08 -0700, Paul E. McKenney wrote:
> > > > 
> > > > > Also... why in $DEITY's name was the existing
> > > > > rcu_virt_note_context_switch() not actually sufficient? If we had that
> > > > > there, why did we need an additional explicit calls to rcu_all_qs() in
> > > > > the KVM loop, or the more complex fixes to need_resched() which
> > > > > ultimately had the same effect, to avoid ten-second latencies?
> > > > 
> > > > My guess is that this was because control passed through the
> > > > rcu_virt_note_context_switch() only once, and then subsequent
> > > > scheduling-clock interrupts bypassed this code.
> > 
> > Gah!  My guess was instead that the code did a rcu_kvm_enter() going in,
> > but somehow managed to miss the rcu_kvm_exit() going out.  But that makes
> > absolutely no sense -- had that happened, rcutorture would likely have
> > screamed bloody murder, loudly and often.  No mere near misses!
> > 
> > And besides, thus far, -ENOREPRODUCE.  :-/
> 
> OK, one close call in 63 hours of rcutorture, this one on scenario TREE03
> (yesterday hit TREE01 and TREE03).  Time for probabilitistic long-runtime
> bisection.  Plus thought about how to get more information out of the near
> misses.  Fun!  ;-)

Most of the weekend was devoted to testing today's upcoming pull request,
but I did get a bit more testing done on this.

I was able to make this happen more often by tweaking rcutorture a
bit, but I still do not yet have statistically significant results.
Nevertheless, I have thus far only seen failures with David's patch or
with both David's and my patch.  And I actually got a full-up rcutorture
failure (a too-short grace period) in addition to the aforementioned
close calls.

Over this coming week I expect to devote significant testing time to
the commit just prior to David's in my stack.  If I don't see failures
on that commit, we will need to spent some quality time with the KVM
folks on whether or not kvm_x86_ops->run() and friends have the option of
failing to return, but instead causing control to pop up somewhere else.
Or someone could tell me how I am being blind to some obvious bug in
the two commits that allow RCU to treat KVM guest-OS execution as an
extended quiescent state.  ;-)

							Thanx, Paul

