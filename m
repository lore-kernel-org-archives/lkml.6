Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBF0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279CC21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrB83vrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279CC21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbeKTDTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403773AbeKTDTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:19:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515CF21104;
        Mon, 19 Nov 2018 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646490;
        bh=Mi4JQ4d6xRji+dugOWmOl8DXKt0JvohcKjvsYRUnwdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrB83vrPXQ53WNinJk9SSgeJtgerp/EtFbX9MQxbQbBHdHCLMKJti9PxtHkHcijpi
         xBqMq/0NTjU9mt1wMVdouK9Y5F8lliDDnTfU3r+e8f0FaUGMDUnPBq32JDO26f+hp2
         MO1hOj7rVesy4f1oKvdHI2cSDc6SA8efbEmF1UWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.9 60/83] ext4: avoid possible double brelse() in add_new_gdb() on error path
Date:   Mon, 19 Nov 2018 17:29:26 +0100
Message-Id: <20181119162624.202644498@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit 4f32c38b4662312dd3c5f113d8bdd459887fb773 upstream.

Fixes: b40971426a83 ("ext4: add error checking to calls to ...")
Reported-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 2.6.38
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -844,6 +844,7 @@ static int add_new_gdb(handle_t *handle,
 	err = ext4_handle_dirty_metadata(handle, NULL, gdb_bh);
 	if (unlikely(err)) {
 		ext4_std_error(sb, err);
+		iloc.bh = NULL;
 		goto exit_inode;
 	}
 	brelse(dind);


