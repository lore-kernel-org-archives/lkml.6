Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03907C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DC6206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="JF9kKJzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DC6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbeIHC3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:29:05 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:33295 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbeIHC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356768; x=1567892768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2g0vLjz9qDuS0FX7BXUsxldSJNt1CuhQm4FEgJ1FZ3A=;
  b=JF9kKJztAOCezXezT8RwJ6XcPCoAeVylGVweB6oHGhch1GdbGOxS/HDq
   eJmx4JW9J73ghkg0qZ5KkPMMNdmoQUMHOF66efqiajR97HrtOVrUMS8Us
   21Q008qfOczptAq7EtasiA2rFEXKjfgpfTqfZCBkgjRtfL/7VcO62dcWc
   4=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="757370669"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-a11fcaa7.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:35 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2c-a11fcaa7.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfXP4093652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:35 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfVJE027216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:31 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfUQq027215;
        Fri, 7 Sep 2018 23:41:30 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 12/60] locking/lockdep: Make cookie generator accessible
Date:   Fri,  7 Sep 2018 23:39:59 +0200
Message-Id: <20180907214047.26914-13-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a dynamic amount of locks needs to be pinned in the same context,
it is impractical to have a cookie per lock. Make the cookie generator
accessible, so that such a group of locks can be (re-)pinned with
just one (shared) cookie.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 include/linux/lockdep.h  |  2 ++
 kernel/locking/lockdep.c | 21 +++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index d93a5ec3077f..06aee3386071 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -363,6 +363,7 @@ struct pin_cookie { unsigned int val; };
 
 #define NIL_COOKIE (struct pin_cookie){ .val = 0U, }
 
+struct pin_cookie lockdep_cookie(void);
 extern struct pin_cookie lock_pin_lock(struct lockdep_map *lock);
 extern void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie);
 extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
@@ -452,6 +453,7 @@ struct pin_cookie { };
 
 #define NIL_COOKIE (struct pin_cookie){ }
 
+#define lockdep_cookie()			(NIL_COOKIE)
 #define lockdep_pin_lock(l)			({ struct pin_cookie cookie; cookie; })
 #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e406c5fdb41e..76aae27e1736 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3729,6 +3729,20 @@ static int __lock_is_held(const struct lockdep_map *lock, int read)
 	return 0;
 }
 
+struct pin_cookie lockdep_cookie(void)
+{
+	struct pin_cookie cookie;
+
+	/*
+	 * Grab 16bits of randomness; this is sufficient to not
+	 * be guessable and still allows some pin nesting in
+	 * our u32 pin_count.
+	 */
+	cookie.val = 1 + (prandom_u32() >> 16);
+
+	return cookie;
+}
+
 static struct pin_cookie __lock_pin_lock(struct lockdep_map *lock)
 {
 	struct pin_cookie cookie = NIL_COOKIE;
@@ -3742,12 +3756,7 @@ static struct pin_cookie __lock_pin_lock(struct lockdep_map *lock)
 		struct held_lock *hlock = curr->held_locks + i;
 
 		if (match_held_lock(hlock, lock)) {
-			/*
-			 * Grab 16bits of randomness; this is sufficient to not
-			 * be guessable and still allows some pin nesting in
-			 * our u32 pin_count.
-			 */
-			cookie.val = 1 + (prandom_u32() >> 16);
+			cookie = lockdep_cookie();
 			hlock->pin_count += cookie.val;
 			return cookie;
 		}
-- 
2.9.3.1.gcba166c.dirty

