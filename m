Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56898ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C9720673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C9720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeGRItl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:49:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbeGRItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:49:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6I853Qk103145
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:12:58 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ka0hxkd4k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:12:58 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 18 Jul 2018 04:12:56 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 04:12:53 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6I8Cq0P10289578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 08:12:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EDF5112064;
        Wed, 18 Jul 2018 04:12:40 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D378112062;
        Wed, 18 Jul 2018 04:12:40 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jul 2018 04:12:40 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id A43402E2F57; Wed, 18 Jul 2018 13:42:49 +0530 (IST)
Date:   Wed, 18 Jul 2018 13:42:49 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Michael Neuling <mikey@neuling.org>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RESEND][PATCH] powerpc/powernv : Save/Restore SPRG3 on
 entry/exit from stop.
Reply-To: ego@linux.vnet.ibm.com
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
 <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
 <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18071808-2213-0000-0000-000002CC92CB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009385; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062478; UDB=6.00545517; IPR=6.00840335;
 MB=3.00022184; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-18 08:12:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071808-2214-0000-0000-00005AE0F891
Message-Id: <20180718081249.GA17700@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mikey,

On Wed, Jul 18, 2018 at 09:24:19AM +1000, Michael Neuling wrote:
> 
> >  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> > diff --git a/arch/powerpc/kernel/idle_book3s.S
> > b/arch/powerpc/kernel/idle_book3s.S
> > index d85d551..5069d42 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -120,6 +120,9 @@ power9_save_additional_sprs:
> >  	mfspr	r4, SPRN_MMCR2
> >  	std	r3, STOP_MMCR1(r13)
> >  	std	r4, STOP_MMCR2(r13)
> > +
> > +	mfspr	r3, SPRN_SPRG3
> > +	std	r3, STOP_SPRG3(r13)
> 
> We don't need to save it.  Just restore it from paca->sprg_vdso which should
> never change.

Ok. I will respin a patch to restore SPRG3 from paca->sprg_vdso.

> 
> How can we do better at catching these missing SPRGs?

We can go through the list of SPRs from the POWER9 User Manual and
document explicitly why we don't have to save/restore certain SPRs
during the execution of the stop instruction. Does this sound ok ?

(Ref: Table 4-8, Section 4.7.3.4 from the POWER9 User Manual
accessible from
https://openpowerfoundation.org/?resource_lib=power9-processor-users-manual)

> 
> We missed this one and looking at c1b25a17d249 we missed the AMOR a couple of
> months back. I'd rather we had some systematic way of finding the ones we are
> missing, rather than playing wake-a-mole.

I agree, we need something more systematic than the try-catch method
thing we have now.

For deep stop states on POWER9, we looked at the list of SPRs that
were being lost and restored during winkle on POWER8. The additional
SPRs that we took care of were the ones related to the Radix and IMC.

Now since winkle was used only in the context of CPU-Hotplug, the
CPU-online code would reinit some of the SPRs such as SPRG3, which is
why we didn't see this problem on POWER8. So, that is one obvious
place to audit.

AMOR was a bad miss. It was being restored in POWER8 as part of the
subcore restore code, so like RPR, it should have been restored along
with the other per-core SPRs.

> 
> Mikey 
> 
> >  	blr
> >  
> >  power9_restore_additional_sprs:
> > @@ -144,7 +147,9 @@ power9_restore_additional_sprs:
> >  	mtspr	SPRN_MMCR1, r4
> >  
> >  	ld	r3, STOP_MMCR2(r13)
> > +	ld	r4, STOP_SPRG3(r13)
> >  	mtspr	SPRN_MMCR2, r3
> > +	mtspr	SPRN_SPRG3, r4
> >  	blr
> >  
> >  /*

