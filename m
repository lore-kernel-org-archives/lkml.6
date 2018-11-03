Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A142C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 01:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317CC2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 01:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA7or1AK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317CC2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeKCLJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 07:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKCLJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 07:09:23 -0400
Received: from sol.hsd1.wa.comcast.net (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983142082D;
        Sat,  3 Nov 2018 01:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541210387;
        bh=Dt4O2Re6+WrrGvALQ9ol0uDtX6tVKxnGIKbHB8XRO2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FA7or1AKaB9Yi9EcxAMYhEdDV/USFo9C6sJnhsdoGnD9sMzMX0yACc4hS1VMDCmxr
         0noFHsd1j2Au18+f4Gd99KGELoiY0aV9qJ26mK/HJKR+5+EEwl7oKzphjt73aX/2wv
         kQU8MrBVZG7WAJInLQQTvJscy+DfH9i4Wzc/4bEA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] KEYS: always initialize keyring_index_key::desc_len
Date:   Fri,  2 Nov 2018 18:58:54 -0700
Message-Id: <20181103015854.7380-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <000000000000a722550577796543@google.com>
References: <000000000000a722550577796543@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

syzbot hit the 'BUG_ON(index_key->desc_len == 0);' in __key_link_begin()
called from construct_alloc_key() during sys_request_key(), because the
length of the key description was never calculated.

The problem is that we rely on ->desc_len being initialized by
search_process_keyrings(), specifically by search_nested_keyrings().
But, if the process isn't subscribed to any keyrings that never happens.

Fix it by always initializing keyring_index_key::desc_len as soon as the
description is set, like we already do in some places.

The following program reproduces the BUG_ON() when it's run as root and
no session keyring has been installed.  If it doesn't work, try removing
pam_keyinit.so from /etc/pam.d/login and rebooting.

    #include <stdlib.h>
    #include <unistd.h>
    #include <keyutils.h>

    int main(void)
    {
            int id = add_key("keyring", "syz", NULL, 0, KEY_SPEC_USER_KEYRING);

            keyctl_setperm(id, KEY_OTH_WRITE);
            setreuid(5000, 5000);
            request_key("user", "desc", "", id);
    }

Reported-by: syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com
Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Cc: <stable@vger.kernel.org> # v3.13+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: In proc_keys_show(), assign index_key directly

 security/keys/keyring.c          | 4 +---
 security/keys/proc.c             | 3 +--
 security/keys/request_key.c      | 1 +
 security/keys/request_key_auth.c | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 41bcf57e96f21..99a55145ddcd2 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -661,9 +661,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	BUG_ON((ctx->flags & STATE_CHECKS) == 0 ||
 	       (ctx->flags & STATE_CHECKS) == STATE_CHECKS);
 
-	if (ctx->index_key.description)
-		ctx->index_key.desc_len = strlen(ctx->index_key.description);
-
 	/* Check to see if this top-level keyring is what we are looking for
 	 * and whether it is valid or not.
 	 */
@@ -914,6 +911,7 @@ key_ref_t keyring_search(key_ref_t keyring,
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
 		.index_key.description	= description,
+		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 5af2934965d80..d38be9db2cc07 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -166,8 +166,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	int rc;
 
 	struct keyring_search_context ctx = {
-		.index_key.type		= key->type,
-		.index_key.description	= key->description,
+		.index_key		= key->index_key,
 		.cred			= m->file->f_cred,
 		.match_data.cmp		= lookup_user_key_possessed,
 		.match_data.raw_data	= key,
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 114f7408feee6..7385536986497 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -545,6 +545,7 @@ struct key *request_key_and_link(struct key_type *type,
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
 		.index_key.description	= description,
+		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 424e1d90412ea..6797843154f03 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -246,7 +246,7 @@ struct key *key_get_instantiation_authkey(key_serial_t target_id)
 	struct key *authkey;
 	key_ref_t authkey_ref;
 
-	sprintf(description, "%x", target_id);
+	ctx.index_key.desc_len = sprintf(description, "%x", target_id);
 
 	authkey_ref = search_process_keyrings(&ctx);
 
-- 
2.19.1

