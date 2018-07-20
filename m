Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674A9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228B520833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+N80vWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228B520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbeGTNYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:24:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32852 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbeGTNYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:24:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so9666281edr.0;
        Fri, 20 Jul 2018 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kN/XaSPBXfxyVunG3MHFniOIIjaLqK5gHO/Wmde/C3E=;
        b=O+N80vWIzFBeyTZGhaoEVkvugNmY+dQjz03Ib5MSRwE8Mh9Kemv6LL9D56e9sbPtCr
         IZJWTfihxfUSxHj0O1FiCEdwN3+9p1keSiYRCztmLy6jcizYqeoo2+hJ8ZiX7f9OQXkk
         TtIH0ZCT6nSqWocS/4FhPAEoUOjRFJLKkYkw4bkfitOneIa27cghCPgiWRdJQD1AnIUh
         qGrpeJVzna0judWZi1hAdVDxJztuFsLD5L4w8Jd/RYrDZvSh1OQDj3I3b5KmFg2Wluvq
         Dy5zER1nwjLjP295dit1BPTGjzxg9/ugD+fBqUaE2v2a+SJzZKKUEDhrFQkFD38dxKyn
         WCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kN/XaSPBXfxyVunG3MHFniOIIjaLqK5gHO/Wmde/C3E=;
        b=paAhKQgGRgQDD3K0A0HF/m+zUBFEZhtwXpwwyQDKLcqkzjQajPZ/9rkQ8cuzoix8Td
         jHM7Ag86OGXzvhJW3/p5cOj3E5IcDkGDndCgB3F4u069WV2ugVXfD3ftKdW51CMIEy6t
         QYVU/FMl8S88TKtOodiUx8T8wMlN9rZrO9PothJtFUTh2ierzlnk/XisC1vi7VQANOF0
         kJokyeyf1fPfSystGu+kbKW4Qut9k/TJrMbbbaZUTMRqCLNjyb6bCTbCeGLCr4fJWZer
         DoHYLBNi8RysAHJ413wpZkbNLxvaO/ytUSiKH1r5D4LnDtKkVwfwfNX0ys8snvceG8Hz
         4clw==
X-Gm-Message-State: AOUpUlE8SIIK6oA5k+TB3wpU9PzgqGsQGoughMUZAEDNjXlXYYbB0fVB
        UVfQQz7aMyE7zWYWC13RCM+QFYN9O6I=
X-Google-Smtp-Source: AAOMgpcAgmX01dVfxqLVym5IUxIBZA6mPKIec8cAgckNmdZ4jrt7Vj9JwfO1E4FKFbfe4pTMKgNlKA==
X-Received: by 2002:aa7:c342:: with SMTP id j2-v6mr2415678edr.201.1532090186494;
        Fri, 20 Jul 2018 05:36:26 -0700 (PDT)
Received: from christian-SVF14A1C5E.mip.uni-hannover.de (ip37.173.mip.uni-hannover.de. [130.75.173.37])
        by smtp.gmail.com with ESMTPSA id r6-v6sm1540539edd.6.2018.07.20.05.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 05:36:25 -0700 (PDT)
From:   Christian Thoms <christian.thoms93@gmail.com>
To:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Thoms <christian.thoms93@gmail.com>,
        linux-kernel@i4.cs.fau.de,
        Sebastian Hillert <sebastian.hillert1@gmail.com>
Subject: [PATCH v2] drivers: input: Remove paragraphs about GPL due to SPDX-tag
Date:   Fri, 20 Jul 2018 14:36:15 +0200
Message-Id: <1532090175-4527-1-git-send-email-christian.thoms93@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By adding the SPDX-License identifier, the paragraphs about the GPL are not
longer necessary as stated by Dmitry.

Signed-off-by: Christian Thoms <christian.thoms93@gmail.com>
Signed-off-by: Sebastian Hillert <sebastian.hillert1@gmail.com>
---
 drivers/input/evbug.c         | 15 ++-------------
 drivers/input/ff-core.c       | 11 -----------
 drivers/input/ff-memless.c    | 11 -----------
 drivers/input/matrix-keymap.c |  5 -----
 4 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/drivers/input/evbug.c b/drivers/input/evbug.c
index 337c0ff..4de7431 100644
--- a/drivers/input/evbug.c
+++ b/drivers/input/evbug.c
@@ -1,22 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (c) 1999-2001 Vojtech Pavlik
- */
-
-/*
  *  Input driver event debug module - dumps all events into syslog
+ *
+ *  Copyright (c) 1999-2001 Vojtech Pavlik
  */
 
 /*
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 3086166..0a33737 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -6,17 +6,6 @@
  *  Copyright (c) 2006 Dmitry Torokhov <dtor@mail.ru>
  */
 
-/*
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
 /* #define DEBUG */
 
 #include <linux/input.h>
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index f25377d..e16f121 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -6,17 +6,6 @@
  *  Copyright (c) 2006 Dmitry Torokhov <dtor@mail.ru>
  */
 
-/*
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
 /* #define DEBUG */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index c2cc853..525675c 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -6,11 +6,6 @@
  *
  * Author:
  *	Olof Johansson <olof@lixom.net>
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/device.h>
-- 
2.7.4

