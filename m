Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AAFECDE47
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46154205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YeFBL9dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46154205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJYFK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:10:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38726 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYFKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:10:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id p7-v6so2782167plk.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=l4cQhwyUcUP06KMujhIUzoj6XcQBIruPW01G2CSbcCk=;
        b=YeFBL9dt1FwnXNd1jeUEcz6PARC2or2JgJtQflvzRRugxSOooDcJ2ZgeZ+x5GYfOtf
         FzYg0/oAqZz5+Xjo6agzS2PF6HimmTYckT4xcKHS1Oo9Fk8FYlk0stpYmedh4ABHQFnT
         BTXgfRoQ7rEIPwCdNNY2y7WeCFtFjGyLYX6bQAd/UE/jdnNl4T7zNlMpUfcZpht6L7XK
         KZTG39UiOnKDRW0bGLY2BD2EYWkjyJA+M33r9wlJNdR2NGGTSnOVtposIAUhA94RXw35
         VatWoc4XIeq5WCo9/fKkLQ0w2L2Mjg/vIbKQz+SvKnhG/75oKcbuuW28S6Bz7hsz8i2L
         jn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=l4cQhwyUcUP06KMujhIUzoj6XcQBIruPW01G2CSbcCk=;
        b=S0caY+Zg2ohEiVTfYT4x9Zx0c8Y7zc1q6hfwVF706Id5jbKxZAOEXNH7ITGAoNReBL
         Elxc48tEF9zG5Gk3yl8D2kpN/40x0FbQ/PE3TyZcmfdQP6H7xFse12xXUXz3GAIISstk
         yM3OVu174IKQI8j4K3S5btWkohGcIEiWf4Vnxjp30E89e/V7gECzzgu33RVWSRgaoRAX
         0l4NAXyxHFLimPNLzkCeGOGqL6wqpYUEzCgmz4ZNj0emMtCORqtXiMr/S1rAxVDCwvq+
         2L/UdOs1cwMUmSQQxOADpm36irHOcJ8WPYQLZm8ZSdUnhGwOKdpseJJjh/WnXBfsgexc
         /3kQ==
X-Gm-Message-State: AGRZ1gJq01ZejgX4JbWT1C8OPNeiTU4UPsLm/4JXxmMk2bJA1eTe+r+q
        Xu7ke2IMj5xbDN4w9/LKwbPBqw==
X-Google-Smtp-Source: AJdET5eQ4iRvTxkuKb1mCg0vLUEmhYnw4urK9QM/Gc0lr2i/a1Cg5cY5zpFTtkO1tUSYUidL4Xvn0Q==
X-Received: by 2002:a17:902:7d98:: with SMTP id a24-v6mr3844789plm.271.1540413651482;
        Wed, 24 Oct 2018 13:40:51 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x73-v6sm14410558pfk.139.2018.10.24.13.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:40:50 -0700 (PDT)
Subject: [PATCH 1/2] Move EM_RISCV into elf-em.h
Date:   Wed, 24 Oct 2018 13:40:35 -0700
Message-Id: <20181024204036.8799-2-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181024204036.8799-1-palmer@sifive.com>
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        paul@paul-moore.com, eparis@redhat.com, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org,
        Wesley Terpstra <wesley@sifive.com>, dhowells@redhat.com,
        tglx@linutronix.de, pombredanne@nexb.com,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        david.abdurachmanov@gmail.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should never have been inside our arch port to begin with, it's
just a relic from when we were maintaining out of tree patches.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/include/asm/elf.h | 3 ---
 include/uapi/linux/elf-em.h  | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index a1ef503d616e..697fc23b0d5a 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -16,9 +16,6 @@
 #include <asm/auxvec.h>
 #include <asm/byteorder.h>
 
-/* TODO: Move definition into include/uapi/linux/elf-em.h */
-#define EM_RISCV	0xF3
-
 /*
  * These are used to set parameters in the core dumps.
  */
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index 31aa10178335..93722e60204c 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -41,6 +41,7 @@
 #define EM_TILEPRO	188	/* Tilera TILEPro */
 #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */
 #define EM_TILEGX	191	/* Tilera TILE-Gx */
+#define EM_RISCV	243	/* RISC-V */
 #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
 #define EM_FRV		0x5441	/* Fujitsu FR-V */
 
-- 
2.18.1

