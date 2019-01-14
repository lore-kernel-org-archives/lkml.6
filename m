Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F4EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63592064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl7N9JoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfANUSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:18:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43510 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfANUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:18:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so349416wrs.10;
        Mon, 14 Jan 2019 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnUk7Vfdk/xAtPXiFSxFZAr/2Ww8OZUZk/tQppj/ZsE=;
        b=Tl7N9JoKz9qxCeOiMJ7uR/aL4XfuGYqrDEc5HxJ79R8D7ufHXmLqoKW/kcwpH9fsS+
         8+btMry+Gg2yPcbzfAX4j+OzToyL+RRgiObEQDgMtZqfrB2Ysbujy1+Ofzkr/Mshvhis
         hA88n/weKQrRbS1bDlw39JKb9qFhIHKcR6yCaoWfPt61PVQubye2n/ny+HxN6TCbPW9k
         3iFPGC3KMN49cmJwkiqGfbiuQwJNa9T7ggCcTmaP9CTDhzWhbc9BATPBzOAxVvWX6ZRb
         2hkVya3McFJeZRGweRAP/jWOAyDAp7EEo1QELIq54ox//DKITmllLG+/ui6RC1wpr4NT
         kXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=EnUk7Vfdk/xAtPXiFSxFZAr/2Ww8OZUZk/tQppj/ZsE=;
        b=GbqNjflYs2+0FH/+ajZnie28QnwuexBPtRXZ52Q9SfigA9NlkC3nKgwEzElbhSDLY1
         NcS91fYxHHFg9JlgpEpDOr2QSBMhtgry/Q6JWQH8Nge7GVEyC1qGYZQT7G97C0dgNpx2
         gbqO8LVrsX6f2AaxnRQ8d2MPu6PIW0+o7xOSZ+e1c6HgiFRWzkknjDDWLsah3dSDYQjy
         z9wkBVMyZ1/TF4wJoG62Efglcvg87cFOzcqWm3WKNVubYMgCEOpOTi1mHGKAGZVd3nrO
         DjHLO7afIAnxE2WgJbONVla/dsR2nFlx6QdLA6uExgRA8tmFFajUW4EEKjg7jr6WT4fE
         +UHQ==
X-Gm-Message-State: AJcUukfmvwaKbLR+WfjpoifVw149oPUJwUWLByv74DyECCNqzam/HqzG
        FnxIJei0fzU8WesSmBWH/yo=
X-Google-Smtp-Source: ALg8bN5NR290pUaF4gsZNeBkaXdp3qB0bfUDKPnKofybnSIAipjrsOmSpRJnzJ/UU93s57Rxc92XWw==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr166855wrw.113.1547497085317;
        Mon, 14 Jan 2019 12:18:05 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id c12sm70875285wrs.82.2019.01.14.12.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:18:04 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 4C11511422AD; Mon, 14 Jan 2019 21:18:03 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] security: keys: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:17:23 +0100
Message-Id: <20190114201725.13289-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  security/keys/keyring.c:248:10: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 security/keys/keyring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index eadebb92986a..b1ff07d9ce37 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -246,6 +246,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 				    (ASSOC_ARRAY_KEY_CHUNK_SIZE - 8));
 		n--;
 		offset = 1;
+		/* fall through */
 	default:
 		offset += sizeof(chunk) - 1;
 		offset += (level - 3) * sizeof(chunk);
-- 
2.19.2

