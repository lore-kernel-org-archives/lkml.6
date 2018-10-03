Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55120C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDB021470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYgIPH8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDB021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJDClV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:41:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45510 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDClV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:41:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id v18-v6so5395231edq.12;
        Wed, 03 Oct 2018 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zUXIu5skTQsoaGQbbIfLurPEf5n3ULdGVZlUxsl2a+U=;
        b=eYgIPH8NVLtU9oOawWnsNs1oiZM5jH81tczhRHfc9ZBU5lTLQbGVW9vmGdzLzBT1TK
         vx/wML+J39GukO41x/Ch/HvwcToBwa9IUH648C8pGZFQlUA62XrfRRUgzgSGHbm2c7gb
         Ygrbi2jCDNLbOq741kvVvyKLkknPJG+CBuLAgCdUv1Jgv859wOffrI6raoYeozmNGhIl
         BZeDYqVDHvZqenJ69DmJG2aAKpqma/J1SmsgqIMZOfq7/hMDAf5QbRAUikh35Bd2SN3Y
         P6E2z5syGNpFbtUHo9CkGa644hZykIQyRnYfiklGJdckXAm6NFavHT4cTpXyAYzdR2WQ
         wCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zUXIu5skTQsoaGQbbIfLurPEf5n3ULdGVZlUxsl2a+U=;
        b=jCUM/roYvsTg9jaquk3nUDe5/6VnK6XXjzVjzRG+PXO31zdFWzTwvXXAeFNkgjvo8b
         IoNz97vEu0wK+gZf4RKv45sKNwB6I3375S7E16y4xiOAqMZINijWjjYbishZwjJrziFt
         dMKMuRnSHGYDnUwRCOqMlr5u6Wh2Lmti+mTIiUy67E2oXbRlGIXuNo9U1MMXpDe7+Bba
         W1uXBSzzbNj/WnuPk7zcVIVrlWsSRuneyAp61E6hGit30QutRhhHMC2EUc2ey1vfSjsl
         1FbKG43z3rZ49r3n8IQzBbmlGuHasGInTiPnjZUBtEMLzAoyz69p9WOHueDW0DNZuYWb
         dUNQ==
X-Gm-Message-State: ABuFfoiPPZrb72g6CLFFmxYe25nx7nvrN5dpQvGaufEdv5n+e8OaMPcQ
        Em5S06QUfQ35pcgh2ajfw0rmOtI=
X-Google-Smtp-Source: ACcGV61hlV7qm4mrVQRWdyrITGXk5UnWqnmgBcI1psrSi8BAPQZThZqPUjDKeYyYzIjesquCWAvW1A==
X-Received: by 2002:a17:906:7298:: with SMTP id b24-v6mr3459037ejl.16.1538596290489;
        Wed, 03 Oct 2018 12:51:30 -0700 (PDT)
Received: from localhost.Home ([2a02:c7d:9b5c:9b00:77f2:9bbb:62f:80e6])
        by smtp.gmail.com with ESMTPSA id c29-v6sm763628eda.53.2018.10.03.12.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:51:29 -0700 (PDT)
From:   Garry McNulty <garrmcnu@gmail.com>
To:     linux-cifs@vger.kernel.org
Cc:     sfrench@samba.org, lsahlber@redhat.com,
        linux-kernel@vger.kernel.org, Garry McNulty <garrmcnu@gmail.com>
Subject: [PATCH] fs/cifs: fix uninitialised variable warnings
Date:   Wed,  3 Oct 2018 20:51:21 +0100
Message-Id: <20181003195121.6059-1-garrmcnu@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some error conditions, resp_buftype can be passed uninitialised to
free_rsp_buf(), potentially resulting in a spurious debug message.
If resp_buftype randomly had the value 1 (CIFS_SMALL_BUFFER) then this
would log a debug message.
The rsp pointer is initialised to NULL so there is no other side-effect.

Detected by CoverityScan, CID 1438585 ("Uninitialized scalar variable")
Detected by CoverityScan, CID 1438667 ("Uninitialized scalar variable")
Detected by CoverityScan, CID 1438764 ("Uninitialized scalar variable")

Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
---
 fs/cifs/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index f54d07bda067..65a864b8d09e 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2261,7 +2261,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	struct cifs_ses *ses = tcon->ses;
 	struct kvec iov[SMB2_CREATE_IOV_SIZE];
 	struct kvec rsp_iov = {NULL, 0};
-	int resp_buftype;
+	int resp_buftype = CIFS_NO_BUFFER;
 	int rc = 0;
 	int flags = 0;
 
@@ -2547,7 +2547,7 @@ SMB2_close_flags(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_ses *ses = tcon->ses;
 	struct kvec iov[1];
 	struct kvec rsp_iov;
-	int resp_buftype;
+	int resp_buftype = CIFS_NO_BUFFER;
 	int rc = 0;
 
 	cifs_dbg(FYI, "Close\n");
@@ -2699,7 +2699,7 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 	struct kvec iov[1];
 	struct kvec rsp_iov;
 	int rc = 0;
-	int resp_buftype;
+	int resp_buftype = CIFS_NO_BUFFER;
 	struct cifs_ses *ses = tcon->ses;
 	int flags = 0;
 
-- 
2.14.4

