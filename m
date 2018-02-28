Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbeB1QP7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:15:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933001AbeB1QPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:15:54 -0500
Subject: Re: [PATCH v2 07/15] KVM: s390: Interfaces to configure/deconfigure
 guest's AP matrix
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com,
        buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-8-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 17:15:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519741693-17440-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18022816-0040-0000-0000-000004190EE6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022816-0041-0000-0000-0000261C0F83
Message-Id: <c06ad065-9f10-2d0d-f56f-faae813557d9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280196
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2018 15:28, Tony Krowiak wrote:
> Provides interfaces to assign AP adapters, usage domains
> and control domains to a KVM guest.
>
> A KVM guest is started by executing the Start Interpretive Execution (SIE)
> instruction. The SIE state description is a control block that contains the
> state information for a KVM guest and is supplied as input to the SIE
> instruction. The SIE state description has a satellite structure called the
> Crypto Control Block (CRYCB). The CRYCB contains three bitmask fields
> identifying the adapters, queues (domains) and control domains assigned to
> the KVM guest:
>
> * The AP Adapter Mask (APM) field identifies the AP adapters assigned to
>    the KVM guest
>
> * The AP Queue Mask (AQM) field identifies the AP queues assigned to
>    the KVM guest. Each AP queue is connected to a usage domain within
>    an AP adapter.
>
> * The AP Domain Mask (ADM) field identifies the control domains
>    assigned to the KVM guest.
>
> Each adapter, queue (usage domain) and control domain are identified by
> a number from 0 to 255. The bits in each mask, from most significant to
> least significant bit, correspond to the numbers 0-255. When a bit is
> set, the corresponding adapter, queue (usage domain) or control domain
> is assigned to the KVM guest.

...snip...

>   static int kvm_ap_apxa_installed(void)
>   {
>   	int ret;
> @@ -50,3 +170,140 @@ void kvm_ap_set_crycb_format(struct kvm *kvm, __u32 *crycbd)
>   			*crycbd |= CRYCB_FORMAT1;
>   	}
>   }
> +
> +static int kvm_ap_matrix_apm_create(struct kvm_ap_matrix *ap_matrix, int apxa)
> +{
> +	if (apxa)
> +		ap_matrix->apm_max = 256;

AFAIK the number of possible bits in the masks for a system is not a 
generic value but is
returned by the QCI instruction.
Is there a reason to use a fix value?

> +	else
> +		ap_matrix->apm_max = 64;
> +
> +	ap_matrix->apm = kzalloc(KVM_AP_MASK_BYTES(ap_matrix->apm_max),
> +				 GFP_KERNEL);
> +	if (!ap_matrix->apm)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int kvm_ap_matrix_aqm_create(struct kvm_ap_matrix *ap_matrix, int apxa)
> +{
> +	if (apxa)
> +		ap_matrix->aqm_max = 256;

same here

> +	else
> +		ap_matrix->aqm_max = 16;
> +
> +	ap_matrix->aqm = kzalloc(KVM_AP_MASK_BYTES(ap_matrix->aqm_max),
> +				 GFP_KERNEL);
> +	if (!ap_matrix->aqm)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int kvm_ap_matrix_adm_create(struct kvm_ap_matrix *ap_matrix, int apxa)
> +{
> +	if (apxa)
> +		ap_matrix->adm_max = 256;

and here


Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
