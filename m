Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757527AbeD0GoU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 02:44:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757354AbeD0GoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 02:44:18 -0400
Subject: Re: [PATCH v3] KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, Tonny Lu <tonnylu@tencent.com>
References: <1524790503-3267-1-git-send-email-wanpengli@tencent.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Date: Fri, 27 Apr 2018 08:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1524790503-3267-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042706-0040-0000-0000-000004339882
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042706-0041-0000-0000-00002637A2D9
Message-Id: <dc7e1da8-96ca-b40d-cac8-96243de389e9@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270066
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/27/2018 02:55 AM, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Our virtual machines make use of device assignment by configuring
> 12 NVMe disks for high I/O performance. Each NVMe device has 129 
> MSI-X Table entries:
> Capabilities: [50] MSI-X: Enable+ Count=129 Masked-Vector table: BAR=0 offset=00002000
> The windows virtual machines fail to boot since they will map the number of 
> MSI-table entries that the NVMe hardware reported to the bus to msi routing 
> table, this will exceed the 1024. This patch extends MAX_IRQ_ROUTES to 4096
> for all archs, in the future this might be extended again if needed.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> Signed-off-by: Tonny Lu <tonnylu@tencent.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
> v2 -> v3:
>  * update comments in the code
> v1 -> v2:
>  * extend MAX_IRQ_ROUTES to 4096 for all archs 
> 
>  include/linux/kvm_host.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6930c63..6d6e79c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1045,13 +1045,7 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
>  
>  #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
>  
> -#ifdef CONFIG_S390
> -#define KVM_MAX_IRQ_ROUTES 4096 //FIXME: we can have more than that...
> -#elif defined(CONFIG_ARM64)
> -#define KVM_MAX_IRQ_ROUTES 4096
> -#else
> -#define KVM_MAX_IRQ_ROUTES 1024
> -#endif
> +#define KVM_MAX_IRQ_ROUTES 4096 /* might need extension/rework in the future */
>  
>  bool kvm_arch_can_set_irq_routing(struct kvm *kvm);
>  int kvm_set_irq_routing(struct kvm *kvm,
> 
