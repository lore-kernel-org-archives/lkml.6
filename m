Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEDFC282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A39218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lax7Txn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfAZGzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 01:55:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38993 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfAZGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 01:55:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so9046111edt.6;
        Fri, 25 Jan 2019 22:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjwB3FtLrBsQsXuI6hyxofqxMdNfU6yzZsI8WG4Rw4w=;
        b=lax7Txn42k6CUpHwMI+jKK7RwQYa+PlgotxriOpv9up8x+2JjYqo3BxW7VsEuHW/OJ
         id2IO4BOngQBo4uVR6GrqFVD+xx9HZiKEv9Z6lQylTkdObqaQQXyNH3gROzVM4OlJXdl
         ElEwpexfn8sZfPeMIhhkaoCXOh6+1K9LnM2s1tMq3g8tzJf+FqWhFl3rTiSoCzyVaHp2
         T2KEfZADIm7RQ1HTE0pGYj1/pPSADOdWehzi+VtN6kxKO7DMsTNUeUs4gsGXVO3iwMoW
         i3sW2yFriFF1J72nMnVHDVCk+ibrNbD8pMBrjogHiwrnhsgE6S2EDur0ma+dVLsV4PXb
         LjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjwB3FtLrBsQsXuI6hyxofqxMdNfU6yzZsI8WG4Rw4w=;
        b=XZyuGxD/oHjPeaSQzd6p6v+w19XkEkadNJmPNTMLY+vQnbFCf2KWNKXOW9siNO3Khq
         BzHztxxDzPlxgzKBn6++8/pi/cVJFoRcT1QIdLdJlIZ40u/X7s/TSbU/4aN60tN7Sc+h
         sA+Mj3XbhGvu6BGm8XkqzKbri3j/xUa1qA3hCXRH0AdF3vXpp24RuXdt5ESOrv0VCImQ
         Xv1K60TuGAGMdJBp31+T+al3IoVkUjO+xWWMBK0SSlGxicejNQQB7wJiSa4ot0K7ze4N
         4ASLZv3b3HezWHqBWl5XWzlmDN/Zz5FXqf8y/oFiswp/y/MZYQm3amiZr0u4AoBdHdLj
         k1Kg==
X-Gm-Message-State: AJcUukeyoJAae1nysKMTTPyCC3pqjLuPXnhPX1Mlq8vvekS+MRLWUmoS
        QergjAj9k4LKvOYmwVXxRTM=
X-Google-Smtp-Source: ALg8bN61ghgA73NYJZABuCcVstijQNkwjW+EEbRHBX/Ngl0qLrOgCcbYM820klR+yiDeSvSEV0lpyg==
X-Received: by 2002:a50:9ac4:: with SMTP id p62mr13632896edb.179.1548485704039;
        Fri, 25 Jan 2019 22:55:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id t26sm12486463eda.22.2019.01.25.22.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 22:55:03 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Boaz Harrosh <ooo@electrozaur.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH RESEND] libosd: Remove ignored __weak attribute
Date:   Fri, 25 Jan 2019 23:47:41 -0700
Message-Id: <20190126064740.12949-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20180930205448.26205-1-natechancellor@gmail.com>
References: <20180930205448.26205-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the __weak attribute is going to be ignored on
osd_root_object because it's not in the correct location (needs to be
after the type).

./include/scsi/osd_types.h:31:21: warning: 'weak' attribute only applies
to variables, functions, and classes [-Wignored-attributes]
static const struct __weak osd_obj_id osd_root_object = {0, 0};
                    ^

Turns out that GCC ignores the attribute too albeit silently because
moving the attribute after either osd_obj_id or osd_root_object like
all other uses of __weak on variables in the kernel causes a build
error on both GCC and Clang because static variables cannot be weak
since weak definitions rely on not having internal linkage:

./include/scsi/osd_types.h:31:32: error: weak declaration cannot have
internal linkage
static const struct osd_obj_id __weak osd_root_object = {0, 0};
                               ^

Just remove the attribute because it hasn't been correct since the
initial addition of this file in commit de258bf5e638 ("[SCSI] libosd:
OSDv1 Headers").

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Resending as there was no conclusion on the removal of the OSD code and
this warning is still present on mainline/next. I think it is rather
unfair for this patch to be held back because of the possibility of
removing this code when it is a very simple clean up patch and doesn't
affect anything other than a build time warning. If this declaration or
driver needs to be cleaned up in other ways, it should be done in
subsequent patches.

Thanks,
Nathan

 include/scsi/osd_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
index 48e8a165e136..6b6fdcafa6cc 100644
--- a/include/scsi/osd_types.h
+++ b/include/scsi/osd_types.h
@@ -28,7 +28,7 @@ struct osd_obj_id {
 	osd_id id;
 };
 
-static const struct __weak osd_obj_id osd_root_object = {0, 0};
+static const struct osd_obj_id osd_root_object = {0, 0};
 
 struct osd_attr {
 	u32 attr_page;
-- 
2.20.1

