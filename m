Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1753F217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129777;
	bh=cLVqFTePAggVGCTtZF14Lk9OD+Cbkr2hMfTBM/Nw1fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S2r81d7/wd6xCP0d549LrC41NvcVBo3BTdL6BhDFkZdOx0EAlXQkf6CjSxq3G4jhM
	 NdiFSXdNT8yWa1jT7xy/KcsIDPaoSvzKca2DpM4SiWTZOblmE0fNt2jkUNF+8u6DRO
	 RCIpzxgFWddt5DpKg8uePRP3HllvcYhxP2JgjKBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfBYVWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730975AbfBYVWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1792E21855;
        Mon, 25 Feb 2019 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129771;
        bh=cLVqFTePAggVGCTtZF14Lk9OD+Cbkr2hMfTBM/Nw1fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GedHGKbNxxqkq2lUrLKyVDczTGrciJDGOZCFTcVkdw3EClk441KFTSRu5RERUu53X
         0NUcslJMxTob5M53EHPxI6UFvoUjo3KGFqus6dwip35rJRjrlOpcXhyzUcqBcuJ4W0
         F9G+4h5h9YammWBvnJOGZX221JTKQ2OntDUaPtWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/152] mfd: ab8500-core: Return zero in get_register_interruptible()
Date:   Mon, 25 Feb 2019 22:10:17 +0100
Message-Id: <20190225195045.397646544@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit 10628e3ecf544fa2e4e24f8e112d95c37884dc98 ]

This function is supposed to return zero on success or negative error
codes on error.  Unfortunately, there is a bug so it sometimes returns
non-zero, positive numbers on success.

I noticed this bug during review and I can't test it.  It does appear
that the return is sometimes propogated back to _regmap_read() where all
non-zero returns are treated as failure so this may affect run time.

Fixes: 47c1697508f2 ("mfd: Align ab8500 with the abx500 interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/ab8500-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 30d09d1771717..11ab17f64c649 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -261,7 +261,7 @@ static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
 	mutex_unlock(&ab8500->lock);
 	dev_vdbg(ab8500->dev, "rd: addr %#x => data %#x\n", addr, ret);
 
-	return ret;
+	return (ret < 0) ? ret : 0;
 }
 
 static int ab8500_get_register(struct device *dev, u8 bank,
-- 
2.19.1



