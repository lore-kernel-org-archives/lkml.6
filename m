Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D1C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F78B2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="J7zQK+bE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F78B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeIFOUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:20:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41695 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeIFOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:19:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so10638834wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UdrJBcc/wDSrhbiignQWopErYZsyvodm6m2JMPXWPbI=;
        b=J7zQK+bE8ubbfUNuknxE+FRucx66N2zgH0NHlf6G/yVVQ3skBUoykqnzHncBn/949G
         TXC88a5DnNTlt7RrOTRBdWwJnx6grMiU4QYut/oh2tuH00TT6tlojjw8jztKEoWX9jPI
         aP8REjOhp1hRFsEgnpGO6ieasfsPeAjnlm10SzbGgA/BlpacYq0CvWsZpdqV1S66fqI2
         82AhSwlCZqDjk+gFmdAmhEUrMQCEj1V3Mn1gWME2w7MZkA9b5najPi6WyMLZAY9DMahM
         XiqqtmzI2qb5cgjF2n2Xocs1RvrOeAYr9ehVquRbFEOD5AJc8i554lDRt0NxI7e2ME9g
         l0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UdrJBcc/wDSrhbiignQWopErYZsyvodm6m2JMPXWPbI=;
        b=oW2wKwj1TJGb8/lu4lRZPkBWvQbQPEU3daj2jyKTaj9dsyet75sPSLmqNg3EZDoTzs
         X1aTLSiZ6U9JjADHi+HXwQ94xsC+MogT27HU686P7OA4PPYzCO7Em7l0TEAnqnZD5VNZ
         SrQpu2W/BbrpMycm4qviMhPQ6IYd/615oB1zeqe4/NfxVQUTK8ZeV04T0ADEy7my86Hl
         9pqp59Nk0Ogw9by9oAja4sMxhWbgXzOCnAxcrNLb2V8SSV9IK1wEvgFUaQO1jIkGlyw/
         g/Zbx6w1zvL4fVViFC2s8aZVAXBGepRdrfsdJnQfLwzt9sPqkAHXFI8T3adicPYWLeJ9
         +vpg==
X-Gm-Message-State: APzg51Dx+weGimrI5MOgPh7XqM2pbGkBRKF+5iJdvzk89WNstx1o230/
        QwMBaw4Ea9nlvfKby75BTLwSHodR0W0C1w==
X-Google-Smtp-Source: ANB0VdY+ySTmiSV1UlX6eeKg9Ns4S2tXA9FXwy+1dolQG43V49H9F41EGYnA2MIBKg3NfK0q3eFJUw==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10-v6mr1620054wrt.48.1536227105857;
        Thu, 06 Sep 2018 02:45:05 -0700 (PDT)
Received: from localhost (smb-adpcdg1-01.hotspot.hub-one.net. [213.174.99.129])
        by smtp.gmail.com with ESMTPSA id e133-v6sm8325240wma.33.2018.09.06.02.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 02:45:04 -0700 (PDT)
Date:   Thu, 06 Sep 2018 02:45:04 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 19:10:17 PDT (-0700)
Subject:     Re: [PATCH v7 0/5] riscv: Add support to no-FPU systems
In-Reply-To: <1535332075-5727-1-git-send-email-alankao@andestech.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        albert@sifive.com, Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, greentime@andestech.com,
        vincentc@andestech.com, zong@andestech.com, nickhu@andestech.com,
        alankao@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     alankao@andestech.com
Message-ID: <mhng-e6132f52-a57b-482e-8fed-03e3b6f0ee93@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2018 18:07:50 PDT (-0700), alankao@andestech.com wrote:
> This patchset adds an option, CONFIG_FPU, to enable/disable floating-
> point procedures.
>
> Kernel's new behavior will be as follows:
>
> * with CONFIG_FPU=y
>   All FPU codes are reserved.  If no FPU is found during booting, a
>   global flag will be set, and those functions will be bypassed with
>   condition check to that flag.
>
> * with CONFIG_FPU=n
>   No floating-point instructions in kernel and all related settings
>   are excluded.
>
> Changes in v7:
>  - Remove "fd" attribute from KBUILD_CFLAGS.
>
> Changes in v6 (PATCH 0005 only):
>  - Make the flag checking neater.
>
> Changes in v5:
>  - Invert the polarity of checking flag from no_fpu to has_fpu.
>
> Changes in v4:
>  - Append a new patch to detect existence of FPU and followups.
>  - Add SPDX header to newly created fpu.S.
>  - Fix a build error, sorry for that.
>  - Fix wording, style, etc.
>
> Changes in v3:
>  - Refactor the whole patch into independent ones.
>
> Changes in v2:
>  - Various code cleanups and style fixes.
>
>
> Alan Kao (5):
>   Extract FPU context operations from entry.S
>   Refactor FPU code in signal setup/return procedures
>   Cleanup ISA string setting
>   Allow to disable FPU support
>   Auto-detect whether a FPU exists
>
>  arch/riscv/Kconfig                 |   9 +++
>  arch/riscv/Makefile                |  19 +++---
>  arch/riscv/include/asm/switch_to.h |  12 +++-
>  arch/riscv/kernel/Makefile         |   1 +
>  arch/riscv/kernel/cpufeature.c     |   8 +++
>  arch/riscv/kernel/entry.S          |  87 -----------------------
>  arch/riscv/kernel/fpu.S            | 106 +++++++++++++++++++++++++++++
>  arch/riscv/kernel/process.c        |   6 +-
>  arch/riscv/kernel/signal.c         |  75 ++++++++++++--------
>  9 files changed, 196 insertions(+), 127 deletions(-)
>  create mode 100644 arch/riscv/kernel/fpu.S

Thanks!  I'll add this to our for-next branch.
