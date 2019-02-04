Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D29C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9632147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfBDJoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:44:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfBDJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:44:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148hdvF354514
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:43:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148hdu5354511;
        Mon, 4 Feb 2019 00:43:39 -0800
Date:   Mon, 4 Feb 2019 00:43:39 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-494c704f9af0a0cddf593b381ea44320888733e6@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, pjones@redhat.com,
        ard.biesheuvel@linaro.org, bjorn.andersson@linaro.org,
        peterz@infradead.org, matt@codeblueprint.co.uk,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        sai.praneeth.prakhya@intel.com, xypron.glpk@gmx.de, bp@alien8.de,
        leif.lindholm@linaro.org, lee.jones@linaro.org, agraf@suse.de,
        hpa@zytor.com, jhugo@codeaurora.org, takahiro.akashi@linaro.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          xypron.glpk@gmx.de, sai.praneeth.prakhya@intel.com, bp@alien8.de,
          hpa@zytor.com, agraf@suse.de, lee.jones@linaro.org,
          leif.lindholm@linaro.org, jhugo@codeaurora.org,
          takahiro.akashi@linaro.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, pjones@redhat.com, ard.biesheuvel@linaro.org,
          peterz@infradead.org, matt@codeblueprint.co.uk,
          bjorn.andersson@linaro.org
In-Reply-To: <20190202094119.13230-5-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-5-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Use 32-bit alignment for efi_guid_t
Git-Commit-ID: 494c704f9af0a0cddf593b381ea44320888733e6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  494c704f9af0a0cddf593b381ea44320888733e6
Gitweb:     https://git.kernel.org/tip/494c704f9af0a0cddf593b381ea44320888733e6
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Sat, 2 Feb 2019 10:41:13 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:26:35 +0100

efi: Use 32-bit alignment for efi_guid_t

The UEFI spec and EDK2 reference implementation both define EFI_GUID as
struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
this means that firmware services invoked by the kernel may assume that
efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
do not tolerate misalignment. So let's set the minimum alignment to 32 bits.

Note that the UEFI spec as well as some comments in the EDK2 code base
suggest that EFI_GUID should be 64-bit aligned, but this appears to be
a mistake, given that no code seems to exist that actually enforces that
or relies on it.

Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Leif Lindholm <leif.lindholm@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190202094119.13230-5-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/efi.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 45ff763fba76..be08518c2553 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -48,7 +48,20 @@ typedef u16 efi_char16_t;		/* UNICODE character */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
-typedef guid_t efi_guid_t;
+/*
+ * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
+ * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
+ * is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
+ * this means that firmware services invoked by the kernel may assume that
+ * efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
+ * do not tolerate misalignment. So let's set the minimum alignment to 32 bits.
+ *
+ * Note that the UEFI spec as well as some comments in the EDK2 code base
+ * suggest that EFI_GUID should be 64-bit aligned, but this appears to be
+ * a mistake, given that no code seems to exist that actually enforces that
+ * or relies on it.
+ */
+typedef guid_t efi_guid_t __aligned(__alignof__(u32));
 
 #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
 	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
