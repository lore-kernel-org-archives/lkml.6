Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeFERF2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752058AbeFERFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Subject: [PATCH 4.9 27/61] powerpc/rfi-flush: Move the logic to avoid a redo into the debugfs code
Date: Tue,  5 Jun 2018 19:01:48 +0200
Message-Id: <20180605170119.444665591@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 1e2a9fc7496955faacbbed49461d611b704a7505 upstream.

rfi_flush_enable() includes a check to see if we're already
enabled (or disabled), and in that case does nothing.

But that means calling setup_rfi_flush() a 2nd time doesn't actually
work, which is a bit confusing.

Move that check into the debugfs code, where it really belongs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/setup_64.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -717,9 +717,6 @@ static void do_nothing(void *unused)
 
 void rfi_flush_enable(bool enable)
 {
-	if (rfi_flush == enable)
-		return;
-
 	if (enable) {
 		do_rfi_flush_fixups(enabled_flush_types);
 		on_each_cpu(do_nothing, NULL, 1);
@@ -773,13 +770,19 @@ void __init setup_rfi_flush(enum l1d_flu
 #ifdef CONFIG_DEBUG_FS
 static int rfi_flush_set(void *data, u64 val)
 {
+	bool enable;
+
 	if (val == 1)
-		rfi_flush_enable(true);
+		enable = true;
 	else if (val == 0)
-		rfi_flush_enable(false);
+		enable = false;
 	else
 		return -EINVAL;
 
+	/* Only do anything if we're changing state */
+	if (enable != rfi_flush)
+		rfi_flush_enable(enable);
+
 	return 0;
 }
 
