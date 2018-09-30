Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74647C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D8C20685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEqEC48X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D8C20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeJAD3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 23:29:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51792 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbeJAD3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 23:29:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id y25-v6so6701793wmi.1;
        Sun, 30 Sep 2018 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2D71XIIQtLKUEAvdLd4evIDaeA42zh5dCO98SLM2nM=;
        b=LEqEC48XbjyUjlwKxcNpn6ZN5dr8eKJejtQ3eRySLCP+0AfFFilxQHGuDcNpkJ8pCV
         fLV+dfw5mgVdXJKjjPzYmqERbPOXVSlJS8lcc9XNqp08D6lES1oKYFpnmlJTsL47rECO
         eGzzLXqhUWRgnigzx4CW4E3MTd5NvT94TNF2gg2gCK7zLKAoggWivdgJAlOzMfpFXTNd
         Iqym7/wvxdgVQUQSFru75JGem/b85qbIBQ3wfpTclq3vrLQNosS3oTR4m2ebYD5Mtkhe
         +L+ssMDyY1DSLAh5GOV2sKtb3P0Mk+sAkNzgY3QZXxaxVXDF+dN1vW+XhAAiEiZbXyw1
         OXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2D71XIIQtLKUEAvdLd4evIDaeA42zh5dCO98SLM2nM=;
        b=jw/k358KMH+Q1wF12ZSbX8SFB8nIHmBAC2k369c7aBYco6RImudl7G+FSLW6sI3I/I
         mG120je/ylwQFGnw1v+ehAdVcWwmWFspF4La6SGoR/EQqGHvkSqyLYhlIro8P2/iOSYI
         VHDPkA43mIO9y4ChVs0u5tKTK1CXprVk4aqVxlIqMjJxO3Uk7ChIlj31J6XdJCWqGt6h
         iJ9B4EIc16BNA1uuzN4+u/JJtcP7Zdnj9LUn7sDDXT5WBwoNptikijnVg6CQbfAW50b1
         zxzGYnYqSo/EA/S5dE5JbdFDH5zCO2YwaW0BbEabHCKaolGjJg4Yrgyt2ii22uUpGALA
         QJQQ==
X-Gm-Message-State: ABuFfohzQmQtxXyRU/UuFQLGFH8y3ONDVwuFg8wu2lLTmKp3Mt2ghLjW
        8EdhjmhmvfBK8YxF6UoylHs=
X-Google-Smtp-Source: ACcGV63oUGWnO8Wsw7fq1KY87svGX++R3gisO5QM+vlw+ZXrXZO3sdBaaEjGFDhsJTqXsLH5IGZGtQ==
X-Received: by 2002:a1c:c243:: with SMTP id s64-v6mr7063894wmf.36.1538340904016;
        Sun, 30 Sep 2018 13:55:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a105-v6sm29779858wrc.23.2018.09.30.13.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 13:55:03 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Boaz Harrosh <ooo@electrozaur.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] libosd: Remove ignored __weak attribute
Date:   Sun, 30 Sep 2018 13:54:48 -0700
Message-Id: <20180930205448.26205-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
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
2.19.0

