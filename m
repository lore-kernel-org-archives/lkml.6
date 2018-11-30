Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E6320834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZHH3Y6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E6320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeK3TrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:47:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37114 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK3TrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:47:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so4423918wru.4;
        Fri, 30 Nov 2018 00:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C82bH1FDhv5NPnnr4H+vnUVjIKfgo9MbVdUJs+R9BII=;
        b=VZHH3Y6vAWLKIsjpxgNY3fnrvzwQwQEW0uo9/e7rlB3s8ENiiKIfZePIXVtfqnpcBm
         m00zxkirL71k42+IQ3zPFBER+7HABxgiejuPtgdWkYSm+bbuqbMs2W7eP4/cLDhWGH+O
         Txz08lTQYsymrcVmwjvbMSvM/oHWGKTCC2JjH54gNJe9iUw7W2kwoOwP679e16WSbmLL
         /mLNdXoudbDYIDd2hU12url98pamoJk5rh+Rcr1LPPd1nXF9nez1bv1SavOT12SAd/CP
         sCpYRC9JBAyLoxszsppmS85n55iko4gt2/7xpvPp/DyxAjyRSiJJcaLvWbp/OOgYc0fr
         GQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C82bH1FDhv5NPnnr4H+vnUVjIKfgo9MbVdUJs+R9BII=;
        b=ebiaNEax7sk7qKZHC5FpeqdxxdobPDzGXPl3MGVm39tWupUbw+Cln8QDUhzCI9ELeT
         VpWYnnTM6aqg762SLVz4jQsZbl0wDctHvAmoEFox1IsNygwHQQ3wADCNJSTBq19c9KB/
         MCWM9xiUX4jbwHG6+ZO0rn+u1lFM5uBkyy/1URX7E0Rhl2T7y2CMUnFEQ9L0tpSYcNpn
         kE2kcjhk7Yus4to72e4tyjOmYni3YObMKChO0Jm5xfh9fQjiqiwVL21bwygoCl8eD9VM
         kSY5srVmxWAgixv1okXi3mv9UDO5A0BGg/l7IONhgWgZcPuFTEpVSU75RVF0MUDCIGHU
         dbng==
X-Gm-Message-State: AA+aEWYqBRZZjNKe/clxTQqa4JovH5oHr2ybhRF+hcK1Da4XKUb9C5bz
        TF5q/kASnJzbPs191648mRg=
X-Google-Smtp-Source: AFSGD/Wln0u/4vQ+f8bplyMpWOqIxeaJotnq9ob8Fp6OBl9AUV/6c76EitDSNL86nae7tMOAQ3iB5w==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr3940666wru.33.1543567106590;
        Fri, 30 Nov 2018 00:38:26 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g67sm4508057wmd.38.2018.11.30.00.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 00:38:25 -0800 (PST)
Date:   Fri, 30 Nov 2018 09:38:23 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: Re: [PATCH 10/11] efi: reduce the amount of memblock reservations
 for persistent allocations
Message-ID: <20181130083823.GB97998@gmail.com>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-11-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181129171230.18699-11-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> The current implementation of efi_mem_reserve_persistent() is rather
> naive, in the sense that for each invocation, it creates a separate
> linked list entry to describe the reservation. Since the linked list
> entries themselves need to persist across subsequent kexec reboots,
> every reservation created this way results in two memblock_reserve()
> calls at the next boot.
> 
> On arm64 systems with 100s of CPUs, this may result in a excessive
> number of memblock reservations, and needless fragmentation.
> 
> So instead, make use of the newly updated struct linux_efi_memreserve
> layout to put multiple reservations into a single linked list entry.
> This should get rid of the numerous tiny memblock reservations, and
> effectively cut the total number of reservations in half on arm64
> systems with many CPUs.
> 
> Tested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/efi.c | 20 +++++++++++++++++---
>  include/linux/efi.h        |  3 +++
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 80b11521627a..e90bc32c2670 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -998,7 +998,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>  {
>  	struct linux_efi_memreserve *rsv;
>  	int rsvsize = EFI_MEMRESERVE_SIZE(1);
> -	int rc;
> +	unsigned long prsv;
> +	int rc, index;
>  
>  	if (efi_memreserve_root == (void *)ULONG_MAX)
>  		return -ENODEV;
> @@ -1009,11 +1010,24 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>  			return rc;
>  	}
>  
> -	rsv = kmalloc(rsvsize, GFP_ATOMIC);

I fixed the following build warning in this patch:

  drivers/firmware/efi/efi.c:1000:6: warning: unused variable ‘rsvsize’ [-Wunused-variable]

'rsvsize' got entirely orphaned by the patch, so it can be removed.

Thanks,

	Ingo
