Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415214-2-15910300340967853974
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415213; b=sxj7U+Bp4ytCQ5TGff+v6OaVJOWrDt4MQJ0fL/xgtDDi/Zf
    i2QLmP/Fattabo1wZm7LEgj8cTWIEwnCsmYpX3rG1sBYP0UbQmBs5WMd/j+qLPEG
    RtOILCGnQWJDXX4GzpYjc8fBtRq4iR6d1eUXKgvRYVf/iziIQbbv5xXxN7gWgVag
    KWakE6QbwUf9omxrsktiC5qvKcm2ustghXTnlyqSd56pRTBBO/bSxy170+57v/F9
    FM6Vcr9zesxYc72IFzFr8Y5zIuKU5cJbHI+jZKQawXkXZvWj4dnO7xZa+dpQ2X50
    xhi+32ReaJUfQVK9s5PlHNW+6blPETHllnvyOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415213; bh=/Jd3/658BfDh8HCesVVdu4e7Nq
    zCFKPCjDW8xIf9qnc=; b=SOgCRRagakBOcBYkcmmsXsGdfpHd3mBPL0ulfVAurV
    lrrPmCp5bNC9N8jWPomeOesYRkgBKCMofBc6ImfRtsHfoJa95F+ZLPkdoJxVHB2d
    HDYZ4rtlvcKG4RcrAL8OnBtMoZsqRjPDnmd54Ar4M73TTR3U8kIXZ9F9WScNAQYS
    k34OeZNMnPp8GBrbg+tpB347qfcgBbvBChrELjJlhI7s1RfgbqSzc3Kt57ialj0L
    R6SJdu6pG8HjkAyGJKD2vGuAk0vG5K2+xzf8aivZ0vhxcv5AWwC/Zz6FrICH4Mbl
    MUXl1J6QKBrcyJyocgWiQwTxUVymmNMBghf//1RxYwXA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933859AbeBWSrk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934214AbeBWSrj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.9 118/145] reiserfs: avoid a -Wmaybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:27:04 +0100
Message-Id: <20180223170740.069699158@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ab4949640d6674b617b314ad3c2c00353304bab9 upstream.

The latest gcc-7.0.1 snapshot warns about an unintialized variable use:

In file included from fs/reiserfs/lbalance.c:8:0:
fs/reiserfs/lbalance.c: In function 'leaf_item_bottle.isra.3':
fs/reiserfs/reiserfs.h:1279:13: error: '*((void *)&n_ih+8).v' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  v2->v = (v2->v & cpu_to_le64(15ULL << 60)) | cpu_to_le64(offset);
           ~~^~~
fs/reiserfs/reiserfs.h:1279:13: error: '*((void *)&n_ih+8).v' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  v2->v = (v2->v & cpu_to_le64(15ULL << 60)) | cpu_to_le64(offset);

This happens because the offset/type pair that is stored in
ih.key.u.k_offset_v2 is actually uninitialized when we call
set_le_ih_k_offset() and set_le_ih_k_type(). After we have called both,
all data is correct, but the first of the two reads uninitialized data
for the type field and writes it back before it gets overwritten.

This works around the warning by initializing the k_offset_v2 through
the slightly larger memcpy().

[JK: Remove now unused define and make it obvious we initialize the key]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/reiserfs/lbalance.c |    2 +-
 fs/reiserfs/reiserfs.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

--- a/fs/reiserfs/lbalance.c
+++ b/fs/reiserfs/lbalance.c
@@ -475,7 +475,7 @@ static void leaf_item_bottle(struct buff
 			 * 'cpy_bytes'; create new item header;
 			 * n_ih = new item_header;
 			 */
-			memcpy(&n_ih, ih, SHORT_KEY_SIZE);
+			memcpy(&n_ih.ih_key, &ih->ih_key, KEY_SIZE);
 
 			/* Endian safe, both le */
 			n_ih.ih_version = ih->ih_version;
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -1326,7 +1326,6 @@ struct cpu_key {
 #define KEY_NOT_FOUND 0
 
 #define KEY_SIZE (sizeof(struct reiserfs_key))
-#define SHORT_KEY_SIZE (sizeof (__u32) + sizeof (__u32))
 
 /* return values for search_by_key and clones */
 #define ITEM_FOUND 1
