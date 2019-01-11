Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AAA20675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RxeDdcnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfAKGHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:07:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33811 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfAKGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:07:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so6295349plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 22:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ITc9OIf9pik7euIoiRYxplAS/DUu6fViAaIU4Z7ph84=;
        b=RxeDdcnHkS68BD5rjl6DbKx6jn5eTM45xn+iaTtbm+WkOhA2psmuNaPRT4mDSwqw6w
         qgtQmvdiuBdoFsb+N4O2EH9JjQIxrQsdODm9vp0sHCVa96C4bNiRw/COesPFd5KBzTlb
         WMAUdZtiBZVim1QihlcNwyh0IISoMyqbnJTiOt/dzjlaE/+mAbZQjW92CeHHivHkTjKt
         t9NnyA8LzaLvsIBYvt5Q+BC+X63dOIWnG0uGN7kfFN+St+iQjswA41liPDvjb5EM8fl6
         NG48HNdEGGpXnSGwTXpKEZJp7VFqv3865uFDzT40Ain0dSqK+GEcCzJnRC758aniFEdB
         G2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ITc9OIf9pik7euIoiRYxplAS/DUu6fViAaIU4Z7ph84=;
        b=FE1HXNdZifp8iJNpLZNewoChHC51HkgxkaLR27guSeAkEn6n1o+K6NlHiwGj4vzrnV
         2z+u4RskIGCjYIfpWKtLd2tpEQtSr+lHSZJ475N6jxLzmD5DFiH5IEr0VRd6bfLsisqY
         7d9TiY3cbvL2ub2raQQclNX5auMQzWbn7ETzX4kAvvgJn0rWLOycymCV77+hYj6w4Glh
         PwFk6XVOGoRjQBDGdwOp9t3DVE9g3OgVPYuGWj1SR/1zupS65VMcft/jdisCsD1vY55q
         W2Z0cyyG4wEfVSvyo1I8ZowDBCfarG3pPT02grbgReqIK8goXU59JE+eZ7cJBjYmqtXN
         fnxQ==
X-Gm-Message-State: AJcUukdWaHo963gCd0NPruhi6KnkFktyIPQW042D32+aUlRCYnQmhhXX
        2gDI9+arxvwA6kuNNF5qOqztuw==
X-Google-Smtp-Source: ALg8bN7qtKVwBfycm1wLyrpfQRG7Hi2Xc8xrg4UjeHy+hh/1kojkCS3yR0R+6aUghkv1pyvHXiMKEQ==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr13141874plb.46.1547186820616;
        Thu, 10 Jan 2019 22:07:00 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p7sm117530221pfa.22.2019.01.10.22.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 22:06:59 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Thu, 10 Jan 2019 22:06:59 -0800 (PST)
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "Palmpalmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RISC-V: defconfig: Enable Generic PCIE by default
In-Reply-To: <20190110193451.29016-1-alistair.francis@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1901102153570.22105@viisi.sifive.com>
References: <20190110193451.29016-1-alistair.francis@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

Looks like you're still sending patches to "palmpalmer" ?

On Thu, 10 Jan 2019, Alistair Francis wrote:

> Enable generic PCIe by default in the RISC-V defconfig, this allows us
> to use QEMU's PCIe support out of the box.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  arch/riscv/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index f399659d3b8d..ccfd3f05223c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -14,6 +14,8 @@ CONFIG_EXPERT=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_SMP=y
>  CONFIG_PCI=y
> +CONFIG_PCIEPORTBUS=y
> +CONFIG_PCI_HOST_GENERIC=y
>  CONFIG_PCIE_XILINX=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> @@ -77,5 +79,6 @@ CONFIG_NFS_V4_1=y
>  CONFIG_NFS_V4_2=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
>  # CONFIG_RCU_TRACE is not set

Not sure what commit this patch is against - I picked v5.0-rc1.  Before 
applying your patch, I generated a seedconfig with "make defconfig 
savedefconfig; mv defconfig defconfig.1".  Then applied your patch and did 
a "make defconfig savedefconfig" and then ran "diff -u defconfig.1 
defconfig".

That should have shown me just the patch above.  But it also included a 
line removing CONFIG_RAS=y.  I am sorry to ask you to fix such a nitpicky 
item, but it is good practice for these defconfig patches.  Otherwise the 
defconfig deltas gradually get out of control.

When you repost it, if you verify that the ./defconfig delta from running 
"make savedefconfig" before and after your patch applied is simply your 
patch, then feel free to add a Reviewed-by: line from my E-mail address 
above.


- Paul
