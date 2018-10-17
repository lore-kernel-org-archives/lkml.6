Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B93ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4B72145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Zf5TtIHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4B72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeJRCPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:15:22 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:45696 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJRCPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:15:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id CF50F2B9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 18:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ce2FRuw1mLMp for <linux-kernel@vger.kernel.org>;
        Wed, 17 Oct 2018 13:18:27 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id A59E75BF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 13:18:27 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id s15-v6so25147428iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iHhie0xt3E+9d9DUTJDeOg9pQf3MJnJnRkIXolVtctI=;
        b=Zf5TtIHkzZiCqEogoyaheSCqbUaIVK06zyO94egjwwT9reagP+fbQfIr8ajlTX5xOy
         y2ll1pe5qBaXR6XS5dhk7SpA1s7d0NeIt227ZXc5xBt10S2HZrjt+Dgv5bCXrxyYfWCl
         gYuVfPPp56tYgLmgEBvcZ7RZiTAmMK8G1oFCIyqwKIR1Xp778xHSVamCLfsyt78eFI2d
         9Y1bdWQ6FgFW9qAVbp5RpK9Mtqxkfs1NfkWLh991zj/ir8HSXEXuKneQrbbWNZhpasU/
         aChGAW/t6fgxxy52LLBFHg5nBDCxP8RjfLnZNUCXIi72byd7rvHtQC1Pw5/Dui0lepa8
         15vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iHhie0xt3E+9d9DUTJDeOg9pQf3MJnJnRkIXolVtctI=;
        b=W/ILIaSO7NHGxBZyfvrrWsSR3WxHevhzMvI79crbRD3vw94caGjWC4QNa/OeUgxAy8
         hV5AlGUcAjqKVNM5Qdtov79cY5jYo4DqlWCK+34nenYfkHUMH4QdLfOT0a78BvYv3BDl
         BzgUWTwC5mXBZStZE+vy/C90zLva1086+S84bOh4B5np40U/pgOpPRgMa/YxvQAip9r4
         2pPEj5N1B/gyHUppaFSiJPkPEQi6I/v39c6gdkri3Ex8nlXxCXdpboxeCEN62Y877+4n
         I5tg45OioCR5nHLxdDBhM44I+mDE4odxqFT/+nUDCzmaBwv5c2jy0QWRVhTceHfQJOIm
         zbvg==
X-Gm-Message-State: ABuFfoga/ZeJ8CK1WKnwccHG//u66On7dy4GrKqhxcuybCcZo+cEU5HA
        uSJYb45lyHNRnwhafGRslnk8cVAbqakIWpboh+wDL9tlbqle1RhVXzneB8VI3CexgZMF08xYHxv
        X2zt80sbYvw7PlXKf2mCkN9Z3pREl
X-Received: by 2002:a02:13:: with SMTP id 19-v6mr20158971jaa.68.1539800307346;
        Wed, 17 Oct 2018 11:18:27 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61lV3oKA0N/f9lQOX6rEdZO1bET+m461j4az1UTM++HXMTrlX+RWefH7lPmU6bFfi7gYPfziw==
X-Received: by 2002:a02:13:: with SMTP id 19-v6mr20158959jaa.68.1539800307073;
        Wed, 17 Oct 2018 11:18:27 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id z186-v6sm999844itd.43.2018.10.17.11.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 11:18:26 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org (open list:VFIO DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drivers/vfio: Fix an 8-byte alignment issue
Date:   Wed, 17 Oct 2018 13:18:19 -0500
Message-Id: <1539800299-2787-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a 4-byte reserved field in the structure
vfio_eeh_pe_op to make sure that the u64 fields in the structure
vfio_eeh_pe_err are 8-byte aligned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 include/uapi/linux/vfio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82..3e71ded 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -729,6 +729,7 @@ struct vfio_eeh_pe_op {
 	__u32 argsz;
 	__u32 flags;
 	__u32 op;
+	__u32 __res;
 	union {
 		struct vfio_eeh_pe_err err;
 	};
-- 
2.7.4

