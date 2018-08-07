Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F181A20895
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F181A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404548AbeHGVO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:14:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403958AbeHGVO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:14:57 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCDC53EE;
        Tue,  7 Aug 2018 18:59:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.18 64/85] random: mix rdrand with entropy sent in from userspace
Date:   Tue,  7 Aug 2018 20:52:06 +0200
Message-Id: <20180807172359.726724328@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1417,14 +1417,22 @@ static int
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
 


