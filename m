Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DE1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B669520818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B669520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeKLGOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:14:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51100 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730696AbeKLFsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:30 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsq-0000oG-He; Sun, 11 Nov 2018 19:59:00 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001kG-4T; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.797933760@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 266/366] random: mix rdrand with entropy sent in from
 userspace
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 81e69df38e2911b642ec121dec319fad2a4782f3 upstream.

Fedora has integrated the jitter entropy daemon to work around slow
boot problems, especially on VM's that don't support virtio-rng:

    https://bugzilla.redhat.com/show_bug.cgi?id=1572944

It's understandable why they did this, but the Jitter entropy daemon
works fundamentally on the principle: "the CPU microarchitecture is
**so** complicated and we can't figure it out, so it *must* be
random".  Yes, it uses statistical tests to "prove" it is secure, but
AES_ENCRYPT(NSA_KEY, COUNTER++) will also pass statistical tests with
flying colors.

So if RDRAND is available, mix it into entropy submitted from
userspace.  It can't hurt, and if you believe the NSA has backdoored
RDRAND, then they probably have enough details about the Intel
microarchitecture that they can reverse engineer how the Jitter
entropy daemon affects the microarchitecture, and attack its output
stream.  And if RDRAND is in fact an honest DRNG, it will immeasurably
improve on what the Jitter entropy daemon might produce.

This also provides some protection against someone who is able to read
or set the entropy seed file.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/char/random.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1418,14 +1418,22 @@ static int
 write_pool(struct entropy_store *r, const char __user *buffer, size_t count)
 {
 	size_t bytes;
-	__u32 buf[16];
+	__u32 t, buf[16];
 	const char __user *p = buffer;
 
 	while (count > 0) {
+		int b, i = 0;
+
 		bytes = min(count, sizeof(buf));
 		if (copy_from_user(&buf, p, bytes))
 			return -EFAULT;
 
+		for (b = bytes ; b > 0 ; b -= sizeof(__u32), i++) {
+			if (!arch_get_random_int(&t))
+				break;
+			buf[i] ^= t;
+		}
+
 		count -= bytes;
 		p += bytes;
 

