Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F36C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0119E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn+bnPEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0119E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403959AbeKTDSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:18:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390256AbeKTDSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:18:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC652145D;
        Mon, 19 Nov 2018 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646469;
        bh=Tz8fjuKBrH5ISgy/B/LqZ3lT85963/+ib8le3+hWw1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qn+bnPEoQkLttAuvLE1qk7DPcfg4VC2BEp9zRFyT55KM0jCd3IGaeYmq4KEywbmE0
         9NvpbBFWuN7gdfZ2Egwzv86VrOzSa5fVaxrOMochKVJ64VPlj4ZbpHgEucCHbppjEj
         lkwb48Jo3bgA32zwVAb6/MUobPt7PrUs5wEjp6Mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.9 53/83] ext4: add missing brelse() update_backups()s error path
Date:   Mon, 19 Nov 2018 17:29:19 +0100
Message-Id: <20181119162622.948970819@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1095,8 +1095,10 @@ static void update_backups(struct super_
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


