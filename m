Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665BAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0EE20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui5+1BSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0EE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeLDK6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeLDK6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:58:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D4B214DB;
        Tue,  4 Dec 2018 10:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921117;
        bh=5LVn1TFIzRWk/CFhAyJxbMVOwTC2XU/XdZDVkkFY6vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ui5+1BSB5pVeqSK0XCOMMsZU0XswsfixpcBkaHUyDDiutGk9hqXoeJGLtgj2+SgRa
         HZbzvtQYcxxrax4+Ugm6rPAl7/GvVvB47Bk3KjTWazhNdDkZsPh3XixurCciJ9eIm9
         Z4d19rChqiyWysiLcfAGKG92IkVOPwLRikMhPCg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ravi Nankani <rnankani@amazon.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Christoph Hellwig <hch@lst.de>,
        Torsten Mehlan <tomeh@amazon.de>,
        Uwe Dannowski <uwed@amazon.de>, Amit Shah <aams@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 088/139] fs: fix lost error code in dio_complete
Date:   Tue,  4 Dec 2018 11:49:29 +0100
Message-Id: <20181204103653.940457711@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maximilian Heyne <mheyne@amazon.de>

commit 41e817bca3acd3980efe5dd7d28af0e6f4ab9247 upstream.

commit e259221763a40403d5bb232209998e8c45804ab8 ("fs: simplify the
generic_write_sync prototype") reworked callers of generic_write_sync(),
and ended up dropping the error return for the directio path. Prior to
that commit, in dio_complete(), an error would be bubbled up the stack,
but after that commit, errors passed on to dio_complete were eaten up.

This was reported on the list earlier, and a fix was proposed in
https://lore.kernel.org/lkml/20160921141539.GA17898@infradead.org/, but
never followed up with.  We recently hit this bug in our testing where
fencing io errors, which were previously erroring out with EIO, were
being returned as success operations after this commit.

The fix proposed on the list earlier was a little short -- it would have
still called generic_write_sync() in case `ret` already contained an
error. This fix ensures generic_write_sync() is only called when there's
no pending error in the write. Additionally, transferred is replaced
with ret to bring this code in line with other callers.

Fixes: e259221763a4 ("fs: simplify the generic_write_sync prototype")
Reported-by: Ravi Nankani <rnankani@amazon.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
CC: Torsten Mehlan <tomeh@amazon.de>
CC: Uwe Dannowski <uwed@amazon.de>
CC: Amit Shah <aams@amazon.de>
CC: David Woodhouse <dwmw@amazon.co.uk>
CC: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/direct-io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -325,8 +325,8 @@ static ssize_t dio_complete(struct dio *
 		 */
 		dio->iocb->ki_pos += transferred;
 
-		if (dio->op == REQ_OP_WRITE)
-			ret = generic_write_sync(dio->iocb,  transferred);
+		if (ret > 0 && dio->op == REQ_OP_WRITE)
+			ret = generic_write_sync(dio->iocb, ret);
 		dio->iocb->ki_complete(dio->iocb, ret, 0);
 	}
 


