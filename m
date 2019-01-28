Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17AAC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA48A2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfA1PzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728882AbfA1PzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:03 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SFl6qS037506
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:55:02 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qa2r375fu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:55:02 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 28 Jan 2019 15:55:00 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 15:54:57 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SFsuHg65798278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 15:54:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED80AAE051;
        Mon, 28 Jan 2019 15:54:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D7CBAE053;
        Mon, 28 Jan 2019 15:54:55 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.97.178])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 15:54:55 +0000 (GMT)
Date:   Mon, 28 Jan 2019 16:54:54 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 05/13] KVM: s390: use pending_irqs_no_gisa() where
 appropriate
In-Reply-To: <20190124125939.130763-6-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-6-mimu@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012815-4275-0000-0000-00000305F2AF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012815-4276-0000-0000-00003813F6DB
Message-Id: <20190128165454.6e4bb540@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 13:59:31 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Interruption types that are not represented in GISA shall
> use pending_irqs_no_gisa() to test pending interruptions.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

I guess this is just a tiny optimization.

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 005dbe7252e7..cb48736867ed 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -353,7 +353,7 @@ static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
>  
>  static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
>  {
> -	if (!(pending_irqs(vcpu) & IRQ_PEND_EXT_MASK))
> +	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_EXT_MASK))
>  		return;
>  	if (psw_extint_disabled(vcpu))
>  		kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
> @@ -363,7 +363,7 @@ static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
>  
>  static void set_intercept_indicators_mchk(struct kvm_vcpu *vcpu)
>  {
> -	if (!(pending_irqs(vcpu) & IRQ_PEND_MCHK_MASK))
> +	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_MCHK_MASK))
>  		return;
>  	if (psw_mchk_disabled(vcpu))
>  		vcpu->arch.sie_block->ictl |= ICTL_LPSW;

