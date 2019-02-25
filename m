Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E80CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9E320578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130646;
	bh=t12T4BRSDWQiLtqzp/zZCowNkEoAT030Bn8V1mrT5mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KT+y30NpQgKfcEOfdGgR7AAEZ5PZjG8LtY1cfKs5x9fYKXAsnWoD4aSOfnsJgoOwh
	 aNDLnl6aGtA1xjxApVNbCd6jyC/iUahPUKIgTi1o0E+bOrPbCYlFY8wtuhVIHBME70
	 7yuX9Zw5EQb68IqH9rFonqyl3buM0SSNBWKCjP20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbfBYVhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387437AbfBYVhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404C420578;
        Mon, 25 Feb 2019 21:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130640;
        bh=t12T4BRSDWQiLtqzp/zZCowNkEoAT030Bn8V1mrT5mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1Sc0n+M/p2FgBiouCzvd4nVaJfIMAGa1qtwVcaA2xrTlJOuDLfmnuGU3YiNaO4Hs
         xYV7u7zaoG1kj7zYotAFXOd++bFgEityqXNMBWHYgF8ZPffaEKomuGAY2bs3BtlS1K
         jVM9pH4onQKYCSHrNSxaUY1TzoIbgWsb7LYyD/4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.20 148/183] KEYS: always initialize keyring_index_key::desc_len
Date:   Mon, 25 Feb 2019 22:12:01 +0100
Message-Id: <20190225195119.950878052@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit ede0fa98a900e657d1fcd80b50920efc896c1a4c upstream.

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
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/keys/keyring.c          |    4 +---
 security/keys/proc.c             |    3 +--
 security/keys/request_key.c      |    1 +
 security/keys/request_key_auth.c |    2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -661,9 +661,6 @@ static bool search_nested_keyrings(struc
 	BUG_ON((ctx->flags & STATE_CHECKS) == 0 ||
 	       (ctx->flags & STATE_CHECKS) == STATE_CHECKS);
 
-	if (ctx->index_key.description)
-		ctx->index_key.desc_len = strlen(ctx->index_key.description);
-
 	/* Check to see if this top-level keyring is what we are looking for
 	 * and whether it is valid or not.
 	 */
@@ -914,6 +911,7 @@ key_ref_t keyring_search(key_ref_t keyri
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
 		.index_key.description	= description,
+		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -166,8 +166,7 @@ static int proc_keys_show(struct seq_fil
 	int rc;
 
 	struct keyring_search_context ctx = {
-		.index_key.type		= key->type,
-		.index_key.description	= key->description,
+		.index_key		= key->index_key,
 		.cred			= m->file->f_cred,
 		.match_data.cmp		= lookup_user_key_possessed,
 		.match_data.raw_data	= key,
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -545,6 +545,7 @@ struct key *request_key_and_link(struct
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
 		.index_key.description	= description,
+		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -246,7 +246,7 @@ struct key *key_get_instantiation_authke
 	struct key *authkey;
 	key_ref_t authkey_ref;
 
-	sprintf(description, "%x", target_id);
+	ctx.index_key.desc_len = sprintf(description, "%x", target_id);
 
 	authkey_ref = search_process_keyrings(&ctx);
 


