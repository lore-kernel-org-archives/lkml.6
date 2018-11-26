Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5821CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E89521104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbRwnR23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E89521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeKZVvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:32954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZVvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741F92146F;
        Mon, 26 Nov 2018 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229877;
        bh=utfwebwFfuGBGhmsaByEc1ZJHhhZR8qCW8dI+qdRyhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbRwnR23LIjK18vYohKEMhz366MW+S6xaEzN5HkwK+/9krpmvLq5hkoVWYfXiRDZR
         DnLuZCH9Iz1U8NKXaGYfIe/pxqtL37azi1HY7F3KFUIlMyIjdeYMFqsyTHS6ur7mfG
         c/7/GO0tQ+9DLNOtGuj228+ZG1h+yf2wcV/HWJiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/46] um: Give start_idle_thread() a return code
Date:   Mon, 26 Nov 2018 11:50:54 +0100
Message-Id: <20181126105046.168063599@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7ff1e34bbdc15acab823b1ee4240e94623d50ee8 ]

Fixes:
arch/um/os-Linux/skas/process.c:613:1: warning: control reaches end of
non-void function [-Wreturn-type]

longjmp() never returns but gcc still warns that the end of the function
can be reached.
Add a return code and debug aid to detect this impossible case.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/skas/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 23025d645160..0a99d4515065 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -578,6 +578,11 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 		fatal_sigsegv();
 	}
 	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	printk(UM_KERN_ERR "impossible long jump!");
+	fatal_sigsegv();
+	return 0;
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
-- 
2.17.1



