Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F8CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A07B20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A07B20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbeGQMTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:19:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730444AbeGQMTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:19:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HBi2Qx128508
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:47:30 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9fjp0t05-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:47:30 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 07:47:29 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 07:47:25 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HBlOwx1245638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 11:47:24 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 956AA2805A;
        Tue, 17 Jul 2018 07:46:40 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2223D28058;
        Tue, 17 Jul 2018 07:46:40 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 07:46:40 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 570F42E2F57; Tue, 17 Jul 2018 17:17:22 +0530 (IST)
Date:   Tue, 17 Jul 2018 17:17:22 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] powerpc/powernv : Save/Restore SPRG3 on entry/exit from
 stop.
Reply-To: ego@linux.vnet.ibm.com
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18071711-0040-0000-0000-0000044FFFB3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009379; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062049; UDB=6.00545287; IPR=6.00839954;
 MB=3.00022167; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 11:47:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071711-0041-0000-0000-000008562A2B
Message-Id: <20180717114722.GA27570@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:57:29PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On 64-bit Servers, SPRN_SPRG3 and its userspace read-only mirror
> SPRN_USPRG3 are used as userspace VDSO write and read registers
> respectively.



> 
> SPRN_SPRG3 is lost when we enter stop4 and above, and is currently not
> restored.  As a result, any read from SPRN_USPRG3 returns zero on an
> exit from stop4 and above.
> 
> Thus in this situation, any call from sched_getcpu() always returns

This happens only on POWER9.

> zero, as on powerpc, we call __kernel_getcpu() which relies upon
> SPRN_USPRG3 to report the CPU and NUMA node information.
> 
> Fix this by saving the SPRN_SPRG3 before entering a deep stop state,
> and restoring it back on wakeup from the stop state.
>

I forgot to add that this fixes commit e1c1cfed5432 ("powerpc/powernv:
Save/Restore additional SPRs for stop4 cpuidle").

@mpe, do you want me to send fresh patch with these updates ?


> Reported-by: Florian Weimer <fweimer@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h | 1 +
>  arch/powerpc/kernel/asm-offsets.c  | 1 +
>  arch/powerpc/kernel/idle_book3s.S  | 5 +++++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index e210a83..03fa904 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -77,6 +77,7 @@ struct stop_sprs {
>  	u64 mmcr1;
>  	u64 mmcr2;
>  	u64 mmcra;
> +	u64 sprg3;
>  };
> 
>  extern u32 pnv_fastsleep_workaround_at_entry[];
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 89cf155..a35ebfc 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -776,6 +776,7 @@ int main(void)
>  	STOP_SPR(STOP_MMCR1, mmcr1);
>  	STOP_SPR(STOP_MMCR2, mmcr2);
>  	STOP_SPR(STOP_MMCRA, mmcra);
> +	STOP_SPR(STOP_SPRG3, sprg3);
>  #endif
> 
>  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index d85d551..5069d42 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -120,6 +120,9 @@ power9_save_additional_sprs:
>  	mfspr	r4, SPRN_MMCR2
>  	std	r3, STOP_MMCR1(r13)
>  	std	r4, STOP_MMCR2(r13)
> +
> +	mfspr	r3, SPRN_SPRG3
> +	std	r3, STOP_SPRG3(r13)
>  	blr
> 
>  power9_restore_additional_sprs:
> @@ -144,7 +147,9 @@ power9_restore_additional_sprs:
>  	mtspr	SPRN_MMCR1, r4
> 
>  	ld	r3, STOP_MMCR2(r13)
> +	ld	r4, STOP_SPRG3(r13)
>  	mtspr	SPRN_MMCR2, r3
> +	mtspr	SPRN_SPRG3, r4
>  	blr
> 
>  /*
> -- 
> 1.9.4
> 

