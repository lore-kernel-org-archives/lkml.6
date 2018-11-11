Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AFAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E21120872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y1jRTAvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E21120872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733251AbeKLJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733122AbeKLISo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:44 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6470221508;
        Sun, 11 Nov 2018 22:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975328;
        bh=l8HE12dSsseiIKhwQROVPCggsv4fU0s/Pz9RBW4liGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1jRTAvov2c6DqPrVFJ1j+qo77o3SGp95Um0bQk6+Ct4nWd2jEBaMUBPVVU1aDQQP
         NneVaLkH9RmVJdYTRgB4rIwGSOQ3Cpq44g4nqJaaiAuEValWcVDX8UFe0eJQ5Vyv9x
         N2NBHxmFFGFLsCePJwUJmxtHQEjMcjCaXTg5DfEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.liu@linux.alibaba.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 340/361] btrfs: reset max_extent_size on clear in a bitmap
Date:   Sun, 11 Nov 2018 14:21:27 -0800
Message-Id: <20181111221700.653081713@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
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
@@ -1687,6 +1687,8 @@ static inline void __bitmap_clear_bits(s
 	bitmap_clear(info->bitmap, start, count);
 
 	info->bytes -= bytes;
+	if (info->max_extent_size > ctl->unit)
+		info->max_extent_size = 0;
 }
 
 static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,


