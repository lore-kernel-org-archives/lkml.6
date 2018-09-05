Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E450C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E5C20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5+AQssG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E5C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIFACI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:02:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33301 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIFACI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:02:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so8890962wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jh5d8IZRUSqO7xwY64g8LgHRPGG2ehaSE8aoN7ZIH8I=;
        b=I5+AQssGLEaX9wCRBaeTdbl+j4HJRpmgQ9bStTmnPceoMw1d/3rWtjnWhbwUdbcplR
         8ePmc/e9F8r71v+n06nYpMMKGiqRsjb/t2Owl4+lEhYP0t6Sk/njy4TSEIiFBJe2nLMD
         lesbueZIV65/hurCU4gC35qEPme0z6W6S92L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jh5d8IZRUSqO7xwY64g8LgHRPGG2ehaSE8aoN7ZIH8I=;
        b=QycDoitOI+Lzmf1VXUxHeiHUiMKLSyEoMMgI9JDQPbjfz+TfhgflZvVR8/o4apExUO
         1HI08N5ijeekB4Ymw3eDr3plChaNduLV4OZ/ppEIyLXKOQ6KUqVtvbkv3hyYI0EhbHIu
         4+MsExXhgrBXiIbyYujFfjU7YSTWV3rMz9UFg5hPiB68BUwDU1hxgpxgZ83zz97Kjwe0
         w11jhVj1kbBXDfWm96jCETc4hcbeA2Us5k23a0RUrGzrQAF4ykxnJCcMwfBrC3Z+acrt
         GUe0CFgwir9YWzRTp5GlsUN3Is1VpuDvCdctllAslMN/K03XiApbsxMHg4fR8sDgOuKy
         WdEA==
X-Gm-Message-State: APzg51Dh9kLm+MIiyatx5fI/IX4Dwgeag+9F/uFndB6yoF0WMXhIfg/6
        J8+VYQgWK6Ez54QJK6xdrdmMBg==
X-Google-Smtp-Source: ANB0VdaLg7XxWEZNoUTWmhZkDcEiT54oRU9QNq6aTUQsQwDvlXBntO1cnFDpGKXHaBvRpZxtJi9ipg==
X-Received: by 2002:adf:b112:: with SMTP id l18-v6mr28986883wra.101.1536175831131;
        Wed, 05 Sep 2018 12:30:31 -0700 (PDT)
Received: from bivouac.eciton.net (bivouac.eciton.net. [2a00:1098:0:86:1000:23:0:2])
        by smtp.gmail.com with ESMTPSA id d12-v6sm3847053wru.36.2018.09.05.12.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 12:30:29 -0700 (PDT)
Date:   Wed, 5 Sep 2018 20:30:28 +0100
From:   Leif Lindholm <leif.lindholm@linaro.org>
To:     Grant Likely <grant.likely@arm.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, olof@lixom.net,
        scott.branden@broadcom.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, agraf@suse.de,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] efi_stub: update documentation on dtb= parameter
Message-ID: <20180905193028.4vhqtlwwgvqq6v26@bivouac.eciton.net>
References: <20180905190750.4566-1-grant.likely@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905190750.4566-1-grant.likely@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 08:07:50PM +0100, Grant Likely wrote:
> The dtb= parameter is no longer the primary mechanism for providing a
> devicetree to the kernel. Now either firmware or the boot selector (ex.
> Grub) should provide the devicetree and dtb= should only be used for
> debug or when using firmware that doesn't understand DT.
> Update the EFI stub documentation to reflect the current usage.
> 
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>

Acked-by: Leif Lindholm <leif.lindholm@linaro.org>

> ---
>  Documentation/efi-stub.txt | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/efi-stub.txt b/Documentation/efi-stub.txt
> index 41df801f9a50..833edb0d0bc4 100644
> --- a/Documentation/efi-stub.txt
> +++ b/Documentation/efi-stub.txt
> @@ -83,7 +83,18 @@ is passed to bzImage.efi.
>  The "dtb=" option
>  -----------------
> 
> -For the ARM and arm64 architectures, we also need to be able to provide a
> -device tree to the kernel. This is done with the "dtb=" command line option,
> -and is processed in the same manner as the "initrd=" option that is
> +For the ARM and arm64 architectures, a device tree must be provided to
> +the kernel. Normally firmware shall supply the device tree via the
> +EFI CONFIGURATION TABLE. However, the "dtb=" command line option can
> +be used to override the firmware supplied device tree, or to supply
> +one when firmware is unable to.
> +
> +Please note: Firmware adds runtime configuration information to the
> +device tree before booting the kernel. If dtb= is used to override
> +the device tree, then any runtime data provided by firmware will be
> +lost. The dtb= option should only be used either as a debug tool, or
> +as a last resort when a device tree is not provided in the EFI
> +CONFIGURATION TABLE.
> +
> +"dtb=" is processed in the same manner as the "initrd=" option that is
>  described above.
> --
> 2.11.0
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
