Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD79C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4559A20895
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4559A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404636AbeHGVPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:15:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35128 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733213AbeHGVPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:15:49 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A7073EE;
        Tue,  7 Aug 2018 19:00:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jamie Heilman <jamie@audible.transient.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3.18 80/85] crypto: padlock-aes - Fix Nano workaround data corruption
Date:   Tue,  7 Aug 2018 20:52:22 +0200
Message-Id: <20180807172400.331850339@linuxfoundation.org>
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
Cc: <stable@vger.kernel.org>
Reported-by: Jamie Heilman <jamie@audible.transient.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/padlock-aes.c |    8 ++++++--
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
 


