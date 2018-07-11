Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0EDC38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1AD21470
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1AD21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbeGKVM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:12:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732463AbeGKVM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:12:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BL4iOi060659
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:06:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k5nu5ruse-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:06:14 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 17:06:13 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 17:06:10 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BL69qQ3670506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 21:06:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3F58B2065;
        Wed, 11 Jul 2018 17:06:08 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B617FB2064;
        Wed, 11 Jul 2018 17:06:08 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 17:06:08 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DE35F16C3B7E; Wed, 11 Jul 2018 14:08:28 -0700 (PDT)
Date:   Wed, 11 Jul 2018 14:08:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531169145.26547.8.camel@infradead.org>
 <20180709210532.GH3593@linux.vnet.ibm.com>
 <20180709220823.GA18045@linux.vnet.ibm.com>
 <1531319025.8759.57.camel@infradead.org>
 <20180711144303.GQ3593@linux.vnet.ibm.com>
 <20180711164952.GA29994@linux.vnet.ibm.com>
 <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
 <9ee4d6fd-02e2-2c73-36a7-36ef4f6413b0@de.ibm.com>
 <20180711201759.GB3593@linux.vnet.ibm.com>
 <1531340384.8759.86.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531340384.8759.86.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071121-0060-0000-0000-0000028AC1BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059947; UDB=6.00544036; IPR=6.00837868;
 MB=3.00022107; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 21:06:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071121-0061-0000-0000-000045C381CF
Message-Id: <20180711210828.GD3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=800 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:19:44PM +0100, David Woodhouse wrote:
> On Wed, 2018-07-11 at 13:17 -0700, Paul E. McKenney wrote:
> > As I understand it, they would like to have their guest run uninterrupted
> > for extended times.  Because rcu_virt_note_context_switch() is a
> > point-in-time quiescent state, it cannot tell RCU about the extended
> > quiescent state.
> > 
> > Should we replace the current calls to rcu_virt_note_context_switch()
> > with rcu_kvm_enter() and rcu_kvm_exit()?  Would that be better
> > than the below architecture-by-architecture approach?
> 
> Yes it would. I was already starting to mutter about needing the same
> for ARM and POWER. I'll do a v3 (incorporating your fixes too) in the
> morning.
> 
> Thanks.
> 
> Also... why in $DEITY's name was the existing
> rcu_virt_note_context_switch() not actually sufficient? If we had that
> there, why did we need an additional explicit calls to rcu_all_qs() in
> the KVM loop, or the more complex fixes to need_resched() which
> ultimately had the same effect, to avoid ten-second latencies?

My guess is that this was because control passed through the
rcu_virt_note_context_switch() only once, and then subsequent
scheduling-clock interrupts bypassed this code.  But that is just a guess.
I need to defer to someone who understands the KVM code better than I do.

							Thanx, Paul

