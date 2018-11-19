Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFBCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040FA208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf+dAf3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040FA208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbeKTDQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbeKTDQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:16:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B721C208E3;
        Mon, 19 Nov 2018 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646313;
        bh=10v7rNqTjuDqDYvpe3BeW/PsWBXYUn8lr8cOLPG21A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf+dAf3SN+MTTOaul4ATncSnVNc666rhhSUbA7l/Lz0ighjgZpLSpC1TYeHiUiRSH
         DRXFSjzqs9AxPTz7pOPDzJ01Sa0oMsHqT9BpC1SN2Q3w7rgetTlnvKF4EP4g/1bGre
         bSFwE6n9Xh4/0gncWKvuGCtG6UNKcqGes9BsD9LE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Monakhov <dmonakhov@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.14 080/124] ext4: avoid buffer leak in ext4_orphan_add() after prior errors
Date:   Mon, 19 Nov 2018 17:28:54 +0100
Message-Id: <20181119162628.374092924@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit feaf264ce7f8d54582e2f66eb82dd9dd124c94f3 upstream.

Fixes: d745a8c20c1f ("ext4: reduce contention on s_orphan_lock")
Fixes: 6e3617e579e0 ("ext4: Handle non empty on-disk orphan link")
Cc: Dmitry Monakhov <dmonakhov@gmail.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 2.6.34
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/namei.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2820,7 +2820,9 @@ int ext4_orphan_add(handle_t *handle, st
 			list_del_init(&EXT4_I(inode)->i_orphan);
 			mutex_unlock(&sbi->s_orphan_lock);
 		}
-	}
+	} else
+		brelse(iloc.bh);
+
 	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
 	jbd_debug(4, "orphan inode %lu will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));


