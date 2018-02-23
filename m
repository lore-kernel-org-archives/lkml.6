Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeBWPVU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:21:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751391AbeBWPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:21:18 -0500
Subject: Re: [PATCH] kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds
To: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.LFD.2.21.1802221304430.1603@schleppi>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Feb 2018 16:21:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1802221304430.1603@schleppi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18022315-0020-0000-0000-000003FB0EF4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022315-0021-0000-0000-0000428F289F
Message-Id: <e95a0813-d421-f01c-8708-224758a1b117@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802230190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can see this warnings as well and yes, kvm_arch_irq_routing_update seems to be available
for CONFIG_HAVE_KVM_EVENTFD=y and =n.
Seems that irqchip.c is compile independly from CONFIG_HAVE_KVM_EVENTFD,

so

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

On 02/22/2018 01:05 PM, Sebastian Ott wrote:
> Move the kvm_arch_irq_routing_update() prototype outside of
> ifdef CONFIG_HAVE_KVM_EVENTFD guards to fix the following sparse warning:
> 
> arch/s390/kvm/../../../virt/kvm/irqchip.c:171:28: warning: symbol 'kvm_arch_irq_routing_update' was not declared. Should it be static?
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> ---
>  include/linux/kvm_host.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ed3d4ddbaff3..6930c63126c7 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1105,7 +1105,6 @@ static inline void kvm_irq_routing_update(struct kvm *kvm)
>  {
>  }
>  #endif
> -void kvm_arch_irq_routing_update(struct kvm *kvm);
> 
>  static inline int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
>  {
> @@ -1114,6 +1113,8 @@ static inline int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
> 
>  #endif /* CONFIG_HAVE_KVM_EVENTFD */
> 
> +void kvm_arch_irq_routing_update(struct kvm *kvm);
> +
>  static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
>  {
>  	/*
> 
