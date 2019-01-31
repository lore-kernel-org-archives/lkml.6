Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C27C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B165218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P9dwYN1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfAaT2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40860 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfAaT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so1774043pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+mtJttdkpbHkKwJD9Bx7fRr1xachAxsiCzjUbdFk/A=;
        b=P9dwYN1MNLKJsS23FZ1poGTZ7I7Oi+vOqxpaisxacaSdT2zvJrAu1UUiFqN1jUSD2a
         FLs6DqoUS6cCfPSIWUDgxOZiizDJh9zBHeN8IP95pYoCebiXgsthiatwDhOHOS0Q/7ZO
         m1a8oiJBXQEyGvDnSCJW1Wd7SWSI/78Ow7RuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+mtJttdkpbHkKwJD9Bx7fRr1xachAxsiCzjUbdFk/A=;
        b=Dw0uPbM7UWfgTRZKaFUU1HGBt3HBe77uz53h7LLLZ4s8G4QhRfSBHBXbus32WfRRbV
         Nih+cgHW2D/IX7lsXZiONdYfxaMOsNzkA4lIDYY6nxNSrqEr689q0xyvYV9mTVSSkAKu
         3MNN/+Hb9AWKqsrUfKoOIBtIPqlp08Nqoswn/TNq3H3qs8Nm+tGRSqM7n0PIIOI66lcw
         Roi3eODjsV7Kr1KHugDf6wnDXtEls9porc1J1OpcfeFXEoJXn4C7T5u7Hhl5I0C/spZ5
         Wnj3JoeTZ0bqBtrsTzTxhwWgpgnMRPK5pO345Ki2HFEwvCxq2+P4NnztFMeIvV3TzEfq
         QUSw==
X-Gm-Message-State: AJcUukc1Lo9lJ21FzgAyxhadauABIj74MBRdOIJeC+xqQCg0NRpKIP2t
        wLoDBvMnyRL0QcXpwfbDKjrEI/kfr+s=
X-Google-Smtp-Source: ALg8bN40S89Xtrdwft10DGlVPE8nMli0CI4NhtpqLwwevZWuvDlT1u5oCU73A3zbiR5Wke+rG/m/jQ==
X-Received: by 2002:a65:484c:: with SMTP id i12mr32407446pgs.309.1548962898877;
        Thu, 31 Jan 2019 11:28:18 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:18 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Thomas Garnier <thgarnie@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/27] x86: Add macro to get symbol address for PIE support
Date:   Thu, 31 Jan 2019 11:24:10 -0800
Message-Id: <20190131192533.34130-4-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new _ASM_MOVABS macro to fetch a symbol address. It will be used
to replace "_ASM_MOV $<symbol>, %dst" code construct that are not compatible
with PIE.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/asm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 6467757bb39f..5ff63ca80bca 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -30,6 +30,7 @@
 #define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
 
 #define _ASM_MOV	__ASM_SIZE(mov)
+#define _ASM_MOVABS	__ASM_SEL(movl, movabsq)
 #define _ASM_INC	__ASM_SIZE(inc)
 #define _ASM_DEC	__ASM_SIZE(dec)
 #define _ASM_ADD	__ASM_SIZE(add)
-- 
2.20.1.495.gaa96b0ce6b-goog

