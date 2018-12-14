Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D426FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8E3214DE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789836;
	bh=CXYrYkKhEKUNPw5vtpLJ8ZlKN1L8zCKbHeGcJJ1lfh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K9jiUBgKFsu+LZ+iP0s9qzYjM7Rxvdo9CFaC6gY3/FRLmiwgM+u485I12w1VpHQJb
	 Pm5RaFUAsAQjBwDV/GCR+Ie1PF53k7UqZwrYSRz9hoNXYYxjqGCsk6F0/NPISwbiAQ
	 FJu2t2s7F9So2jJGTXiiHJnS0+3LTTEjHYi8qA1M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8E3214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbeLNMRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732884AbeLNMRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:17:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4589F214C1;
        Fri, 14 Dec 2018 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789829;
        bh=CXYrYkKhEKUNPw5vtpLJ8ZlKN1L8zCKbHeGcJJ1lfh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Octlioto7jZa6KQvQvEmQkn2b6f2YT+IGGQViK8CvkwHSiJzTE+O2DpwU8dju3L5Z
         gFqCJCAVZFQVe2yWhkai0Han7SwyBp+aUal5FdY14T6yv20rD12AaZXGWPReQchKjI
         6DPxhPmH2a5Yq0xGu73YRdyOuxxLEACgpZb+PZ+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4.4 85/88] matroxfb: fix size of memcpy
Date:   Fri, 14 Dec 2018 13:00:59 +0100
Message-Id: <20181214115709.331499652@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit 59921b239056fb6389a865083284e00ce0518db6 upstream.

hw->DACreg has a size of 80 bytes and MGADACbpp32 has 21. So when
memcpy copies MGADACbpp32 to hw->DACreg it copies 80 bytes but
only 21 bytes are valid.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/matrox/matroxfb_Ti3026.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
+++ b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
@@ -372,7 +372,7 @@ static int Ti3026_init(struct matrox_fb_
 
 	DBG(__func__)
 
-	memcpy(hw->DACreg, MGADACbpp32, sizeof(hw->DACreg));
+	memcpy(hw->DACreg, MGADACbpp32, sizeof(MGADACbpp32));
 	switch (minfo->fbcon.var.bits_per_pixel) {
 		case 4:	hw->DACreg[POS3026_XLATCHCTRL] = TVP3026_XLATCHCTRL_16_1;	/* or _8_1, they are same */
 			hw->DACreg[POS3026_XTRUECOLORCTRL] = TVP3026_XTRUECOLORCTRL_PSEUDOCOLOR;


