Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960C5C41537
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5972320863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5OF9y+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5972320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbeK3ETn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:19:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34624 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbeK3ETF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:19:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so2695801wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5aEOue59gExXs0lNGE2h5oDrnn0K20vvi0KDkgckJZA=;
        b=Z5OF9y+znrVtgMNqnvDMwi6nPeaNhKQ+05e60Fkg1ExcJrgK5GqtUOBCvB1T6i5VRZ
         KVbW0x8U861A09P6Hm6HTBsIKl6UsS4TjKLSh7sH4O6HvWO5piv+XnzRDLk+tqZUa0ZF
         FBw16cuUShERLQaOGTbDSSUkCGU0dvgH/b1yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5aEOue59gExXs0lNGE2h5oDrnn0K20vvi0KDkgckJZA=;
        b=exTouzpkaPVm4pWN65UIgolDGgxaUaFsupHVwaBU146msFTPvElk6sXFFmqzoJNPCu
         Ned8UG+L/hanTiaDA4kqkvnGpOi3pmxQMJIhcooHj5qXkWDANlbtCnNXrhMtBGs13UPX
         8aZvi5NFKTXzz7no4ttvQSPyMn2yoLgg6AIYC9gbcaqPBOh4KnO9sV+uzZdYv0KTZoDh
         1oQsvF9FnoHr3Crie8ELvjVgIWAdsFjhUw2c+wC6S46ryUHW/W0cVZ1LfIG1xXp5iRqw
         1GP1qMPpxWRfZFnnFiNhZQIew75GTcyB+zkYfjMcKFke/ZZA/PLZwafO2WungsUPNsrr
         jQ0Q==
X-Gm-Message-State: AA+aEWa9TEqMiWzSqxYFsL1YajZdoJdIBBT1Y9X1EJ+M69xVdqljDnT/
        W++kyvhEDfF8kcI0kPyVeOXEWQ==
X-Google-Smtp-Source: AFSGD/V7OkgvrshsSBiB6vXsKbfAAISa0jvoczQnEupkv8zA6Wuz8PR1b3TY9hROx/A1Gzb0WRaL/w==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr2137609wrq.15.1543511579436;
        Thu, 29 Nov 2018 09:12:59 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:12:58 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH 07/11] efi/libstub: Disable some warnings for x86{,_64}
Date:   Thu, 29 Nov 2018 18:12:26 +0100
Message-Id: <20181129171230.18699-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

When building the kernel with Clang, some disabled warnings appear
because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
this list so that the build is clean again.

-Wpointer-sign was disabled for the whole kernel before the beginning
of git history.

-Waddress-of-packed-member was disabled for the whole kernel in
commit bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member'
warning") and for x86/boot/compressed in commit 20c6c1890455 ("x86/boot:
Disable the address-of-packed-member compiler warning").

-Wgnu was disabled for the whole kernel in commit 61163efae020 ("kbuild:
LLVMLinux: Add Kbuild support for building kernel with Clang") and for
x86/boot/compressed in commit 6c3b56b19730 ("x86/boot: Disable Clang
warnings about GNU extensions").

Link: https://github.com/ClangBuiltLinux/linux/issues/112
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index c51627660dbb..d9845099635e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -9,7 +9,10 @@ cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
-				   -mno-mmx -mno-sse -fshort-wchar
+				   -mno-mmx -mno-sse -fshort-wchar \
+				   -Wno-pointer-sign \
+				   $(call cc-disable-warning, address-of-packed-member) \
+				   $(call cc-disable-warning, gnu)
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-- 
2.19.1

