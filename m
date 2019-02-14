Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0857C222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbfBNPyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:54:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbfBNPyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:54:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42FBE7DCD2;
        Thu, 14 Feb 2019 15:54:24 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDAF527BA6;
        Thu, 14 Feb 2019 15:54:09 +0000 (UTC)
Date:   Thu, 14 Feb 2019 16:54:07 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
Message-ID: <20190214165407.335b4ec0.cohuck@redhat.com>
In-Reply-To: <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 14 Feb 2019 15:54:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 14:51:02 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> This patch adds interception code for the PQAP instructions,
> and a callback inside the KVM arch structure for s390.
> 
> If a VFIO-AP drivers needs to intercept PQAP/AQIC or PQAP/TAPQ

s/drivers/driver/

> instructions, the driver will initialize the callback inside
> the kvm_arch structure to be called when the interception of a
> PQAP instruction occurs.
> 
> If the callback is not initialized, the code still returns
> -EOPNOTSUPP to let userland handle the instruction as it used to.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  1 +
>  arch/s390/kvm/priv.c             | 50 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index c5f5156..49cc8b0 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -719,6 +719,7 @@ struct kvm_s390_cpu_model {
>  
>  struct kvm_s390_crypto {
>  	struct kvm_s390_crypto_cb *crycb;
> +	int (*pqap_hook)(struct kvm_vcpu *vcpu);
>  	__u32 crycbd;
>  	__u8 aes_kw;
>  	__u8 dea_kw;
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 8679bd7..72fdc21 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -27,6 +27,7 @@
>  #include <asm/io.h>
>  #include <asm/ptrace.h>
>  #include <asm/sclp.h>
> +#include <asm/ap.h>
>  #include "gaccess.h"
>  #include "kvm-s390.h"
>  #include "trace.h"
> @@ -592,6 +593,53 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> +/*
> + * handle_pqap: Handling pqap interception
> + * @vcpu: the vcpu having issue the pqap instruction

s/issue/issued/

> + *
> + * This callback only handles PQAP/AQIC instruction and

Here you only talk about PQAP/AQIC, what about PQAP/TAPQ mentioned in
the patch description?

> + * calls a dedicated callback for this instruction if
> + * a driver did register one in the CRYPTO satellite of the
> + * SIE block.
> + *
> + * Do not change the behavior if, return -EOPNOTSUPP if:
> + * - the hook is not used do not change the behavior.

The hook is not used? Or not set? (I don't think you need to repeat "do
not change the behavior".)

> + * - AP instructions are not available or not available to the guest
> + * - the instruction is not PQAP with function code indicating
> + *   AQIC do not change the previous behavior.
> + *
> + * For PQAP/AQIC instruction, verify privilege and specifications
> + *
> + * return the value returned by the callback.
> + */
> +static int handle_pqap(struct kvm_vcpu *vcpu)
> +{
> +	uint8_t fc;
> +
> +	/* Verify that the hook callback is registered */
> +	if (!vcpu->kvm->arch.crypto.pqap_hook)
> +		return -EOPNOTSUPP;
> +	/* Verify that the AP instruction are available */
> +	if (!ap_instructions_available())
> +		return -EOPNOTSUPP;
> +	/* Verify that the guest is allowed to use AP instructions */
> +	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
> +		return -EOPNOTSUPP;
> +	/* Verify that the function code is AQIC */
> +	fc = vcpu->run->s.regs.gprs[0] >> 24;
> +	if (fc != 0x03)
> +		return -EOPNOTSUPP;
> +
> +	/* PQAP instructions are allowed for guest kernel only */
> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> +	/* AQIC instruction is allowed only if facility 65 is available */
> +	if (!test_kvm_facility(vcpu->kvm, 65))
> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	/* All right, call the callback */
> +	return vcpu->kvm->arch.crypto.pqap_hook(vcpu);

Can that callback also return -EOPNOTSUPP to order to drop to user
space?

> +}
> +
>  static int handle_stfl(struct kvm_vcpu *vcpu)
>  {
>  	int rc;
> @@ -878,6 +926,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
>  		return handle_sthyi(vcpu);
>  	case 0x7d:
>  		return handle_stsi(vcpu);
> +	case 0xaf:
> +		return handle_pqap(vcpu);
>  	case 0xb1:
>  		return handle_stfl(vcpu);
>  	case 0xb2:

