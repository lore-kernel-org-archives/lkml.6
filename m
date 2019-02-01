Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DFCC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F013B2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfBAJgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:36:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727008AbfBAJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:36:19 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x119Sicb014499
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 04:36:17 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qcj664f4d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:36:17 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 1 Feb 2019 09:36:15 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 09:36:13 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x119aBR01114440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 09:36:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1508A405C;
        Fri,  1 Feb 2019 09:36:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBA63A405F;
        Fri,  1 Feb 2019 09:36:10 +0000 (GMT)
Received: from [9.145.32.190] (unknown [9.145.32.190])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 09:36:10 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v7 15/15] KVM: s390: fix possible null pointer dereference
 in pending_irqs()
To:     Michael Mueller <mimu@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
 <20190131085247.13826-16-mimu@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 1 Feb 2019 10:36:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131085247.13826-16-mimu@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020109-0020-0000-0000-000003103496
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020109-0021-0000-0000-00002161369E
Message-Id: <a40905b7-b2f0-22f4-348f-40a165681d08@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 09:52, Michael Mueller wrote:
> Assure a GISA is in use before accessing the IPM to avoid a
> null pointer dereference issue.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>   arch/s390/kvm/interrupt.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index d322400ca587..660ec87b6e60 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -329,9 +329,13 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>   
>   static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>   {
> -	return pending_irqs_no_gisa(vcpu) |
> -		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<
> -			IRQ_PEND_IO_ISC_7;
> +	struct kvm_s390_gisa_interrupt *gi = &vcpu->kvm->arch.gisa_int;
> +	unsigned long pending_mask;
> +
> +	pending_mask = pending_irqs_no_gisa(vcpu);
> +	if (gi->origin)
> +		pending_mask |= gisa_get_ipm(gi->origin) << IRQ_PEND_IO_ISC_7;
> +	return pending_mask;
>   }
>   
>   static inline int isc_to_irq_type(unsigned long isc)
> 
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

