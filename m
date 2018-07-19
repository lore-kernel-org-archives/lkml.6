Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18791ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBD72084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBD72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeGSNiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:38:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730845AbeGSNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:38:24 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6JCoV2R077919
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:55:21 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2katuh0trv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:55:21 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 19 Jul 2018 08:55:20 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Jul 2018 08:55:16 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6JCtFL010420600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jul 2018 12:55:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 697C4B205F;
        Thu, 19 Jul 2018 08:55:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48351B2065;
        Thu, 19 Jul 2018 08:55:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.233.56])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jul 2018 08:55:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 02CD716C2169; Thu, 19 Jul 2018 05:55:15 -0700 (PDT)
Date:   Thu, 19 Jul 2018 05:55:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531815548.19223.23.camel@infradead.org>
 <20180717125653.GH12945@linux.vnet.ibm.com>
 <20180718153628.GA24359@linux.vnet.ibm.com>
 <1531929711.3414.29.camel@infradead.org>
 <20180718163712.GB12945@linux.vnet.ibm.com>
 <1531942865.3414.35.camel@infradead.org>
 <20180718201700.GN12945@linux.vnet.ibm.com>
 <86d12d1a-46dd-d82a-96c2-e842ac5a2a6c@de.ibm.com>
 <1531984833.12620.16.camel@infradead.org>
 <a2626528-1819-07f2-24f2-ded6437cca5d@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2626528-1819-07f2-24f2-ded6437cca5d@de.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071912-0060-0000-0000-0000028E9DD9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009391; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01063051; UDB=6.00545862; IPR=6.00840902;
 MB=3.00022202; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-19 12:55:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071912-0061-0000-0000-000045DA818F
Message-Id: <20180719125515.GS12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=955 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807190138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:23:34PM +0200, Christian Borntraeger wrote:
> 
> 
> On 07/19/2018 09:20 AM, David Woodhouse wrote:
> > On Thu, 2018-07-19 at 08:45 +0200, Christian Borntraeger wrote:
> >>
> >>> My thought would be something like this:
> >>>  
> >>>        if (context_tracking_cpu_is_enabled())
> >>>                rcu_kvm_enter();
> >>>        else
> >>>                rcu_virt_note_context_switch(smp_processor_id());
> >>
> >> In the past we needed that (when we introduced that). At least with every
> >> host interrupt we called this making an rcu event at least every HZ.
> >> Will the changes in need_resched make this part unnecessary?
> > 
> > Yes, the change in need_resched() should make this part unnecessary.
> > Unless your architecture's version of the vcpu_run() loop just loops
> > forever even when TIF_NEED_RESCHED is set? :)
> 
> Very early versions did that. The SIE instruction is interruptible
> so you can continue to run the guest by simply returning from an host
> interrupt. All sane versions of KVM on s390 now make sure to make a
> short trip into C after a host interrupt. There we check for
> need_resched signals and machine checks so we are good.

OK, thank you all!  I will drop the two patches that add the
rcu_kvm_enter() and rcu_kvm_exit() calls.  Two less things to
worry about!  ;-)

							Thanx, Paul

> > I'm not sure about the context tracking condition in the code snippet
> > cited above, though. I think that's what caused my problem in the first
> > place — I have CONTEXT_TRACKING_FORCE && !NO_HZ_FULL. So in 4.15, that
> > means rcu_user_enter() did nothing and rcu_virt_note_context_switch()
> > wasn't called. Hence the observed stalls.
> > 
> > Should rcu_user_enter() itself be conditional on CONTEXT_TRACKING not
> > NO_HZ_FULL? 
> > 

