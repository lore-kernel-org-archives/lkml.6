Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9519C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC3121736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864483;
	bh=WoeDjF30i8H8dWIKYSjRm7Lpn/M8ZprJuEbujfPXPB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PKfElE+60QfVATpKiXsZXYQ9lUfUVz1KJg9ATk/SkYR3y/ySBOvbPZ5/YpsdcNN3/
	 XXa4U23GYFg3zRup1UoCg8qtPuBzDgrboCeU+EUpuEefqpQpkjS3NdDbHez7HK+K0A
	 Fo+f/xhWmocqfCNLwvNFN3ceNSlVAk+qOGRy8CKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfAGMem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfAGMej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128AA20859;
        Mon,  7 Jan 2019 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864478;
        bh=WoeDjF30i8H8dWIKYSjRm7Lpn/M8ZprJuEbujfPXPB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1eyTdghoWprk8wpxd8HvsXTj5CAUAiVjVLGc8QipyfswRnjGy81/ljqirsUE50Ev
         yRhRumNIi5TClz4yZBbDxEOlM9GZXcO0rlmKsbC7Vaw1LjXdvXGAAeeuepDb1oEtKp
         EgmFfqwiNXknCQTVV8EDN4A/hBbfUGj/HS6roJ0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 025/145] powerpc/fsl: Fix spectre_v2 mitigations reporting
Date:   Mon,  7 Jan 2019 13:31:02 +0100
Message-Id: <20190107104440.610290762@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diana Craciun <diana.craciun@nxp.com>

commit 7d8bad99ba5a22892f0cad6881289fdc3875a930 upstream.

Currently for CONFIG_PPC_FSL_BOOK3E the spectre_v2 file is incorrect:

  $ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
  "Mitigation: Software count cache flush"

Which is wrong. Fix it to report vulnerable for now.

Fixes: ee13cb249fab ("powerpc/64s: Add support for software count cache flush")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/security.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -22,7 +22,7 @@ enum count_cache_flush_type {
 	COUNT_CACHE_FLUSH_SW	= 0x2,
 	COUNT_CACHE_FLUSH_HW	= 0x4,
 };
-static enum count_cache_flush_type count_cache_flush_type;
+static enum count_cache_flush_type count_cache_flush_type = COUNT_CACHE_FLUSH_NONE;
 
 bool barrier_nospec_enabled;
 static bool no_nospec;


