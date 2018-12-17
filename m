Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB53D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545070436;
	bh=JvD/QoTIklCEw2Q2kwPHnVLWaDNfoScivZFjKlc5saY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jexEhJpInlHE6kvarFVon2jEXsViM2ABayzAJSljIVcpHzA3/l/Zb5hIPxpiGkJ7L
	 l5NHpzwRN5RqHgBZCQWC+D53fchyEPwtBUE/AjwB1kgjPMFRxqwfsPzedqtdxIC/qR
	 aJkyGPjzawSGbPWP/Dsg8Kr+Iz9cBgSkUeqispjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeLQSNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:13:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbeLQSNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:13:55 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8585C20675;
        Mon, 17 Dec 2018 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545070434;
        bh=JvD/QoTIklCEw2Q2kwPHnVLWaDNfoScivZFjKlc5saY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkLHPGmI9QY1ewwLnO2oagsx7eR+hDXaZEnzamFUDEOXQ+8BYHeRBxLkebdAuVS3D
         QAB+f5N7NMUERmSWA9rsUvzKS8sP69oyh9oB7XK8zPpih2NwZCV0GS37HbAq8FRPao
         9HnbfdCibo9VhWHm9asyK6VeAaKY/D3JNGFNm8QY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Date:   Mon, 17 Dec 2018 10:12:44 -0800
Message-Id: <20181217181244.220052-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
In-Reply-To: <20181128232019.GC131170@gmail.com>
References: <20181128232019.GC131170@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

We need to check the return value of match_token() for Opt_err (-1)
before doing anything with it.

Reported-by: syzbot+a22e0dc07567662c50bc@syzkaller.appspotmail.com
Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Hi Linus, please consider applying this patch.  It's been ignored by the
keyrings maintainer for a month and a half with multiple reminders.  It
fixes an easily reachable stack corruption in the new keyctl operations
that were added in v4.20.  It was immediately reached by syzbot even
without any definitions for the new keyctls yet.

 security/keys/keyctl_pkey.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 783978842f13a..987fac8051d70 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -50,6 +50,8 @@ static int keyctl_pkey_params_parse(struct kernel_pkey_params *params)
 		if (*p == '\0' || *p == ' ' || *p == '\t')
 			continue;
 		token = match_token(p, param_keys, args);
+		if (token == Opt_err)
+			return -EINVAL;
 		if (__test_and_set_bit(token, &token_mask))
 			return -EINVAL;
 		q = args[0].from;
-- 
2.20.0.405.gbc1bbc6f85-goog

