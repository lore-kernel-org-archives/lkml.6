Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BC62089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BiHufblN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BC62089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJPGVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:21:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33118 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeJPGVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:21:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id 78-v6so8009638pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=EHz6jgAQmTeDEBKb0A3itU/6VsYN88Cy2bgc1nZfrBU=;
        b=BiHufblNRuAO8l/QI+G10pfhPcIocjyF7Gl2YIo0oBHvnBQaoXOhOPUlW9TwzILGps
         DZMj6PV8zi1uqALp4Y5V258eDQp89DrUkszN4UDPlzBF+YBcqrhboE3P1NFDNe6lWrhu
         WmA9oK4UaKxHxT2mL8ZWQCeIp3l7jwEpyyfDJU4O8n5NeD+BC3lxsBuoirUTKUamgU48
         /Gf5ZNLwh81EFZbun90mu43KXM+lgF7MCkzOd6sm6/WF4bKzyHppNKg06F7eYpKdrS18
         AgSjv2jKbUeBLmmDbXHd/BhRnkVYrQuy2rI4fTeM4WPC9QvR5B1Ozz23TBCc//VnyMpO
         j8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=EHz6jgAQmTeDEBKb0A3itU/6VsYN88Cy2bgc1nZfrBU=;
        b=G5WfhR/9EaMMyIjcm48XvZPUTlxJKdw1D+jg/fGDH5ukMwHubZYiCVUfdKDisiobbW
         uB58yjUs/AQnalIALFYYT+8sZkvbSJsN8Rt4DVd+wLylRw61+e7Fu7QS8IOt2r46G06T
         lKNKOHCqyWNhv+/GBm27dreN/O2+3mZf1wjDCDODu1PwAV9iwP+zNvpofQBJyXx/V34Z
         OZjkTrWOE8mohlpPG6O3wmhrGerX3Lt6FfW3vbEgF6QcuMQ3RCMZoQSrvgvgltJBIdY9
         eFxVAZc0nwe+ZFAiuFo82PBdHau1awVZ6NRe202EPaDyD2KwcFYu4pA1sM4bUbMHrqFo
         d13w==
X-Gm-Message-State: ABuFfoj/yq+WD4OsHVCS/c0CIu0Va7tg6n0+C7nTHV04S02h+0XWDbuN
        wc9MVaTSJKkGOuIfT1rgRkcRQdT6o6U=
X-Google-Smtp-Source: ACcGV61PiBIXYmSq6ebNMDbUQdQSX8XDbEyOoGAO/1IeDXk9wA/BUqSfMfo/IJlbBBBe3ylhy8sBuw==
X-Received: by 2002:a62:6f43:: with SMTP id k64-v6mr18812896pfc.87.1539642859671;
        Mon, 15 Oct 2018 15:34:19 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v83-v6sm23514518pfa.103.2018.10.15.15.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:34:18 -0700 (PDT)
Date:   Mon, 15 Oct 2018 15:34:18 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 15:30:33 PDT (-0700)
Subject:     Re: [PATCH v8 3/5] Cleanup ISA string setting
In-Reply-To: <20181014234639.GA14835@andestech.com>
CC:     linux@roeck-us.net, zong@andestech.com, nickhu@andestech.com,
        greentime@andestech.com, linux-kernel@vger.kernel.org,
        vincentc@andestech.com, linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     alankao@andestech.com
Message-ID: <mhng-48e07863-dd56-4ef6-8342-aa19414bc1b8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2018 16:46:40 PDT (-0700), alankao@andestech.com wrote:
> Hi Guenter,
>
> On Sat, Oct 13, 2018 at 05:02:05PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> With this patch in -next applied, I get the following error
>> when building riscv:defconfig.
>
> I guess what you meant was this commit:
> commit 0a5bee05fc67ce2044b8d91a18abbf14042da531
>
> The modification in Makefile was
>
> -endif
> -
> -KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
> +# ISA string setting
> +riscv-march-$(CONFIG_ARCH_RV32I)       := rv32im
> +riscv-march-$(CONFIG_ARCH_RV64I)       := rv64im
> +riscv-march-$(CONFIG_RISCV_ISA_A)      := $(riscv-march-y)a
> +riscv-march-y                          := fd
> +riscv-march-$(CONFIG_RISCV_ISA_C)      := $(riscv-march-y)c
>
> and the ":= fd" line was wrong.  It should have been
>
> +riscv-march-y                          := $(riscv-march-y)fd
>
>>
>>
>> What am I missing ? Does RISC-V now require a new non-upstream compiler ?
>> Or a special version of make ? I am currently using GNU Make 4.1.
>
> So I sent the v8 to fix this problem.
> Sorry for the inconvinience.
>
>>
>> Thanks,
>> Guenter
>>
>> ---
>
> And Palmer, it seems that the patch that causes this build error has been
> pulled into linux-next.  Any idea how to fix that one?

If I run into the new version then I'll overwrite in in my for-next branch.  I 
don't see one, though...
