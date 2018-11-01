Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B53C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D9F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eWEHfWku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D9F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeKBC6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:58:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41388 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeKBC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:58:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id p16-v6so3148305plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9KgwBlYpYDkghRGbPCHP71HsA3TMqpUT3WsqDusrMYM=;
        b=eWEHfWku09Oh9mfUM3m0afw2+BjOK0rOuP3lTPJBBLjivYqymLcd6h6tKZ7ULVXK8e
         53ZkASc4vufLxVuVFyJiZGcZr5uKIiPd9eRoUyDbIMQSwRlRhkh4rg0WCVraHZ4FE/Sq
         HIcuIsLWX60wxUfgrY+EpNYKHBNPiH0v9mJS+gtMzH7OO0UBQ7yTQN0KXGO7i2UZAZ2x
         jazxCOPbi7dJVFgSFFMXku4bgEhtj3ZfJpv/3yDNB62udmTF9nAzqh21bfANFFNu/+kK
         2XW9371WZPnv4XM82wzeoR58XN8xIwa7dXogaCkBP9dS2D3QcpjkVYFhT3AiDs7VA2Qt
         hvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9KgwBlYpYDkghRGbPCHP71HsA3TMqpUT3WsqDusrMYM=;
        b=CXVeZ83jr7s5Of70Ff21MTmrBfx6GVJN/01Sol7TDMPtPoml3lX2rhp20Xpmmimfu8
         0p3zozvnL9uuvIjFrKR9KmzEkjUAMmspLO1niiEKBLpEwl47BLfqdut3p87coF0qyhbB
         /gff7sSVj05Q9sGvDSqIrSGxYQt25ZslwiZ8hpS2WXE+PS+HsIuev71sar6D+lIDHAgu
         lBCntOunKKHPX72JSs4kWR4LptbS50dk0OBl6CBgelCHVg0ZqPBhqtN2VGWJhHYFAbc9
         ZB4mI9RvFJQrFh1fCeF0mgelTyjPk2hvfMJ8ybABevunHkCWAIb1Ka+WompuIfMBCkfu
         hmvw==
X-Gm-Message-State: AGRZ1gLX7sAGbv5EFz/OkQOzxIKBEoSbHpfpPjL8fufTz1i9MhwHCgF3
        76P2C0zfReHA9bUVcEKFzT71lQ==
X-Google-Smtp-Source: AJdET5dAzdlnjsHIdNaxLOOtev7t4PpKsdc2pwkvDY9v/6gCdRpfznXL8YTtW1Y2RrF9gTumkvBKSA==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9-v6mr8651330plm.311.1541094886490;
        Thu, 01 Nov 2018 10:54:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h25-v6sm31549892pgv.27.2018.11.01.10.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 10:54:45 -0700 (PDT)
Date:   Thu, 01 Nov 2018 10:54:45 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Nov 2018 10:53:15 PDT (-0700)
Subject:     Re: [PATCH v2 1/2] RISC-V: refresh defconfig
In-Reply-To: <20181101051033.10089-1-anup@brainfault.org>
CC:     aou@eecs.berkeley.edu, Olof Johansson <olof@lixom.net>,
        atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-aa34e7bb-f14c-4fc8-8ff6-cb70ba397746@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 22:10:32 PDT (-0700), anup@brainfault.org wrote:
> This patch updates defconfig using savedefconfig on Linux-4.19.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/configs/defconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 36473d7dbaac..07fa9ea75fea 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -1,6 +1,3 @@
> -CONFIG_SMP=y
> -CONFIG_PCI=y
> -CONFIG_PCIE_XILINX=y
>  CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
>  CONFIG_IKCONFIG=y
> @@ -11,10 +8,15 @@ CONFIG_CFS_BANDWIDTH=y
>  CONFIG_CGROUP_BPF=y
>  CONFIG_NAMESPACES=y
>  CONFIG_USER_NS=y
> +CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> -CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BPF_SYSCALL=y
> +CONFIG_SMP=y
> +CONFIG_PCI=y
> +CONFIG_PCIE_XILINX=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> @@ -59,6 +61,7 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
>  CONFIG_VIRTIO_MMIO=y
> +CONFIG_SIFIVE_PLIC=y
>  CONFIG_RAS=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> @@ -72,8 +75,5 @@ CONFIG_NFS_V4=y
>  CONFIG_NFS_V4_1=y
>  CONFIG_NFS_V4_2=y
>  CONFIG_ROOT_NFS=y
> -# CONFIG_RCU_TRACE is not set
>  CONFIG_CRYPTO_USER_API_HASH=y
> -CONFIG_MODULES=y
> -CONFIG_MODULE_UNLOAD=y
> -CONFIG_SIFIVE_PLIC=y
> +# CONFIG_RCU_TRACE is not set

Oh, sorry, I sent my version before seeing yours.  Looks like they're exactly 
the same, which is probably a good sign.  I'll send this one instead.
