Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF98C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F39920659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKrDWTjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfANUkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:40:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39915 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfANUkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:40:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so997112wmi.4;
        Mon, 14 Jan 2019 12:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Im+S4MYp2sak4c0j7sO7o1zps+bu02T7X9NGufahYS8=;
        b=SKrDWTjUa0uPlj2I6xJs/sTHqd8+wlpzX//qRmAJFHGtl43d1xb/xr7sPicxQ4+/2Q
         Vl9YAQn8M9Yaa7Hh/pphy10yChcyoco1fNBLll2zRX1/5AsdR3jYgH3t0PgdmEvEPjpc
         H3eoaZ+7b+nlSxhl5yUWPHRrGB7bsx36Lro5eayGTgCQirGimrhH1Qmhvnrd67j7NTYC
         YMQszqFj/TxLj8kNp9hSl+57CxF5J9qLaHGLJ8/OtC3dY03JnX1qbgtU1fp/6kp4hu0i
         2+ISu2hZMWKv3xrSm16j4QC3P58QEBEZ5wZEipKUjwhOMsYWPB7zDBakwHGCVImQ8SI1
         JiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Im+S4MYp2sak4c0j7sO7o1zps+bu02T7X9NGufahYS8=;
        b=ES3VrY204xvNm+R0uvxmx8p92Pkm7IjSxrJINb0fQCYK5e07fe724+Tnim08BfnxBJ
         JL+Ej8FWNDMFU5RxiI/fHvZONtU2bjDPWzOsYASXxfO57L3rx/1sPY2Nk1pcODWGnXh4
         L1/uf8bUBQDzvdXn0Xpp/hWu6NRXNkhRaLwnbIoyk3ne720ePeum7SLnIAPCXH9wxIOb
         TGifaRVkMAlkU/Gk8iXaYgY6U9Ct4ruBCmdEGY07icpA12Zzn0h/oxEQp+3lTiDEo/UN
         me//rY0dHfUhazmLFQdoRz2ILpiOiYRZ7wCzkP/TB3OVLubPoVDKoR2aMeVsCNZn0+tO
         XpcQ==
X-Gm-Message-State: AJcUukcn2FSOP90H25AFVlDZQU3AD6wxwAsjsPDOJ9lrLAN4ZnYmCPNh
        0JR0JPHB3bbjHJ5yaqc1Az8HH+61
X-Google-Smtp-Source: ALg8bN7zXTjwVkUMxnuCMyNekLrZjuJlU0/Oy+cvdnB/AbNN2LIa53d6EaRFJrJX2LK/WuZ1jgXRBg==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr636225wmf.17.1547498419660;
        Mon, 14 Jan 2019 12:40:19 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id d4sm19023824wmb.25.2019.01.14.12.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:40:19 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CE59E11422D0; Mon, 14 Jan 2019 21:40:17 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ext4: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:39:44 +0100
Message-Id: <20190114203945.20233-2-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114203945.20233-1-malat@debian.org>
References: <20190114203945.20233-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  fs/ext4/indirect.c:1182:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  fs/ext4/indirect.c:1188:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  fs/ext4/indirect.c:1432:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  fs/ext4/indirect.c:1440:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/ext4/indirect.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index bf7fa1507e81..c2225f0d31b5 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1183,18 +1183,21 @@ void ext4_ind_truncate(handle_t *handle, struct inode *inode)
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 1);
 			i_data[EXT4_IND_BLOCK] = 0;
 		}
+		/* fall through */
 	case EXT4_IND_BLOCK:
 		nr = i_data[EXT4_DIND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 2);
 			i_data[EXT4_DIND_BLOCK] = 0;
 		}
+		/* fall through */
 	case EXT4_DIND_BLOCK:
 		nr = i_data[EXT4_TIND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 3);
 			i_data[EXT4_TIND_BLOCK] = 0;
 		}
+		/* fall through */
 	case EXT4_TIND_BLOCK:
 		;
 	}
@@ -1433,6 +1436,7 @@ int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 1);
 			i_data[EXT4_IND_BLOCK] = 0;
 		}
+		/* fall through */
 	case EXT4_IND_BLOCK:
 		if (++n >= n2)
 			return 0;
@@ -1441,6 +1445,7 @@ int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 2);
 			i_data[EXT4_DIND_BLOCK] = 0;
 		}
+		/* fall through */
 	case EXT4_DIND_BLOCK:
 		if (++n >= n2)
 			return 0;
@@ -1449,6 +1454,7 @@ int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 3);
 			i_data[EXT4_TIND_BLOCK] = 0;
 		}
+		/* fall through */
 	case EXT4_TIND_BLOCK:
 		;
 	}
-- 
2.19.2

