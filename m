Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347DDC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F019B20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3szT56p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F019B20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeKIIVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:21:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeKIHdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:04 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2005B2089A;
        Thu,  8 Nov 2018 21:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714137;
        bh=84wgKFvSnJf39D9sZdwleJjUggBompjHOe36jc2s+N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3szT56p3lZN7CViqKPB0xC2iNfq+fmG22uRSkZf8XG4cl9A8dprrUQZQJrl04ZaE
         5wNwr7IHCsGTDTsDt2JANBRPDP5U9gWVPUT0YVX5fjuklS+jV70DwvGjj/iJnVAv+1
         u9bgx/yTjBAAqYJpOSNBU3GS4GlSGG5UI9HMCTxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 070/144] fbdev/broadsheetfb: fix memory leak
Date:   Thu,  8 Nov 2018 13:50:41 -0800
Message-Id: <20181108215100.031657282@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ef6899cdc8608e2f018e590683f04bb04a069704 ]

static code analysis from cppcheck reports:

[drivers/video/fbdev/broadsheetfb.c:673]:
  (error) Memory leak: sector_buffer

sector_buffer is not being kfree'd on each call to
broadsheet_spiflash_rewrite_sector(), so free it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/broadsheetfb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index 8556264b16b7..235542f42da9 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -636,7 +636,7 @@ static int broadsheet_spiflash_rewrite_sector(struct broadsheetfb_par *par,
 		err = broadsheet_spiflash_read_range(par, start_sector_addr,
 						data_start_addr, sector_buffer);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	/* now we copy our data into the right place in the sector buffer */
@@ -657,7 +657,7 @@ static int broadsheet_spiflash_rewrite_sector(struct broadsheetfb_par *par,
 		err = broadsheet_spiflash_read_range(par, tail_start_addr,
 			tail_len, sector_buffer + tail_start_addr);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	/* if we got here we have the full sector that we want to rewrite. */
@@ -665,11 +665,13 @@ static int broadsheet_spiflash_rewrite_sector(struct broadsheetfb_par *par,
 	/* first erase the sector */
 	err = broadsheet_spiflash_erase_sector(par, start_sector_addr);
 	if (err)
-		return err;
+		goto out;
 
 	/* now write it */
 	err = broadsheet_spiflash_write_sector(par, start_sector_addr,
 					sector_buffer, sector_size);
+out:
+	kfree(sector_buffer);
 	return err;
 }
 
-- 
2.17.1



