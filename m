Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1A0ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB2B20847
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeSZ6TOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB2B20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeKDCnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeKDCnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:43:53 -0400
Received: from sol.hsd1.wa.comcast.net (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA38204FD;
        Sat,  3 Nov 2018 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541266319;
        bh=IGAfYU3Pfm4+sGhdvRi7hYJ24eo0U9IhorK77ij0uhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FeSZ6TOYu3QavAkiqQh9Qr5OV95Cc3gntJOitC4NVQbk9rl9ZszGYFyFn2a6vqGxR
         +0c5r0+ZPrOOWQr0KQ2RXok00taZQaD/vbBXFoXZqKJW7HmkAEjXgOxaPjkGtgzRsH
         HTBOXoWjfczZHnf1P0BE8speuy/8QJMRqHWvqCQs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, dhowells@redhat.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] KEYS: fix parsing invalid pkey info string
Date:   Sat,  3 Nov 2018 10:30:35 -0700
Message-Id: <20181103173035.23974-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <000000000000c220960579c4936d@google.com>
References: <000000000000c220960579c4936d@google.com>
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
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
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
2.19.1

