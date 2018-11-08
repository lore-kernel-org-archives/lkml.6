Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1691C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E68820818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="enLYnomr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E68820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbeKIHoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbeKIHoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:07 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFE9208A3;
        Thu,  8 Nov 2018 22:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714796;
        bh=JwCji18mLBr0BS4O8Pe3klBrSwRBvz2tUYigkbOYRPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enLYnomrwanevmvzQDKrpWpXmLe24EdeZiaVRkHW6u13i5HfKXqQpr7KiUCHfNLQt
         bzDonB3Zux9rLHhF1DqvxtHNllf48k7a1KOf/7SLVQbgkuuexD5Db9iV0LRjSm7enp
         xgo5v/pelEd0BRszmoWhEvisUKLzVRQjMQTX5su4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jessica Yu <jeyu@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 105/171] module: fix DEBUG_SET_MODULE_RONX typo
Date:   Thu,  8 Nov 2018 13:51:15 -0800
Message-Id: <20181108215134.991522354@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

[ Upstream commit 4d217a5adccf5e806790c37c61cc374a08bd7381 ]

The newly added 'rodata_enabled' global variable is protected by
the wrong #ifdef, leading to a link error when CONFIG_DEBUG_SET_MODULE_RONX
is turned on:

kernel/module.o: In function `disable_ro_nx':
module.c:(.text.unlikely.disable_ro_nx+0x88): undefined reference to `rodata_enabled'
kernel/module.o: In function `module_disable_ro':
module.c:(.text.module_disable_ro+0x8c): undefined reference to `rodata_enabled'
kernel/module.o: In function `module_enable_ro':
module.c:(.text.module_enable_ro+0xb0): undefined reference to `rodata_enabled'

CONFIG_SET_MODULE_RONX does not exist, so use the correct one instead.

Fixes: 39290b389ea2 ("module: extend 'rodata=off' boot cmdline parameter to module mappings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 4313772d634a..3c7f71d8e704 100644
--- a/init/main.c
+++ b/init/main.c
@@ -915,7 +915,7 @@ static int try_to_run_init_process(const char *init_filename)
 
 static noinline void __init kernel_init_freeable(void);
 
-#if defined(CONFIG_DEBUG_RODATA) || defined(CONFIG_SET_MODULE_RONX)
+#if defined(CONFIG_DEBUG_RODATA) || defined(CONFIG_DEBUG_SET_MODULE_RONX)
 bool rodata_enabled __ro_after_init = true;
 static int __init set_debug_rodata(char *str)
 {
-- 
2.17.1



