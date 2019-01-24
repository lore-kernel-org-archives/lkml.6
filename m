Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E53C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B156217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360745;
	bh=5CR/BHIJDsb5V195UOdgvnrZMmAWROelrEdun2ZWWWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zhxRg9FJrqBrDtxVFkXJ8G8pmw6aSJhP4Z+NahHHmyuIsof1wNsyqkX1hKjVO2RTz
	 zT1rUaK8MPJ2QRdwbR/3O/TTy/QsdEllknCKwVaXjPO0cqPNQcm24LOU7YX4nlxSCX
	 xc9BUXOegSgz9jrrDV7auXf4aSeLNxutlgRad9z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfAXUMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:12:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbfAXT0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:26:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6753F218FD;
        Thu, 24 Jan 2019 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357961;
        bh=5CR/BHIJDsb5V195UOdgvnrZMmAWROelrEdun2ZWWWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/5Sw3jE4vBKi+pVdhDdmmzfMce2EjUFDrG5HqLXRM/O/DUoA/R+cUsxnNvaH6x2s
         fp4Zu9xfE6gcvTr16a9LtafYFG2k3DaJph+oysGwYSZbBx+GbeQW6X/n7yl0GMy7Ur
         T0PyYiiV73Mn/a8xk0AjUd38d3amuRbXXCzaKatg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.4 051/104] mips: fix n32 compat_ipc_parse_version
Date:   Thu, 24 Jan 2019 20:19:40 +0100
Message-Id: <20190124190201.415332191@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2972,6 +2972,7 @@ config MIPS32_O32
 config MIPS32_N32
 	bool "Kernel support for n32 binaries"
 	depends on 64BIT
+	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select COMPAT
 	select MIPS32_COMPAT
 	select SYSVIPC_COMPAT if SYSVIPC


