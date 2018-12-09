Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D84C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FE32081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FE32081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeLIWTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:19:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35596 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbeLIVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:27 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72q-0002po-Nd; Sun, 09 Dec 2018 21:55:24 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003hS-Oc; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Mimi Zohar" <zohar@linux.vnet.ibm.com>,
        "David Howells" <dhowells@redhat.com>,
        "James Morris" <james.l.morris@oracle.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.265897703@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 322/328] KEYS: encrypted: fix buffer overread in
 valid_master_desc()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 794b4bc292f5d31739d89c0202c54e7dc9bc3add upstream.

With the 'encrypted' key type it was possible for userspace to provide a
data blob ending with a master key description shorter than expected,
e.g. 'keyctl add encrypted desc "new x" @s'.  When validating such a
master key description, validate_master_desc() could read beyond the end
of the buffer.  Fix this by using strncmp() instead of memcmp().  [Also
clean up the code to deduplicate some logic.]

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/keys/encrypted-keys/encrypted.c | 31 ++++++++++++------------
 1 file changed, 15 insertions(+), 16 deletions(-)

--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -141,23 +141,22 @@ static int valid_ecryptfs_desc(const cha
  */
 static int valid_master_desc(const char *new_desc, const char *orig_desc)
 {
-	if (!memcmp(new_desc, KEY_TRUSTED_PREFIX, KEY_TRUSTED_PREFIX_LEN)) {
-		if (strlen(new_desc) == KEY_TRUSTED_PREFIX_LEN)
-			goto out;
-		if (orig_desc)
-			if (memcmp(new_desc, orig_desc, KEY_TRUSTED_PREFIX_LEN))
-				goto out;
-	} else if (!memcmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN)) {
-		if (strlen(new_desc) == KEY_USER_PREFIX_LEN)
-			goto out;
-		if (orig_desc)
-			if (memcmp(new_desc, orig_desc, KEY_USER_PREFIX_LEN))
-				goto out;
-	} else
-		goto out;
+	int prefix_len;
+
+	if (!strncmp(new_desc, KEY_TRUSTED_PREFIX, KEY_TRUSTED_PREFIX_LEN))
+		prefix_len = KEY_TRUSTED_PREFIX_LEN;
+	else if (!strncmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN))
+		prefix_len = KEY_USER_PREFIX_LEN;
+	else
+		return -EINVAL;
+
+	if (!new_desc[prefix_len])
+		return -EINVAL;
+
+	if (orig_desc && strncmp(new_desc, orig_desc, prefix_len))
+		return -EINVAL;
+
 	return 0;
-out:
-	return -EINVAL;
 }
 
 /*

