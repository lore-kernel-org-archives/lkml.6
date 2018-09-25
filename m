Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2691C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8646320684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tyt90W4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8646320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeIZCLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:11:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeIZCLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:
        Subject:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wJ3ghOv44Ze7hWxabIvIqFmvpibAuwCLhoXsjP9Zu7g=; b=Tyt90W4VNzdLqwlKFODC4Zxr8
        MkgSAtZd6AduVB3GZ/rZNytIBk5GCfKsHBdd/rs8hq8fBOxINsToIATiwOh3mwe9FzVEzSDigvpjJ
        kyIiqXOBYCYAe35edxb+Dzu67EYMpgsdg8KB3oPxGJuJOX5tCZdscNGi8lei1Lszkpke6MuVBpAxV
        kzmpSQhy53m8oWQTuhRiiBD1Jh8gEyM/S0WUOFzF2RfIctPH5QWe7Fa0PAUTtJq+MCXcxM02YTiiH
        ILVim/qCNwH74jqRGOIZW0n1VkjKwEhvCxaxZSrS4+ayL3t7UJBHFxKPBchPnpjLTL3vfVy0yB/NK
        l088uIKHQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4tWo-0000iv-M1; Tue, 25 Sep 2018 20:02:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v14 11/19] x86/sgx: Add wrappers for ENCLS leaf functions
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-12-jarkko.sakkinen@linux.intel.com>
Message-ID: <a2d77169-5c14-10f0-425f-41e37f791ece@infradead.org>
Date:   Tue, 25 Sep 2018 13:01:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925130845.9962-12-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 6:06 AM, Jarkko Sakkinen wrote:
> Add wrappers for Intel(R) SGX ENCLS opcode leaf functions except
> ENCLS(EINIT). ENCLS invokes privileged functions for managing (creation,
> initialization and swapping) and debugging enclaves.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/sgx.h | 244 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 244 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index f4f82f0453a9..e66e2572011e 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -10,4 +10,248 @@
>  extern bool sgx_enabled;
>  extern bool sgx_lc_enabled;
>  

Hi,
Please don't use "/**" to begin comment blocks that are not kernel-doc
notation, like the 3 below.  Note: I might have seen one (or some) of
these "fixed" in other patches in this series (not sure).


> +/**
> + * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
> + *
> + * ENCLS has its own (positive value) error codes and also generates
> + * ENCLS specific #GP and #PF faults.  And the ENCLS values get munged
> + * with system error codes as everything percolates back up the stack.
> + * Unfortunately (for us), we need to precisely identify each unique
> + * error code, e.g. the action taken if EWB fails varies based on the
> + * type of fault and on the exact SGX error code, i.e. we can't simply
> + * convert all faults to -EFAULT.
> + *
> + * To make all three error types coexist, we set bit 30 to identify an
> + * ENCLS fault.  Bit 31 (technically bits N:31) is used to differentiate
> + * between positive (faults and SGX error codes) and negative (system
> + * error codes) values.
> + */
> +#define ENCLS_FAULT_FLAG 0x40000000
> +
> +/**
> + * Check for a fault by looking for a postive value with the fault
> + * flag set.  The postive value check is needed to filter out system
> + * error codes since negative values will have all higher order bits
> + * set, including ENCLS_FAULT_FLAG.
> + */
> +#define IS_ENCLS_FAULT(r) ((int)(r) > 0 && ((r) & ENCLS_FAULT_FLAG))
> +
> +/**
> + * Retrieve the encoded trapnr from the specified return code.
> + */
> +#define ENCLS_TRAPNR(r) ((r) & ~ENCLS_FAULT_FLAG)

thanks,
-- 
~Randy
