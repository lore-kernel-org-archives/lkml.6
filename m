Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B481FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A025214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ9lmPXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A025214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbeKTDJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388425AbeKTDJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:09:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D6832145D;
        Mon, 19 Nov 2018 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645899;
        bh=+/DyT2mwOCbRQWAmXV0iwn/kKKs0XaPSB3HEyTWaz24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZ9lmPXJcv4lqhuKqgdxewr1b/ayyBSn/rrnEEePuKlXbcXLv1WI9S1c1Gc5eiKfI
         jJdRuBjVTmPWB/TExME2R/s4M8XN8p20owZe+a1u7orprp1hi4CGOneo0t29NVerEl
         KnBnjQzXBqGJ4VQLGA7o3XlMd5MqGZ4OAJr0cTPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Zorro Lang <zlang@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.18 132/171] fuse: fix use-after-free in fuse_direct_IO()
Date:   Mon, 19 Nov 2018 17:28:48 +0100
Message-Id: <20181119162638.102811503@linuxfoundation.org>
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

From: Lukas Czerner <lczerner@redhat.com>

commit ebacb81273599555a7a19f7754a1451206a5fc4f upstream.

In async IO blocking case the additional reference to the io is taken for
it to survive fuse_aio_complete(). In non blocking case this additional
reference is not needed, however we still reference io to figure out
whether to wait for completion or not. This is wrong and will lead to
use-after-free. Fix it by storing blocking information in separate
variable.

This was spotted by KASAN when running generic/208 fstest.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reported-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 744742d692e3 ("fuse: Add reference counting for fuse_io_priv")
Cc: <stable@vger.kernel.org> # v4.6
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/file.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2912,10 +2912,12 @@ fuse_direct_IO(struct kiocb *iocb, struc
 	}
 
 	if (io->async) {
+		bool blocking = io->blocking;
+
 		fuse_aio_complete(io, ret < 0 ? ret : 0, -1);
 
 		/* we have a non-extending, async request, so return */
-		if (!io->blocking)
+		if (!blocking)
 			return -EIOCBQUEUED;
 
 		wait_for_completion(&wait);


