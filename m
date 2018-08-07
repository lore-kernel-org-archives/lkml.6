Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C329BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ACD2175D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ACD2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbeHGTVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:21:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389971AbeHGTVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:21:51 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77H4TXY124730
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 13:06:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqeuy1t9u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:06:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 7 Aug 2018 18:06:31 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Aug 2018 18:06:28 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w77H6QoH23396434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 17:06:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F3DB4C04A;
        Tue,  7 Aug 2018 20:06:35 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D7AF4C062;
        Tue,  7 Aug 2018 20:06:35 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Aug 2018 20:06:35 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH RFC 2/2] KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-3-david@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 7 Aug 2018 19:06:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807125131.3606-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080717-4275-0000-0000-000002A68231
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080717-4276-0000-0000-000037AF8897
Message-Id: <fd4bfc34-d001-26b6-17c0-03eb1df59454@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=977 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 14:51, David Hildenbrand wrote:
> When we change the crycb (or execution controls), we also have to make sure
> that the vSIE shadow datastructures properly consider the changed
> values before rerunning the vSIE. We can achieve that by simply using a
> VCPU request now.
>
> This has to be a synchronous request (== handled before entering the
> (v)SIE again).
>
> The request will make sure that the vSIE handler is left, and that the
> request will be processed (NOP), therefore forcing a reload of all
> vSIE data (including rebuilding the crycb) when re-entering the vSIE
> interception handler the next time.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/s390/include/asm/kvm_host.h | 1 +
>   arch/s390/kvm/kvm-s390.c         | 7 ++++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 29c940bf8506..75d39628f21d 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -44,6 +44,7 @@
>   #define KVM_REQ_ICPT_OPEREXC	KVM_ARCH_REQ(2)
>   #define KVM_REQ_START_MIGRATION KVM_ARCH_REQ(3)
>   #define KVM_REQ_STOP_MIGRATION  KVM_ARCH_REQ(4)
> +#define KVM_REQ_VSIE_RESTART	KVM_ARCH_REQ(5)
>   
>   #define SIGP_CTRL_C		0x80
>   #define SIGP_CTRL_SCN_MASK	0x3f
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c87734a31fdb..2fdc017d91f0 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -842,8 +842,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>   
>   	kvm_s390_vcpu_block_all(kvm);
>   
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>   		kvm_s390_vcpu_crypto_setup(vcpu);
> +		/* recreate the shadow crycb by leaving the VSIE handler */
> +		kvm_s390_sync_request(KVM_REQ_VSIE_RESTART, vcpu);
> +	}
>   
>   	kvm_s390_vcpu_unblock_all(kvm);
>   }
> @@ -3201,6 +3204,8 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
>   
>   	/* nothing to do, just clear the request */
>   	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
> +	/* we left the vsie handler, nothing to do, just clear the request */
> +	kvm_clear_request(KVM_REQ_VSIE_RESTART, vcpu);
>   
>   	return 0;
>   }

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Tested-by: Pierre Morel<pmorel@linux.ibm.com>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

