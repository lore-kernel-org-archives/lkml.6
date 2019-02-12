Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F04C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F08222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzKb3LDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbfBLVsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:48:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39163 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfBLVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:48:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so96495pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3O1GoRWzdK7uBS+fqA4Rhukwloc4DD//vnltPS+KmL4=;
        b=CzKb3LDcgO0HzPC68h7u/21tqFWyuvHbakiKo0zM+l0seaFfFI6wUwFvh1h4clZ1i/
         j02Gy2YboNf86tqljWRFTQ8cohZr7PFADjTP3kC6sEHvTb/uj4AN0azYwBSSocUN7ves
         5uoAWu41agoG3LGFjHXHMHBrsyPsnOl8sC7to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3O1GoRWzdK7uBS+fqA4Rhukwloc4DD//vnltPS+KmL4=;
        b=qcAx8uZgrzZe2JuYakWUEvTsIBfefD8dmFDzrUrD5R+XuE+BloxO0V5yt7RlgdxhTE
         8w5a2Tcw0Hw8Fs8S25fcV9FMGnhp2MS3M9c76WziWyhbYQ3REsgodfTrL8DHJxz7LCQJ
         galvzoAn3F4JGZwpueo+RbSfvupLJ5yMT+J242zFATb3PsN7WM8JydzZQFDMa2LkOi7g
         4NXaH3iRqIn0FuKu0XXYAQ4v5L8RhbTGm26JK1H9OyCeg3DN46AMH1JMcnCONAsKddc9
         U709Djj03JUcBMa7wKpbGhWhYOa1dUDLEfmlwpoY3TZgnv9zSrsIjVB6ZZXOU8CYK/FG
         15qg==
X-Gm-Message-State: AHQUAubL3F2m6Aa1+KTtK4B2xCOmGOHbYcrSAwzE1UK6IJEcs96RZ40u
        gbjtyZtJ4bTqXalpT7vHnxwrzKwa28I=
X-Google-Smtp-Source: AHgI3IZtXjmY7KWbuyC+9olGituU+Iee0I42AXitGipRU7hWXw+d5G8s7ecFapbL0fr0KDsYHcmC5w==
X-Received: by 2002:a17:902:8c81:: with SMTP id t1mr6245143plo.107.1550008090737;
        Tue, 12 Feb 2019 13:48:10 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id i8sm36900700pfj.18.2019.02.12.13.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 13:48:09 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:48:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yue Hu <huyue2@yulong.com>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] pstore/ram: Avoid needless alloc during header write
Message-ID: <20190212214808.GA33512@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the header is a fixed small maximum size, just use a stack variable
to avoid memory allocation in the write path.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ec0e1da0596a..c5c685589e36 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -345,19 +345,15 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
 				     struct pstore_record *record)
 {
-	char *hdr;
+	char hdr[36]; /* "===="(4), %lld(20), "."(1), %06lu(6), "-%c\n"(3) */
 	size_t len;
 
-	hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR "%lld.%06lu-%c\n",
+	len = scnprintf(hdr, sizeof(hdr),
+		RAMOOPS_KERNMSG_HDR "%lld.%06lu-%c\n",
 		(time64_t)record->time.tv_sec,
 		record->time.tv_nsec / 1000,
 		record->compressed ? 'C' : 'D');
-	if (WARN_ON_ONCE(!hdr))
-		return 0;
-
-	len = strlen(hdr);
 	persistent_ram_write(prz, hdr, len);
-	kfree(hdr);
 
 	return len;
 }
-- 
2.17.1


-- 
Kees Cook
