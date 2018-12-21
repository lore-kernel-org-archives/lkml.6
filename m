Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2FAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AACC217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545405728;
	bh=A7a+OVbuOX/VxIHvz9W4CR4fXzWpt1up39Y78X9FbGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=I/COJjCbfmMTww8RdYYApptoGb3i+VTYNZmre1r8xnIdfUq5bto2gmDGhInX+8KY+
	 8v71vTMUxkcQ79rAH8pVPXffm4NIUkh2p98LXE5l8DhpO/7tDlevGwJ9XaBIDMPbbm
	 dJQxJDCsLycGwFKZsG+fvD6yDE8F3eAq8/A4sXTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbeLUPWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:22:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404183AbeLUPVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:43 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7DE221928;
        Fri, 21 Dec 2018 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545405702;
        bh=A7a+OVbuOX/VxIHvz9W4CR4fXzWpt1up39Y78X9FbGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AYoF5IpV58q3d6H8lUBLas+CP7/l8znJY22OeIQA221zE9HnQNeUl/Oq6uNbjOUsP
         oF49wvyagQjXgJRXIss+wktlUuaBiwrAiIDFEHfMhQvC8KKOcv7GS3kAc7Op6onmOu
         +X1/QKqj2X18s7PLDjMf1J9MX4XxqMbOayXuU6ew=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
Subject: [PATCH RT 6/9] tty: serial: pl011: explicitly initialize the flags variable
Date:   Fri, 21 Dec 2018 09:21:18 -0600
Message-Id: <cbe003d988c3904bb5164e6b83282bafc85f6bd0.1545347029.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------
From: Kurt Kanzenbach <kurt@linutronix.de>

[ Upstream commit 3260983a587d528811a15fc00fa2a9e4473c4453 ]

Silence the following gcc warning:

drivers/tty/serial/amba-pl011.c: In function ‘pl011_console_write’:
./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/amba-pl011.c:2214:16: note: ‘flags’ was declared here
  unsigned long flags;
                ^~~~~

The code is correct. Thus, initializing flags to zero doesn't change the
behavior and resolves the warning.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5ef2c62bb904..dede68aa679e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1930,7 +1930,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int status, old_cr, new_cr;
-	unsigned long flags;
+	unsigned long flags = 0;
 	int locked = 1;
 
 	clk_enable(uap->clk);
-- 
2.14.1

