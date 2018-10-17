Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4AEECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7150521486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Og9cwNkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7150521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeJRGbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:33 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43213 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJRGbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:31 -0400
Received: by mail-ed1-f52.google.com with SMTP id y20-v6so26397923eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ClhlnCu46qsmqja5zu7b4m0FvzNN2MY3jPLKYOMqAfk=;
        b=Og9cwNkPz1Cl91HNGW3MD+DQOV+ho/xIsiDntxNBQP+1Fcn9CFWKGfbmCdcmgUUbjN
         23nAOD/nZ+0BB1dFLigF4D1iwdPk9JP2/D3sW8Pbg0UBH7oxJtj9g2bAOrxD8KyczvkI
         fFDfgOffEfadopqfHmbE7u6O0moTNW6I2x9us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClhlnCu46qsmqja5zu7b4m0FvzNN2MY3jPLKYOMqAfk=;
        b=gERkqMmbyCXKAkDioW+XVHymGOg4Ab264KWqYR6ylljh9USPusmQHCaFkVKqU7bbaG
         w/z6/pM5TTremlHqPnEdoQfVYRQXN0PkCDXyJZeIcqtKyQojDtjQbVFhczmg17FQa2DW
         RE1U6ca7AR+SsanG3dYb+fEZRM65WTskUQXic0DeaKEBuMtTASV73G6W55FgVkERA0R1
         qa5O73dXomZIwpIG8cYv5Ngzk5Fp3OMVlWjmoNULiYtZe4c6XhcUrNjyPGMg5cYOXMst
         pbj7pUv0tIVEiUEd4tJVumBeIvV+BpSumQmtEu18PrRfxhUd/ArgKkBgM//qVmPNjea5
         dDFw==
X-Gm-Message-State: ABuFfoiaiIx+32IRCPgrkUxPyshB4STNn19Gpw4BOVf4zLF+/rX6Nzx8
        dRxT8Mnwk4ugd/fENH3kxnznwQFr6ps=
X-Google-Smtp-Source: ACcGV62xiWEV1rQdLtHftJE16ncy3g+FeYrSTnCyTQ5FS//DxcKo3mLnRQw3n7dmKu4ExNW5DqK44g==
X-Received: by 2002:a17:906:3557:: with SMTP id s23-v6mr27851172eja.128.1539815622651;
        Wed, 17 Oct 2018 15:33:42 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 04/12] vmlinux.lds.h: handle various rai sections
Date:   Thu, 18 Oct 2018 00:33:24 +0200
Message-Id: <20181017223332.11964-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/vmlinux.lds.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f09ee3c544bc..f38510c6bfcc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -257,6 +257,7 @@
 	__start___verbose = .;						\
 	KEEP(*(__verbose))                                              \
 	__stop___verbose = .;						\
+	KEEP(*(.rai_templ))						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
@@ -328,6 +329,9 @@
 		__start___tracepoints_ptrs = .;				\
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
 		__stop___tracepoints_ptrs = .;				\
+		__start_rai_data = .;					\
+		KEEP(*(.rai_data))					\
+		__stop_rai_data = .;					\
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
 									\
@@ -494,6 +498,7 @@
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
+		*(.text.rai_thunk)					\
 		*(.text..refcount)					\
 		*(.ref.text)						\
 	MEM_KEEP(init.text*)						\
-- 
2.19.1.6.gbde171bbf5

