Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881E5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5832146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnV5PwPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5832146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeKZVrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeKZVrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE0721104;
        Mon, 26 Nov 2018 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229637;
        bh=sbWbTVAm9+/0EBWGDvC8VmnSHWqwgd1sk6lu6SuKGwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnV5PwPkC3Aessjk992HDwGCz6+bGKd41hP2EvU9NJlUVVYlc0fofRWotfNb68OIg
         Bm2c7ztj5WBMyVxs3764zN9aVHjsQEPmipkmEMya4GhrXr2WfgQ7fxEKvzdN/SHWa1
         Bwkz+oWBZazrkJjvi8tcAfoIi6jAVQCEvAo71cY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jessica Yu <jeyu@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 15/70] modules: mark __inittest/__exittest as __maybe_unused
Date:   Mon, 26 Nov 2018 11:50:30 +0100
Message-Id: <20181126105048.350575931@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1f318a8bafcfba9f0d623f4870c4e890fd22e659 upstream.

clang warns about unused inline functions by default:

arch/arm/crypto/aes-cipher-glue.c:68:1: warning: unused function '__inittest' [-Wunused-function]
arch/arm/crypto/aes-cipher-glue.c:69:1: warning: unused function '__exittest' [-Wunused-function]

As these appear in every single module, let's just disable the warnings by marking the
two functions as __maybe_unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/module.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -125,13 +125,13 @@ extern void cleanup_module(void);
 
 /* Each module must use one module_init(). */
 #define module_init(initfn)					\
-	static inline initcall_t __inittest(void)		\
+	static inline initcall_t __maybe_unused __inittest(void)		\
 	{ return initfn; }					\
 	int init_module(void) __attribute__((alias(#initfn)));
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
-	static inline exitcall_t __exittest(void)		\
+	static inline exitcall_t __maybe_unused __exittest(void)		\
 	{ return exitfn; }					\
 	void cleanup_module(void) __attribute__((alias(#exitfn)));
 


