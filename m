Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bdGDC1JXGVu3eQAAmS7hNA
	; Thu, 07 Jun 2018 16:03:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 16E0A6074D; Thu,  7 Jun 2018 16:03:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A27E60590;
	Thu,  7 Jun 2018 16:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A27E60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935232AbeFGQAa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:00:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39335 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933046AbeFGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005Zo-KA; Thu, 07 Jun 2018 15:09:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002va-Qf; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Trond Myklebust" <trondmy@gmail.com>,
        "Eric Biggers" <ebiggers@google.com>,
        syzbot+5dfdbcf7b3eb5912abbb@syzkaller.appspotmail.com
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.581957380@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 158/410] NFS: reject request for id_legacy key
 without auxdata
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 49686cbbb3ebafe42e63868222f269d8053ead00 upstream.

nfs_idmap_legacy_upcall() is supposed to be called with 'aux' pointing
to a 'struct idmap', via the call to request_key_with_auxdata() in
nfs_idmap_request_key().

However it can also be reached via the request_key() system call in
which case 'aux' will be NULL, causing a NULL pointer dereference in
nfs_idmap_prepare_pipe_upcall(), assuming that the key description is
valid enough to get that far.

Fix this by making nfs_idmap_legacy_upcall() negate the key if no
auxdata is provided.

As usual, this bug was found by syzkaller.  A simple reproducer using
the command-line keyctl program is:

    keyctl request2 id_legacy uid:0 '' @s

Fixes: 57e62324e469 ("NFS: Store the legacy idmapper result in the keyring")
Reported-by: syzbot+5dfdbcf7b3eb5912abbb@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Trond Myklebust <trondmy@gmail.com>
pbwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfs/idmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/nfs/idmap.c
+++ b/fs/nfs/idmap.c
@@ -577,9 +577,13 @@ static int nfs_idmap_legacy_upcall(struc
 	struct idmap_msg *im;
 	struct idmap *idmap = (struct idmap *)aux;
 	struct key *key = cons->key;
-	int ret = -ENOMEM;
+	int ret = -ENOKEY;
+
+	if (!aux)
+		goto out1;
 
 	/* msg and im are freed in idmap_pipe_destroy_msg */
+	ret = -ENOMEM;
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		goto out1;
