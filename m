Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0E2C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9D020868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dcp7QT1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9D020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLGUn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:43:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39561 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:43:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so4982538wra.6;
        Fri, 07 Dec 2018 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K9be+lVipHl+rJybtHM1Ln+kpUlNmNIbplc+QFCcnlg=;
        b=Dcp7QT1m0PQ6RVYqggj9dKJXnfNy1aY4IHkSpER5MiXck/7rtRvLLvn0HOneBMarUm
         FKUPNteaVK6y43FYMQt6Xq/29xlBU8FS+ZCjXcTN2lrZuIEBTIq/DZUXkeRfqGmlWsBc
         YHu1ruwh4dm7pBxxShnP4/6V2Juj9YlnmEs87qzOh+mRyGG1V/cLLhvmRqgcgKTwebZb
         65ft/s1iPSAcICDWAdUZyLaiJZj8FJlRqzeYgf32OHjxa+LzYzBWdUs7hgnNTt88WsFE
         dkBjAyDarh1WMNXrQa5d5+UC9JWwg8gM7fO89OxYWYnvhoFZpMc5ZqHDaQRByBU+OkmD
         Bu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=K9be+lVipHl+rJybtHM1Ln+kpUlNmNIbplc+QFCcnlg=;
        b=WA2N2DkVjP1n0Gmk+ktK2Af3IWLWlzclG2swr9lfPdKot/DmmFnwy5Oq3wqO0OVdAK
         I+BGh1OWztzZX75uWDgW1DAluXSr90pJnvdGuDZ5k45LbvTASgQJWG6A6DayzTq7VZVB
         LcEgzTHk8qJif1EzzBm0DL6UAQhP8KI6fWqinjcrXJJYdvuSv+SSuT3RWTKyDj9nv9Jk
         mcSIDD+KzhheSLbQaIICb5i6j2kr/hb2iD6aAbR/wrQPqni01/jKCKrsdPsOfca+qPiC
         gs3NEYwPhcAa29dI1k2oo+AH9FQk54jrYFY8IAEDLUbXoZiszml2HoCYw3G1vGaCOX6C
         26JQ==
X-Gm-Message-State: AA+aEWau6EGN7syhCi5Hd3qnRD9O3X5DYJY4YoHRNj1LJNEFQ3V4tpOk
        Jbse4QWbetwQ9/0iG2LAu/s=
X-Google-Smtp-Source: AFSGD/UwRLLjbIuN+Fn+0ipxmet6HBcASuUHrvfsyLw06h34X9fAXnkbwvFQjan0xxWeKD1S2MSylQ==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr3119532wrj.118.1544215405759;
        Fri, 07 Dec 2018 12:43:25 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id p14sm2700824wrt.37.2018.12.07.12.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 12:43:25 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CCEA21144632; Fri,  7 Dec 2018 21:43:23 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mount: Make function to_mnt_ns static
Date:   Fri,  7 Dec 2018 21:43:18 +0100
Message-Id: <20181207204318.1920-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 58be28256d98 ("make mntns ->get()/->put()/->install()/->inum()
work with &mnt_ns->ns"), a new function `to_mnt_ns` was introduced.
Since this function can be made static, make it so.

Fix warning when compiling with W=1:

  fs/namespace.c:1693:23: warning: no previous prototype for ‘to_mnt_ns’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a7f91265ea67..f0cf252d9aa3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1690,7 +1690,7 @@ static bool is_mnt_ns_file(struct dentry *dentry)
 	       dentry->d_fsdata == &mntns_operations;
 }
 
-struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
+static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
-- 
2.19.2

