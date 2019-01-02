Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58BD218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfABQwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:52:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728720AbfABQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:52:30 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x02GnGWF008826
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jan 2019 11:52:29 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2prxffymdk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 11:52:28 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 2 Jan 2019 16:52:27 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Jan 2019 16:52:23 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x02GqMCh62128292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jan 2019 16:52:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F0D94C058;
        Wed,  2 Jan 2019 16:52:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 645064C044;
        Wed,  2 Jan 2019 16:52:21 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jan 2019 16:52:21 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 04/15] KVM: s390: use pending_irqs_no_gisa() where
 appropriate
To:     Michael Mueller <mimu@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-5-mimu@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 2 Jan 2019 17:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219191756.57973-5-mimu@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010216-0020-0000-0000-000002FF9FC3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010216-0021-0000-0000-0000214FA57A
Message-Id: <88988ed9-dd61-90c0-c689-a317dd1ff23a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901020151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 20:17, Michael Mueller wrote:
> Interruption types that are not represented in GISA shall
> use pending_irqs_no_gisa() to test pending interruptions.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/kvm/interrupt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index c3a8b2fbbcf2..093b568b6356 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -353,7 +353,7 @@ static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
>   
>   static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
>   {
> -	if (!(pending_irqs(vcpu) & IRQ_PEND_EXT_MASK))
> +	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_EXT_MASK))
>   		return;
>   	if (psw_extint_disabled(vcpu))
>   		kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
> @@ -363,7 +363,7 @@ static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
>   
>   static void set_intercept_indicators_mchk(struct kvm_vcpu *vcpu)
>   {
> -	if (!(pending_irqs(vcpu) & IRQ_PEND_MCHK_MASK))
> +	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_MCHK_MASK))
>   		return;
>   	if (psw_mchk_disabled(vcpu))
>   		vcpu->arch.sie_block->ictl |= ICTL_LPSW;
> 

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

