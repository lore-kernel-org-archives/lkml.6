Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9307DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571292146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131994;
	bh=4tOQOQ975v+husGHCmGTbLnk+t3RP+HkM1u1R8LwyBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1BVSgFByuHbn9CNkpaBDah+F9mvnQtrUxb+Pal0tkEmYu+h1W5fQCfmsP31sUrO64
	 37Nl8SIet2oAayKSeVPnDW8HpVVd08ioX0L5Y7lbdwq7OwYkmDVcWuCWLrFfU26G4N
	 Hfc0zEE/Cenm5Z2SWeb5qHZSCzXub41Jle0mXN1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfBYV7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbfBYVSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:18:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F62217F4;
        Mon, 25 Feb 2019 21:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129517;
        bh=4tOQOQ975v+husGHCmGTbLnk+t3RP+HkM1u1R8LwyBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oc2cZs1ZCxEKb9+yy1hOMyqDgU0cqToKzfRHbzkezymDhz9Cq9eQisSLZ8ESviuBM
         tN6gOHmrR3VOSXE0w+mwcgEUWq1/Sil08FdxR7WASXhEkv5C/0hU2iK2m44RWhC2GX
         Mh4d/mkcc05nZ1CweL6mXoIWd6uXJb9jvFQ3G+kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.14 56/71] KEYS: user: Align the payload buffer
Date:   Mon, 25 Feb 2019 22:11:58 +0100
Message-Id: <20190225195038.854655732@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit cc1780fc42c76c705dd07ea123f1143dc5057630 upstream.

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
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/keys/user-type.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


