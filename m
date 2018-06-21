Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB914C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F02219EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OlWGC0o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F02219EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeFUSUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:20:05 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46703 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754131AbeFUSUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:20:04 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so2091495pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=cVoXuB62/yGkD7A9oBRZ4Mpn5hDyMaimHNGhKwOVLMQ=;
        b=OlWGC0o88NjTbBSad+te3MnazNK81PRFUN6H74ftze4xfwbojPwIcKfGQ5/KeTSDSd
         kAW0e7+jzThDIqeAs/lKXNXdySocVmIMa9957cq8tuw9RjElL0i72gfK5dUQRC4gui3h
         g7dU3qAJ2xfIj5UKqHjk1rgXGrL3jr/hiE+Z61imerGAdRfbEDvq66KJ7Hru6pZkgGuP
         9pWwZRn7kNCbEmaupHsa+Q/QKVxJam132iuUC5ArXNr6r5BByZqaujGaumdyb4Jq1N3Y
         mB6A1tS1/y0l2ZpXVB2UBCsde8jamXcDvHpcBw1GNrtCF8vwkelQ2kifeoXkET8Rb59I
         jjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=cVoXuB62/yGkD7A9oBRZ4Mpn5hDyMaimHNGhKwOVLMQ=;
        b=UZMaOSPR9yo4zComh8vufKWypgggxbqsluLgjF/h+lg8yi6IGAKOb4B9abkL4PTUO0
         +1FkyN4aD0aFGstafIwwSWs8UZQNUGrGvxYTSaI512EhxJk1b5CyDvc5ZA8j50ZyJwIp
         2H+kIsfZmf4Hcu9u2zUhNpEJPAUdX9SC4f/63YInAxsnvswCffWpOuQmKi/xoUNV0OI+
         vX6udv73dp+eGHFk91pVCucN6H/clxPK29FC82Kaj6lun8gFN+VPWk9o3HGvKfiIBvNF
         LgViVU6HQSQOiDOCB939tvSDvKR6mDcOZHj3eR4C4XiSZ4Ti2Rg1RIGN2zFMYQMEO+Ww
         UPYA==
X-Gm-Message-State: APt69E1nDvSEUjmVwaQ1riEn6Kuv63HvnFMEfT7sbMrYslA7Cjjv7hXL
        fVvQfNbVuTIPcb0MHDYuPY+5hg==
X-Google-Smtp-Source: ADUXVKKk+3LZ1h//pXFdps5AYHkzEv0e4W+Qg2sT6mqi5RHkHf5gDHjV9V6JhLg5pI1qZtBvMvGTdw==
X-Received: by 2002:a17:902:7898:: with SMTP id q24-v6mr29456031pll.254.1529605203505;
        Thu, 21 Jun 2018 11:20:03 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x24-v6sm13241131pfj.104.2018.06.21.11.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 11:20:02 -0700 (PDT)
Subject: Finish the GENERIC_IRQ_MULTI_HANDLER conversion
Date:   Thu, 21 Jun 2018 11:17:51 -0700
Message-Id: <20180621181756.12493-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        arnd@arndb.de, keescook@chromium.org, vladimir.murzin@arm.com,
        nicolas.pitre@linaro.org, jinb.park7@gmail.com,
        yamada.masahiro@socionext.com, alexandre.belloni@bootlin.com,
        palmer@sifive.com, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        jhogan@kernel.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago I sent a patch set that adds a GENERIC_IRQ_MULTI_HANDLER,
which is an exact copy of the existing IRQ_MULTI_HANDLER support in the
arm port, which is being used unconditionally by arm64 and openrisc.
GENERIC_IRQ_MULTI_HANDLER is currently being used by the RISC-V port.  I
managed to make a few mistakes in my original patch set and as a result
my conversion of the other architectures of GENERIC_IRQ_MULTI_HANDLER
was dropped.

This patch set finishes up my original patch set by converting arm,
arm64, and openrisc over to the new GENERIC_IRQ_MULTI_HANDLER support
and then removing MULTI_IRQ_HANDLER as it's obselete.

At the time I wrote this I gave it fairly extensive build testing, but
went I recently rebased it I just tested the full patch set on arm,
arm64, and openrisc defconfigs.

Various flavors of this patch set have bounced around a few times
before, but I'm calling this a whole new patch set as it builds on top
of what was merged.
