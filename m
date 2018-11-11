Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F72C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED5C20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED5C20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeKLFsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51022 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730688AbeKLFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:29 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsp-0000lG-0O; Sun, 11 Nov 2018 19:58:59 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001kk-DW; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Jamie Heilman" <jamie@audible.transient.net>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.151489609@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 272/366] crypto: padlock-aes - Fix Nano workaround
 data corruption
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

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 46d8c4b28652d35dc6cfb5adf7f54e102fc04384 upstream.

This was detected by the self-test thanks to Ard's chunking patch.

I finally got around to testing this out on my ancient Via box.  It
turns out that the workaround got the assembly wrong and we end up
doing count + initial cycles of the loop instead of just count.

This obviously causes corruption, either by overwriting the source
that is yet to be processed, or writing over the end of the buffer.

On CPUs that don't require the workaround only ECB is affected.
On Nano CPUs both ECB and CBC are affected.

This patch fixes it by doing the subtraction prior to the assembly.

Fixes: a76c1c23d0c3 ("crypto: padlock-aes - work around Nano CPU...")
Reported-by: Jamie Heilman <jamie@audible.transient.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/crypto/padlock-aes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/crypto/padlock-aes.c
+++ b/drivers/crypto/padlock-aes.c
@@ -266,6 +266,8 @@ static inline void padlock_xcrypt_ecb(co
 		return;
 	}
 
+	count -= initial;
+
 	if (initial)
 		asm volatile (".byte 0xf3,0x0f,0xa7,0xc8"	/* rep xcryptecb */
 			      : "+S"(input), "+D"(output)
@@ -273,7 +275,7 @@ static inline void padlock_xcrypt_ecb(co
 
 	asm volatile (".byte 0xf3,0x0f,0xa7,0xc8"	/* rep xcryptecb */
 		      : "+S"(input), "+D"(output)
-		      : "d"(control_word), "b"(key), "c"(count - initial));
+		      : "d"(control_word), "b"(key), "c"(count));
 }
 
 static inline u8 *padlock_xcrypt_cbc(const u8 *input, u8 *output, void *key,
@@ -284,6 +286,8 @@ static inline u8 *padlock_xcrypt_cbc(con
 	if (count < cbc_fetch_blocks)
 		return cbc_crypt(input, output, key, iv, control_word, count);
 
+	count -= initial;
+
 	if (initial)
 		asm volatile (".byte 0xf3,0x0f,0xa7,0xd0"	/* rep xcryptcbc */
 			      : "+S" (input), "+D" (output), "+a" (iv)
@@ -291,7 +295,7 @@ static inline u8 *padlock_xcrypt_cbc(con
 
 	asm volatile (".byte 0xf3,0x0f,0xa7,0xd0"	/* rep xcryptcbc */
 		      : "+S" (input), "+D" (output), "+a" (iv)
-		      : "d" (control_word), "b" (key), "c" (count-initial));
+		      : "d" (control_word), "b" (key), "c" (count));
 	return iv;
 }
 

