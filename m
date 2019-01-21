Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E03CC2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E8620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080359;
	bh=MMmzmmPWxXIo3J53OU5vIJeB6pVJ3BIo2wABNJUg+aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yk+LWiKfW/4OaAaq9DY+qkSQjnOcd8kTAezVVwApelbRGnpuWMxyg3i4kv1yo+cuH
	 OegHBO5C9v2Jh5Lm7HbUBMo8xOJLOtRv0jzHS8i/HBvCGDnAxzD+mUXuEBVLQiBh2Y
	 iXKl+fyW5e9oECa941nQrY75mXXN7SYQIa7O3D/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfAUOTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbfAUNsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB7A2063F;
        Mon, 21 Jan 2019 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078531;
        bh=MMmzmmPWxXIo3J53OU5vIJeB6pVJ3BIo2wABNJUg+aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAqwfTGNhRRhOwwe5R7SKWI23KcC7nibG/TZY3/D5DzaV38gjZQ/Z7CIs1/IwZ6i/
         Qg2VHYEX6lPX41zEepQ+J5d1wiQygl/2V3PMj1DUq1kIOVtbhKiiHSoHfIaEzX9Gpc
         4KXDwQO10CY17HpeciKjvqWccqRilAGF8OqajfdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.20 048/111] mips: fix n32 compat_ipc_parse_version
Date:   Mon, 21 Jan 2019 14:42:42 +0100
Message-Id: <20190121122501.248885342@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 5a9372f751b5350e0ce3d2ee91832f1feae2c2e5 upstream.

While reading through the sysvipc implementation, I noticed that the n32
semctl/shmctl/msgctl system calls behave differently based on whether
o32 support is enabled or not: Without o32, the IPC_64 flag passed by
user space is rejected but calls without that flag get IPC_64 behavior.

As far as I can tell, this was inadvertently changed by a cleanup patch
but never noticed by anyone, possibly nobody has tried using sysvipc
on n32 after linux-3.19.

Change it back to the old behavior now.

Fixes: 78aaf956ba3a ("MIPS: Compat: Fix build error if CONFIG_MIPS32_COMPAT but no compat ABI.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # 3.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3184,6 +3184,7 @@ config MIPS32_O32
 config MIPS32_N32
 	bool "Kernel support for n32 binaries"
 	depends on 64BIT
+	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select COMPAT
 	select MIPS32_COMPAT
 	select SYSVIPC_COMPAT if SYSVIPC


