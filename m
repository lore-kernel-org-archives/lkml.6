Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63206C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD4421479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZpZsnbrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD4421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbeKVDDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:03:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45833 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbeKVDDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:03:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so6211490plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FiJirZOKa6myaADfJkWWPvVJZk+uUHJpApLtjnmWJ04=;
        b=ZpZsnbrQIkGy0yAT8hDURuztVDP4+0szesFbKkNciZGbfx74oc7Eeg45wKXs8R4tRc
         FZ+QB8Zu7mG73lcuniMYVIECgRd3gJZTlJAiU1deRHG9CkAKjusJb6L35cecs7F/Jx0t
         HMQYCPcE6BEwk/hUu+qbwBcboe//0bTF4SLhrVzpxFPJw0ycXzM3InK1g/pUhWTEJfFN
         Tcig49c6Hdiq6WoKkEIpurgVpDLwfQ0nNxPxeFkgRZM4DT7gQ8rD9Sm//KP3tvY86daU
         iPJYtm0TIx67+Y7Y4uz5CLqp8y22dWneJAqQeIEBfClKSH9H9hzzMyEEre/JS6ynsZWP
         /Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FiJirZOKa6myaADfJkWWPvVJZk+uUHJpApLtjnmWJ04=;
        b=drPsFX9K7tny0yjeJI/EgRroFGIvp3NNMP7xGt3Vlvr9d3L18ggCSliR8XPAzeDhHN
         i312GuXUO86vwaLg0CLFB8yfag/t1IgmnP9P6K5Dx3l39x5uqLiSNWjXoyHQNdWgrP/L
         l4FYh4W+AilTzqUCMLE/b8kijfDDr1yYaxhgTNyFI8ivEff5bRtbUKtPIuiD69LD3orq
         i/CPVHd484DdVVkfy2sDRVeT/pvFdVf8TXV8u1l011jDOIM4Oy91hSefxM7TlS3Dbg+Y
         29DycIuwaApIoe3jJkw7oOswrRNm5peVo2kRN9/5Mu4oO8Tx+VMlFsAw+BKZkW4eCbWj
         pi5A==
X-Gm-Message-State: AA+aEWbliV1H7vy3vO9jlbsi8StFFXRsckBmqt/BMIs3yZ8qxVxJdxAD
        ZWuAMvx56r1Hn+xlrstez74Yg/Q20Bo=
X-Google-Smtp-Source: AFSGD/WXeOS0KlX1r2RSw2QA0XrwM5Ra4HrOGvAd1oHkvZUp2UX2jEagq2U+kgLgqghDS0f1SiC1DA==
X-Received: by 2002:a65:448a:: with SMTP id l10mr6599607pgq.387.1542817690651;
        Wed, 21 Nov 2018 08:28:10 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f13sm29790412pfa.132.2018.11.21.08.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 08:28:09 -0800 (PST)
Date:   Wed, 21 Nov 2018 08:28:09 -0800 (PST)
X-Google-Original-Date: Wed, 21 Nov 2018 08:27:47 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Build flat and compressed kernel images
In-Reply-To: <CAEUhbmWskEtQR-kAuAYx=SHOJ4-MrCRUchSQ68WwZ62hxsTQyQ@mail.gmail.com>
CC:     anup@brainfault.org, aou@eecs.berkeley.edu,
        Christoph Hellwig <hch@infradead.org>, atish.patra@wdc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     bmeng.cn@gmail.com
Message-ID: <mhng-7be4f47d-bc3a-4073-a6db-dc5588304d2d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 21:06:18 PST (-0800), bmeng.cn@gmail.com wrote:
> On Mon, Nov 12, 2018 at 1:55 PM Anup Patel <anup@brainfault.org> wrote:
>>
>> This patch extends Linux RISC-V build system to build and install:
>> Image - Flat uncompressed kernel image
>> Image.gz - Flat and GZip compressed kernel image
>>
>> Quiet a few bootloaders (such as Uboot, UEFI, etc) are capable of
>
> nits: U-Boot
>
>> booting flat and compressed kernel images. In case of Uboot, booting
>
> nits: U-Boot

Thanks for the review.  The PR has already been tagged, but it's not scheduled 
to be sent out until later today.  I generally try to avoid rewriting the tags 
unless there's something major that's wrong, so unless you feel very strongly 
about this then I think I'll let it stand.

Let me know if this is a big deal for you, I can rewrite things.

>> Image or Image.gz is achieved using bootm command.
>>
>> The flat and uncompressed kernel image (i.e. Image) is very useful
>> in pre-silicon developent and testing because we can create back-door
>> HEX files for RAM on FPGAs from Image.
>>
>> Signed-off-by: Anup Patel <anup@brainfault.org>
>> ---
>>  arch/riscv/Makefile             | 15 ++++++++-
>>  arch/riscv/boot/.gitignore      |  2 ++
>>  arch/riscv/boot/Makefile        | 33 ++++++++++++++++++
>>  arch/riscv/boot/install.sh      | 60 +++++++++++++++++++++++++++++++++
>>  arch/riscv/kernel/head.S        | 10 ++++++
>>  arch/riscv/kernel/vmlinux.lds.S |  2 +-
>>  6 files changed, 120 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/riscv/boot/.gitignore
>>  create mode 100644 arch/riscv/boot/Makefile
>>  create mode 100644 arch/riscv/boot/install.sh
>>
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>
> Tested with U-Boot s-mode on QEMU virt, using bootm to boot the kernel
> Tested-by: Bin Meng <bmeng.cn@gmail.com>

I also won't include the tags unless I rewrite the tags.

Thanks for the review!
