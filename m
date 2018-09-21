Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2629C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685202156F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685202156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391648AbeIVFWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:22:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725800AbeIVFWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:22:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LNNd5H008470
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:31:15 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn97w2385-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:31:15 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 21 Sep 2018 19:31:14 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 19:31:10 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LNV8LP22872182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 23:31:08 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9B15112062;
        Fri, 21 Sep 2018 19:30:35 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19A9D112061;
        Fri, 21 Sep 2018 19:30:35 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 19:30:35 -0400 (EDT)
Subject: Re: [PATCH v10 25/26] KVM: s390: CPU model support for AP
 virtualization
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-26-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 21 Sep 2018 19:31:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1536781396-13601-26-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092123-0060-0000-0000-000002B42814
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009748; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091744; UDB=6.00564120; IPR=6.00871768;
 MB=3.00023443; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 23:31:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092123-0061-0000-0000-00004697E240
Message-Id: <7868874f-df81-5602-a4c5-a4b58c38d1d3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 03:43 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces a new CPU model feature and two CPU model
> facilities to support AP virtualization for KVM guests.
> 
> CPU model feature:
> 
> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
> AP instructions are available on the guest. This
> feature will be enabled by the kernel only if the AP
> instructions are installed on the linux host. This feature
> must be specifically turned on for the KVM guest from
> userspace to use the VFIO AP device driver for guest
> access to AP devices.
> 
> CPU model facilities:
> 
> 1. AP Query Configuration Information (QCI) facility is installed.
> 
>     This is indicated by setting facilities bit 12 for
>     the guest. The kernel will not enable this facility
>     for the guest if it is not set on the host.
> 
>     If this facility is not set for the KVM guest, then only
>     APQNs with an APQI less than 16 will be used by a Linux
>     guest regardless of the matrix configuration for the virtual
>     machine. This is a limitation of the Linux AP bus.
> 
> 2. AP Facilities Test facility (APFT) is installed.
> 
>     This is indicated by setting facilities bit 15 for
>     the guest. The kernel will not enable this facility for
>     the guest if it is not set on the host.
> 
>     If this facility is not set for the KVM guest, then no
>     AP devices will be available to the guest regardless of
>     the guest's matrix configuration for the virtual
>     machine. This is a limitation of the Linux AP bus.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c         |    5 +++++
>   arch/s390/tools/gen_facilities.c |    2 ++
>   2 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 286c2e0..f0b8e2a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -371,6 +371,11 @@ static void kvm_s390_cpu_feat_init(void)
>   
>   	if (MACHINE_HAS_ESOP)
>   		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
> +
> +	/* Check if AP instructions installed on host */
> +	if (ap_instructions_available())
> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
> +
>   	/*
>   	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>   	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 0c85aed..fd788e0 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -106,6 +106,8 @@ struct facility_def {
>   
>   		.name = "FACILITIES_KVM_CPUMODEL",
>   		.bits = (int[]){
> +			12, /* AP Query Configuration Information */
> +			15, /* AP Facilities Test */
>   			156, /* etoken facility */
>   			-1  /* END */
>   		}
> 

The fixup! patch below modifies this patch (25/26) to illustrate how
David's recommendation will be implemented for v11 of the series. It
is one of three fixup! patches (the other two are in responses to
03/26 and 11/26) included to generate discussion in v10 rather than
waiting until v11 for comments.

-----------------------------------8<-----------------------------------

From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 20 Sep 2018 13:28:07 -0400
Subject: [FIXUP v10] fixup!: KVM: s390: CPU model support for AP 
virtualization

---
  arch/s390/kvm/kvm-s390.c |    4 ----
  1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a3a7cd9..ff38251 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -372,10 +372,6 @@ static void kvm_s390_cpu_feat_init(void)
  	if (MACHINE_HAS_ESOP)
  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);

-	/* Check if AP instructions installed on host */
-	if (ap_instructions_available())
-		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
-
  	/*
  	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
  	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
-- 
1.7.1

