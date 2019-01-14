Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7EEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1C420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWedDyfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfANUkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:40:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39058 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfANUkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:40:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so450270wra.6;
        Mon, 14 Jan 2019 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Njcy+xFgK9q4qTggHvR0jHWYKD4glHvqhdsJrZvho/U=;
        b=uWedDyfovUNSuAqGQS72aZBMrdfGHhw2Ucb46WLR59spS94Asfmu37HRUX0H5Cb+C6
         7Q1aiVnxtbQiiNUWDFIO64FjReiKgbQDpsPaI3XVqp6uwXo0wM1iup36kfbqstbcl0uH
         9GNxG3jiMsX1M7R5QwcX6FLqGe7WHioQ27tXej8CWqj2iX4zBYsvVhkjprcAXCTw9yv1
         32074OacQf7rPw9MnWvMxNVm/kFQVuYsr8TNzbanD/hbIa3Nt8h9BbUOuhHn0hX+LmI6
         +T0yYxcu0hdFZ1OaRFNse1gOt4vAgnKvVoeQbN/Xi3wrKSi+3TDEYQklKjDpBVB9H9fr
         3o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Njcy+xFgK9q4qTggHvR0jHWYKD4glHvqhdsJrZvho/U=;
        b=D6XSO+eLrNqO1ugyvz0TYYt4g3oofpjclTBOiW9yfkGsSBvBoE+doWkiD/ZI19KiQP
         p8W5uhZa73Yjc5WHXIj9mbXFFc1iJRKT2bJ4GILQpW86Q492ns/MRQ6bpo6wyqqvGFdr
         H5roXulsoYhvPfylJm+U7OAAzaqOl78puAgEHhQ2artyM6SnPp3K5JChy0Zl96P1OX5G
         Lqh9QI7bh4fYDAjy0FkVSJFb5dpaOFwYdRfKOnbJhQxGbbDnwRWTvOPczoP22J3Lr2iy
         +xFRfj6hmVpa+VUQ44TmmTUTVQjkUugx1TVW8+nBjeIlSYrRGA3C9jMiNAgkBbm8fRXb
         +zIw==
X-Gm-Message-State: AJcUukeO3s1oq1otYl38XMGlHp5OmXz7suVRlZKD74tTIy9F9t6PIEbF
        C92rVlUwFGkOdRjaB8llUsMZv3Iw
X-Google-Smtp-Source: ALg8bN4d2lk6ctBeo187wcGN0JyuRCFQC1/d9HS25XrqivJEjq3RxBXzhuzLEQ1+HumFoJnCc57JgA==
X-Received: by 2002:adf:fc09:: with SMTP id i9mr188341wrr.299.1547498419143;
        Mon, 14 Jan 2019 12:40:19 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id r77sm37020463wmd.22.2019.01.14.12.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:40:17 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 2AF3411422AD; Mon, 14 Jan 2019 21:40:16 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ext4: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:39:43 +0100
Message-Id: <20190114203945.20233-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  fs/ext4/hash.c:233:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
  fs/ext4/hash.c:246:15: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/ext4/hash.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index e22dcfab308b..46b24da33a28 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -231,6 +231,7 @@ int ext4fs_dirhash(const char *name, int len, struct dx_hash_info *hinfo)
 		break;
 	case DX_HASH_HALF_MD4_UNSIGNED:
 		str2hashbuf = str2hashbuf_unsigned;
+		/* fall through */
 	case DX_HASH_HALF_MD4:
 		p = name;
 		while (len > 0) {
@@ -244,6 +245,7 @@ int ext4fs_dirhash(const char *name, int len, struct dx_hash_info *hinfo)
 		break;
 	case DX_HASH_TEA_UNSIGNED:
 		str2hashbuf = str2hashbuf_unsigned;
+		/* fall through */
 	case DX_HASH_TEA:
 		p = name;
 		while (len > 0) {
-- 
2.19.2

