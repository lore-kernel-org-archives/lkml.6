Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8393A214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="APDYmv5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8393A214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbeKTDJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387653AbeKTDJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:09:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C109214C4;
        Mon, 19 Nov 2018 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645905;
        bh=hW8NyDFKG37DFiC7vqGEdp4hL992XAP0Uh1qIdPf5g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APDYmv5zAaamF75xPRUBMy70RCHCcG/5Gq49s6DaXNuFlwMVW1ZUUHoTBca0r5KyM
         ME+hBdyYQbp0h7cW02btW2pXLcSvUP4q3XPDz66L+K+LLdzQCQZx/KJ42OkYn21jb8
         2f12YkUqGcM9mGU6OdCm1Cv+YflfjyniNGErHSW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.18 116/171] ext4: fix possible leak of s_journal_flag_rwsem in error path
Date:   Mon, 19 Nov 2018 17:28:32 +0100
Message-Id: <20181119162636.770826428@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit af18e35bfd01e6d65a5e3ef84ffe8b252d1628c5 upstream.

Fixes: c8585c6fcaf2 ("ext4: fix races between changing inode journal ...")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 4.7
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4488,6 +4488,7 @@ failed_mount6:
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
+	percpu_free_rwsem(&sbi->s_journal_flag_rwsem);
 failed_mount5:
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);


