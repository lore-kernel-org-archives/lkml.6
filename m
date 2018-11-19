Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99631C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637EC20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX+Xj+l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637EC20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbeKTDEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:04:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731989AbeKTDEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:04:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C3F20989;
        Mon, 19 Nov 2018 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645603;
        bh=/U2eXRjF2hRV8lfsgUUrT8Iw0aYLgtrSHJYlZ93Oc4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VX+Xj+l3rrHgT1EWc+u6KPl6hia9+xZYKzHsvBTNM3QEqrZRv5KwIm227Wz2oeTlv
         tffvFSos0ERzYscuK+4SdxlAeRuhqUqP+M9LLltGiLhXv/OniDYrzr/o5NV8gq0WAW
         EvPkN75yRF3IUr67JnAYegN0/YTbq2xdHA0OvnWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 002/171] powerpc/64/module: REL32 relocation range check
Date:   Mon, 19 Nov 2018 17:26:38 +0100
Message-Id: <20181119162619.331598196@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit b851ba02a6f3075f0f99c60c4bc30a4af80cf428 ]

The recent module relocation overflow crash demonstrated that we
have no range checking on REL32 relative relocations. This patch
implements a basic check, the same kernel that previously oopsed
and rebooted now continues with some of these errors when loading
the module:

  module_64: x_tables: REL32 527703503449812 out of range!

Possibly other relocations (ADDR32, REL16, TOC16, etc.) should also have
overflow checks.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/module_64.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -685,7 +685,14 @@ int apply_relocate_add(Elf64_Shdr *sechd
 
 		case R_PPC64_REL32:
 			/* 32 bits relative (used by relative exception tables) */
-			*(u32 *)location = value - (unsigned long)location;
+			/* Convert value to relative */
+			value -= (unsigned long)location;
+			if (value + 0x80000000 > 0xffffffff) {
+				pr_err("%s: REL32 %li out of range!\n",
+				       me->name, (long int)value);
+				return -ENOEXEC;
+			}
+			*(u32 *)location = value;
 			break;
 
 		case R_PPC64_TOCSAVE:


