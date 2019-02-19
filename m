Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3012DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AA2217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IrVyG7M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfBSFiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:38:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33036 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:38:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so32358728otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=7TgetPiKYsdjnOAeKC/fO5fqwlcjUzyiQLqeYUXldYM=;
        b=IrVyG7M7DlLpaywnYWIxg3ulWcftgdss9wryWV/2BvZLja/i4ljxEZHrgKal4VbLAE
         vKDmRu9QPzRujb5aUjCeADBl+RGEmWx/8Ka9B0ZGksJ3/zkIZjNe/DyR2+RFxrpGlwag
         gQT+PNpzA2LVvRjERFfyhlsCghH+RfA1shAvkfU9AoRANWn1WWmVwMOIvzOzwqQ9yrnn
         HqrD4fLNqeGnJPCgm5a/LK+ImEFnUCrD8C2SvYqGGBxIvN1CFps9mVyOl1bLT78AALQy
         +jHGbQB/SuAK//WF0YPJ3ZFiUMePIJ4C7iEMBTvnUDKEm9NzVmEksLmxkuyIZZkk8c9w
         W6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=7TgetPiKYsdjnOAeKC/fO5fqwlcjUzyiQLqeYUXldYM=;
        b=hoOvYN2qYQ/h9DsCgDYos21xxIyoZVX7XuCF0MxETqnma6m/hmabqt0stSLVIX6D1U
         9WPLXgTSbcEvNI1MFiMPsqVJT3lONb0czkXBoI9XcJER331p5X9tbHmZ7y2AapWHXLj+
         BDOE/vh5EgvR3GgIDBDbxtunUNgKkiMngdu5/OC7Qzvk9dgAltTwX/1Gsaqz6B4h/MAc
         PQNdFRjgtNIRTfHlhrIEFDrI9CjOr7pgOy/NHjx7MpUOJzqA5aNgVTFsYF6T0OT/Hkam
         6e7kvGoRNkJVyI/PTOgboUM8YBIMXZwxlhDqldn+9y0kIBll0zbIF9fbhQ/IfxdhD7z+
         sxYw==
X-Gm-Message-State: AHQUAuaa1zV7dZADDv+E1M3fn2Opf0UVYuqZLUWto9y+wt0nLO1jaIv4
        cRchp4Hkrl48INORN9UvpojAZg==
X-Google-Smtp-Source: AHgI3IbmXH6vefHGSLsDWVj3usIfcJ+vdeCsDimIXsoxb9GUBNQc1zai148VCOMdqT2Nj1BO1MpAyw==
X-Received: by 2002:a05:6830:1648:: with SMTP id h8mr8856727otr.50.1550554681150;
        Mon, 18 Feb 2019 21:38:01 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n8sm6528310otl.40.2019.02.18.21.37.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 21:38:00 -0800 (PST)
Date:   Mon, 18 Feb 2019 21:37:52 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] tmpfs: fix link accounting when a tmpfile is linked in
Message-ID: <alpine.LSU.2.11.1902182134370.7035@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Darrick J. Wong" <darrick.wong@oracle.com>

tmpfs has a peculiarity of accounting hard links as if they were separate
inodes: so that when the number of inodes is limited, as it is by default,
a user cannot soak up an unlimited amount of unreclaimable dcache memory
just by repeatedly linking a file.

But when v3.11 added O_TMPFILE, and the ability to use linkat() on the fd,
we missed accommodating this new case in tmpfs: "df -i" shows that an
extra "inode" remains accounted after the file is unlinked and the fd
closed and the actual inode evicted.  If a user repeatedly links tmpfiles
into a tmpfs, the limit will be hit (ENOSPC) even after they are deleted.

Just skip the extra reservation from shmem_link() in this case: there's
a sense in which this first link of a tmpfile is then cheaper than a
hard link of another file, but the accounting works out, and there's
still good limiting, so no need to do anything more complicated.

Fixes: f4e0c30c191 ("allow the temp files created by open() to be linked to")
Reported-by: Matej Kupljen <matej.kupljen@gmail.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- 5.0-rc7/mm/shmem.c	2019-01-06 19:15:45.764805103 -0800
+++ linux/mm/shmem.c	2019-02-18 13:56:48.388032606 -0800
@@ -2854,10 +2854,14 @@ static int shmem_link(struct dentry *old
 	 * No ordinary (disk based) filesystem counts links as inodes;
 	 * but each new link needs a new dentry, pinning lowmem, and
 	 * tmpfs dentries cannot be pruned until they are unlinked.
+	 * But if an O_TMPFILE file is linked into the tmpfs, the
+	 * first link must skip that, to get the accounting right.
 	 */
-	ret = shmem_reserve_inode(inode->i_sb);
-	if (ret)
-		goto out;
+	if (inode->i_nlink) {
+		ret = shmem_reserve_inode(inode->i_sb);
+		if (ret)
+			goto out;
+	}
 
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
