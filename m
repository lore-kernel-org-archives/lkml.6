Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED478C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21FD2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKtGzEFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21FD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeK3TOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:14:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40468 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeK3TOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:14:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so4323720wrt.7;
        Fri, 30 Nov 2018 00:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aKo+gdEJ+yw0zLyjfpkqEWdk787xl66RK3neQbFIi9g=;
        b=tKtGzEFcNsLU8NUpY71OTx8kmJGs4gO8MjK7oKpFUOH8sGTtBdwSnN+5NM1VGCbZ6d
         pI0lqbDfMK6PcqwGULkCEap/5AGck7RAs7gm4aJCNkwqt6T7rkgewx1pmt5zjFKQ+fr4
         qaj9uwL8aF/NiObRnVHO8Hugi1tKGI/rljqQd0hKwBHpbfnlwAf2wVhOUUQdlV6t3hSk
         hQOQQVNI5RGpjaApVM+uPMTXpkRDzfOUK6OXX1ab72PZ4EkB2+hVG0aeesExm4RB68M/
         5L1e3ZJKUR9jMcuixYHMJZ241PFohfvZ5FSTlM6tu+4pRy02GthgsihZUfZnnHOiIjzL
         1bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aKo+gdEJ+yw0zLyjfpkqEWdk787xl66RK3neQbFIi9g=;
        b=NL5HkmzUMt1ssB44Bqj5O5zzJd+J5EE98RqjP2bOiZ5Nqg2N+0txjaJhrsJ49lrLny
         jN9BSK5nGqUInk4QnhGNGkRDMoW5c+HEBmhnz6v6bhGDuSTovauSZ5whrAMwfsH+WYQA
         dnupiO6pPWL8RH4rEUqVCO3NH/JapE2fcjutBIgs+MLJ62GnbpQHolw/FnG34LHBxVuO
         E60X8B/3WQDiusepJkqUSjiqQT3GIyiMZ1bJLIOEIHkRenPYzvcBTistHZliiVo8BT8Q
         Z89B4ORYkxRP3Xu4baBvYnF85tPdBhKWxFM5+VxjywrTGd+XMli3j8TR9zxUhizba+1f
         MGhQ==
X-Gm-Message-State: AA+aEWaYJEp1W0l1UwMhEGMRj/ScGDrEoNg4PaY7zBwIdd/+sN8rHnyT
        uU8DLtBB8XDsiTaus95ZeSc=
X-Google-Smtp-Source: AFSGD/Xp4Ug86x2nUn7hiyyLkRWbrNFvmKl9pFiJ6xvRj3Xl2psrD1Fe+OTTUgKGoVuXc+fG1L8s9Q==
X-Received: by 2002:adf:81c4:: with SMTP id 62mr3791400wra.266.1543565147800;
        Fri, 30 Nov 2018 00:05:47 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j33sm6886205wre.91.2018.11.30.00.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 00:05:46 -0800 (PST)
Date:   Fri, 30 Nov 2018 09:05:44 +0100
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
Subject: Re: [PATCH 11/11] efi/x86: earlyprintk - Fix infinite loop on some
 screen widths
Message-ID: <20181130080544.GC16084@gmail.com>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-12-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129171230.18699-12-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> From: YiFei Zhu <zhuyifei1999@gmail.com>
> 
> An affected screen resolution is 1366 x 768, which width is not
> divisible by 8, the default font width. On such screens, when longer
> lines are earlyprintk'ed, overflow-to-next-line can never trigger,
> due to the left-most x-coordinate of the next character always less
> than the screen width. Earlyprintk will infinite loop in trying to
> print the rest of the string but unable to, due to the line being
> full.
> 
> This patch makes the trigger consider the right-most x-coordinate,
> instead of left-most, as the value to compare against the screen
> width threshold.
> 
> Signed-off-by: YiFei Zhu <zhuyifei1999@gmail.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/x86/platform/efi/early_printk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
> index 7476b3b097e1..7138bc7a265c 100644
> --- a/arch/x86/platform/efi/early_printk.c
> +++ b/arch/x86/platform/efi/early_printk.c
> @@ -183,7 +183,7 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
>  			num--;
>  		}
>  
> -		if (efi_x >= si->lfb_width) {
> +		if (efi_x + font->width > si->lfb_width) {
>  			efi_x = 0;
>  			efi_y += font->height;
>  		}

Any objections to marking this for -stable and queueing it up in 
efi/urgent as well?

Thanks,

	Ingo
