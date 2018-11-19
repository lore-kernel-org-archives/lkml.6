Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25072C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE60521707
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF3Gxf9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE60521707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405171AbeKTDYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404390AbeKTDYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4D42151B;
        Mon, 19 Nov 2018 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646785;
        bh=1rZT2mMAWVLcGDgWhCQLXX75QhU+MbYjQZ1dFXA0QEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bF3Gxf9NP09udeXyatFVd3bSnzJ392af+0mmV9ILaVL6Jhsjkh+rayQ2IYYffoMRp
         EbYH2ecnP00yUGz3DAbSVF65fVGydYKJjfHW/yRFx7Hpr/xMmoxfAO7vyEsZn0mxxZ
         sKq8Z29wKw/M50RKMCFs9FX1g9V7Uhkl7+YWrFMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.liu@linux.alibaba.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 089/160] btrfs: reset max_extent_size on clear in a bitmap
Date:   Mon, 19 Nov 2018 17:28:48 +0100
Message-Id: <20181119162639.841711291@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <jbacik@fb.com>

commit 553cceb49681d60975d00892877d4c871bf220f9 upstream.

We need to clear the max_extent_size when we clear bits from a bitmap
since it could have been from the range that contains the
max_extent_size.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/free-space-cache.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1699,6 +1699,8 @@ static inline void __bitmap_clear_bits(s
 	bitmap_clear(info->bitmap, start, count);
 
 	info->bytes -= bytes;
+	if (info->max_extent_size > ctl->unit)
+		info->max_extent_size = 0;
 }
 
 static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,


