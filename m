Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B5BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AC326D6B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AC326D6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeFZP7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:59:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752544AbeFZP7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:59:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA31B83207;
        Tue, 26 Jun 2018 15:59:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-238.rdu2.redhat.com [10.10.120.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEAD72026E0E;
        Tue, 26 Jun 2018 15:59:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/3] dh key: fix rounding up KDF output length
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        syzbot+29d17b7898b41ee120a5@syzkaller.appspotmail.com,
        syzbot+8a608baf8751184ec727@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        syzbot+486f97f892efeb2075a3@syzkaller.appspotmail.com,
        syzbot+d04e58bd384f1fe0b112@syzkaller.appspotmail.com
Date:   Tue, 26 Jun 2018 16:59:46 +0100
Message-ID: <153002878692.31726.13651817141660735426.stgit@warthog.procyon.org.uk>
In-Reply-To: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
References: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 26 Jun 2018 15:59:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 26 Jun 2018 15:59:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Commit 383203eff718 ("dh key: get rid of stack allocated array") changed
kdf_ctr() to assume that the length of key material to derive is a
multiple of the digest size.  The length was supposed to be rounded up
accordingly.  However, the round_up() macro was used which only gives
the correct result on power-of-2 arguments, whereas not all hash
algorithms have power-of-2 digest sizes.  In some cases this resulted in
a write past the end of the 'outbuf' buffer.

Fix it by switching to roundup(), which works for non-power-of-2 inputs.

Reported-by: syzbot+486f97f892efeb2075a3@syzkaller.appspotmail.com
Reported-by: syzbot+29d17b7898b41ee120a5@syzkaller.appspotmail.com
Reported-by: syzbot+8a608baf8751184ec727@syzkaller.appspotmail.com
Reported-by: syzbot+d04e58bd384f1fe0b112@syzkaller.appspotmail.com
Fixes: 383203eff718 ("dh key: get rid of stack allocated array")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Tycho Andersen <tycho@tycho.ws>
---

 security/keys/dh.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index f7403821db7f..b203f7758f97 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -142,6 +142,8 @@ static void kdf_dealloc(struct kdf_sdesc *sdesc)
  * The src pointer is defined as Z || other info where Z is the shared secret
  * from DH and other info is an arbitrary string (see SP800-56A section
  * 5.8.1.2).
+ *
+ * 'dlen' must be a multiple of the digest size.
  */
 static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 		   u8 *dst, unsigned int dlen, unsigned int zlen)
@@ -205,8 +207,8 @@ static int keyctl_dh_compute_kdf(struct kdf_sdesc *sdesc,
 {
 	uint8_t *outbuf = NULL;
 	int ret;
-	size_t outbuf_len = round_up(buflen,
-			             crypto_shash_digestsize(sdesc->shash.tfm));
+	size_t outbuf_len = roundup(buflen,
+				    crypto_shash_digestsize(sdesc->shash.tfm));
 
 	outbuf = kmalloc(outbuf_len, GFP_KERNEL);
 	if (!outbuf) {

