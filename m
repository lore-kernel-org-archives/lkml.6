Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA68C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCD42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547523486;
	bh=JUpAOUywM6hifFeXQvdLEgB0MWZVn/CHE2Ud6i3FjuQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2EZGHKTjmVtdLXyUM1ecBpwoILine+RL1lj1xi09XfvGBqerIfHMc+Cb2MCX4gnjd
	 Xv+5MqjbgoXOUY1j+ddFNbDUDtKG0csygDPBepo886FTGKrivTkK1H3QdrN+Sn8QXU
	 8CvBIoDNoYyUFRevE/ZxHT77N2PVES6HEOCFIdZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfAODiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:38:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAODiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:38:04 -0500
Received: from sol.localdomain (c-24-23-143-129.hsd1.ca.comcast.net [24.23.143.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29DD920656;
        Tue, 15 Jan 2019 03:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547523483;
        bh=JUpAOUywM6hifFeXQvdLEgB0MWZVn/CHE2Ud6i3FjuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=i20h1xODrYvzGHqe9qFAwY0GaNB5p0Vukq6JbX2Dboplk82/FrBgsviOe5mDz0DK5
         GQ3UmrFOxK0Rgwt9Sy60P3wYbk9FLKjZ84hL6f2XfIiLuFGUdFkRjLKY8qQlaMiXb4
         WiU6eb+Ab75eHvzoy7A3ArTmPrqFVtwbjE7f4Kp8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: user: Align the payload buffer
Date:   Mon, 14 Jan 2019 19:37:16 -0800
Message-Id: <20190115033716.18380-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Align the payload of "user" and "logon" keys so that users of the
keyrings service can access it as a struct that requires more than
2-byte alignment.  fscrypt currently does this which results in the read
of fscrypt_key::size being misaligned as it needs 4-byte alignment.

Align to __alignof__(u64) rather than __alignof__(long) since in the
future it's conceivable that people would use structs beginning with
u64, which on some platforms would require more than 'long' alignment.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Fixes: 2aa349f6e37c ("[PATCH] Keys: Export user-defined keyring operations")
Fixes: 88bd6ccdcdd6 ("ext4 crypto: add encryption key management facilities")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/keys/user-type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index e098cbe27db54..12babe9915944 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -31,7 +31,7 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[0];	/* actual data */
+	char		data[0] __aligned(__alignof__(u64)); /* actual data */
 };
 
 extern struct key_type key_type_user;
-- 
2.20.1

