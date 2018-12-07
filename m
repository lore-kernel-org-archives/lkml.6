Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D6EC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E4220672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HS7T7XYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E4220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLGSae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:30:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41290 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeLGSac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:30:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so2323840pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=R9PUU0FNjTSFmRmOZPuikthkbKAg6d5AV4SisW2jsDs=;
        b=HS7T7XYQ8aSTb3k0jPHZuYP59cXKfdSK3+6dfe5Y/LfrLOzdEzqkQUwmrzYv5/4+41
         9OI5yukbDg8tyWwW8eS4do/1SS7jfnCkRE/ba4Je0ejBWCYtrfSTH5v0xrJJrTDAYPit
         VrgWKVXE0Cwf5YIq3d0hHmm2AUdlUG3Asy44BLBWx+MK/S3aisfA6lCNAiLY/R4lI4e1
         CEGF1Kb0+y8vk09x6hEHmxsr6Rb6cs5PEcwerk0YuKR/r1ElewYqSXoK+w3ClSTibOVB
         Pmt9nLKY69G/0rJ6QNHBQlrct4oKiENvWkdxX4WvzzPeC/u6HHv/0JD8SEO2RY9P6hVE
         cTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=R9PUU0FNjTSFmRmOZPuikthkbKAg6d5AV4SisW2jsDs=;
        b=mftwEnzg6Bc1vo6awFiVT/u+OVMEua3fNjfpKSs7GqBb+zenaVTRwjl4iUmhlqpd6K
         GdZqabKfE+htO18yrjTx8rPwXTuUWGoWokYiGKbYyNJQ/+J7wup83Udx3tlh1iysHjKf
         oidFkZJKN0PHX5ATTYCCH+/xV94Y1LezTRJw7Ts+GgEW1S7QoG3GCQyTOzg5HLbODa0o
         iZi/juNktbjZm6ejNFhe846s5uu95ZzlzWb3mV01O5GRyGkJ3YQY7gFX07fa/gI2oTwx
         FmxN88EQbWiAJcMPuxFMyldM1ViySXC+t82hd5iiS5WIVjCwG1Uxmztxsnsbz6H/Kgze
         RWWw==
X-Gm-Message-State: AA+aEWbujNbR12vugq77ZFeP3eaVd4AGdwhDYW6n2QApdX/fPJ+EeXEl
        Q8tHFsy9bUfceZhgCvMzIkM5DA==
X-Google-Smtp-Source: AFSGD/U04cLTf3NhnXZ/uxjhcDVRmAe/A414or6dW+sVRh4tbHY/hOzm5qc3027mjItIGLVgvUNQuw==
X-Received: by 2002:a62:824c:: with SMTP id w73mr3284033pfd.150.1544207430782;
        Fri, 07 Dec 2018 10:30:30 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id t21sm5268636pgg.24.2018.12.07.10.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:30:30 -0800 (PST)
Date:   Fri, 07 Dec 2018 10:30:30 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 10:20:29 PST (-0800)
Subject:     Re: [PATCH 2/3] RISC-V: defconfig: Enable RISC-V SBI earlycon support
In-Reply-To: <20181204135507.3706-3-anup@brainfault.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-7d4e0657-9343-4a8d-b24a-3ea0acba45db@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018 05:55:06 PST (-0800), anup@brainfault.org wrote:
> This patch enables RISC-V SBI earlycon support in default defconfig
> so that we can use "earlycon=sbi" in kernel parameters for early
> debug prints.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index ef4f15df9adf..f399659d3b8d 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -46,6 +46,7 @@ CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_HVC_RISCV_SBI=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_DRM=y

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
