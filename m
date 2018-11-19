Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F53C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4181821479
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Isi0woSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4181821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeKTDAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:00:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbeKTC77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:59:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAB352086A;
        Mon, 19 Nov 2018 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645351;
        bh=O9KhG/zel+Epa1NWfKkB0da927WbiJZZGckBCFwC8Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Isi0woSwxS/UFPexPza2qh9xZO0vhow2+eFqsnumb1WLavuu7Ea5OTkx91xMO/feq
         PtqcOg9eKSBhTz8KEDs8ZltwnkncM4cYKutWyFEkrOr48xbXUyp75JBUBfClQpOAXC
         mSjzSXD3XcZ5ArXRmHzu+GJSbLYayd/0fEU4jjnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.19 130/205] ext4: add missing brelse() update_backups()s error path
Date:   Mon, 19 Nov 2018 17:27:17 +0100
Message-Id: <20181119162636.953321325@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit ea0abbb648452cdb6e1734b702b6330a7448fcf8 upstream.

Fixes: ac27a0ec112a ("ext4: initial copy of files from ext3")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 2.6.19
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1124,8 +1124,10 @@ static void update_backups(struct super_
 			   backup_block, backup_block -
 			   ext4_group_first_block_no(sb, group));
 		BUFFER_TRACE(bh, "get_write_access");
-		if ((err = ext4_journal_get_write_access(handle, bh)))
+		if ((err = ext4_journal_get_write_access(handle, bh))) {
+			brelse(bh);
 			break;
+		}
 		lock_buffer(bh);
 		memcpy(bh->b_data, data, size);
 		if (rest)


