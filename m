Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71448C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AD920855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mJDrMtkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbeL3MkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 07:40:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44492 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeL3MkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 07:40:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so24619315wrt.11;
        Sun, 30 Dec 2018 04:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cx6nexWaRg6eCyJE/QI3VG4E1ddJBjH6iuIA7/pxKMM=;
        b=mJDrMtkOvE2khBVz27brKFJEr7FRGemaOlq0JGxPjeyfv/ves5/vvUo0fj4Kn8Jhto
         W6JozP/ltHLAfFxNB2prgArtzhNxV/PpEM5Kknlm22KzVJmje5DPgMAB7oSy6armGfYu
         I/dt3yJRwsZyHiHeUSSAEso1OCD1DCn6hGLutcALFKy3tJJNjBJci/YVYxAzSOVID2wV
         qGUIJbtBF2pfzbrpS6jvA3tK45tzxEtP1XQBxRb8DYWgCbqhO51b4EikH0R4kvuFUUQl
         5MRTvAuRGflerGyBzHoiYaIWz1ITscd2rlIr9kKSWfd+u5xYqEq/GF6XUZNSqUKK7N1D
         x4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cx6nexWaRg6eCyJE/QI3VG4E1ddJBjH6iuIA7/pxKMM=;
        b=s/WXdDPjW5YpsCyE04RgKZUzGJh6RQWNQw/XBkaDna1S/npjW1xbC0d5oNzpXAHA5V
         U7TWMUCaz6LW5+BamT2NiyGmHMRlqqOF8aQKQHClngefKDS1bp7PLniohEtEFDDH1c6w
         cvvQMvk3DvXU0qbIPKSTIVq5EfolksrSxWccX4CpNRRahlObxBt1F667kcP6GbflMt76
         e3Z9ck6M3tvDtr3l72y4xj5ZUBJFsyE1daw0Fx29Xwr88aV0PlLFOQ/Ihi36tL1v/kaK
         HCx6VMg9HtLSniHGflC1/BdivoKq86TjDTecIRF5vL0QGuTZdzao9zotA5tqycBai+dL
         0exQ==
X-Gm-Message-State: AJcUukdOBmcJMzoYnnxz7ez9xwPuAl444Ep+NqtYdMxkq/OFx1FLmZ19
        2wCWu9MvViwsaS1Y1vVKrfw=
X-Google-Smtp-Source: ALg8bN6xZRxt2nGz9L0EtZUmkAl9UqYDFHR2LWdOnmBh0VVGxEHe3re7Ida1a1hwPndwiNdtFzSAaA==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr30286669wrv.288.1546173617260;
        Sun, 30 Dec 2018 04:40:17 -0800 (PST)
Received: from jig.fritz.box (p3EE0413B.dip0.t-ipconnect.de. [62.224.65.59])
        by smtp.gmail.com with ESMTPSA id b18sm30296798wrr.43.2018.12.30.04.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 04:40:16 -0800 (PST)
From:   Mathias Krause <minipli@googlemail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@googlemail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] vmlinux.lds.h: drop unused __vermagic
Date:   Sun, 30 Dec 2018 13:40:04 +0100
Message-Id: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference to '__vermagic' is a relict from v2.5 times. And even
there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
("Module Sanity Check") in the historic tree) to v2.5.69 (commit
67ac5b866bda ("[PATCH] complete modinfo section")).

Neither current kernels nor modules contain a '__vermagic' section any
more, so get rid of it.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..530ce1e7a1ec 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -332,7 +332,6 @@
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
-		KEEP(*(__vermagic))	/* Kernel version magic */	\
 		. = ALIGN(8);						\
 		__start___tracepoints_ptrs = .;				\
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
-- 
2.19.2

