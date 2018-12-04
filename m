Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDEDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E3421508
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj3AQGC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E3421508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeLDLHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbeLDLHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:07:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D112082D;
        Tue,  4 Dec 2018 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921639;
        bh=w8GLwSqz3zNnJ+UnTOlniQslIjpb/tNSrLiDeBLmdPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dj3AQGC28HtPMrWxjHmSNAdb+1UzMOTyHFS8w8ig7RFMzr0plWHkp9WvzhB3LUjQ4
         pIIi5nK6hevIEo3ENWtnujIng2w0QPosvyWNoukjkzAB0yekEXXMLMky+zmvYplJYT
         30dX7BM8BsbwzAYu5Pvq6xEQ7QSkQ0ZBwHLpanxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 142/146] lib/test_kmod.c: fix rmmod double free
Date:   Tue,  4 Dec 2018 11:50:28 +0100
Message-Id: <20181204103732.536311320@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luis Chamberlain <mcgrof@kernel.org>

commit 5618cf031fecda63847cafd1091e7b8bd626cdb1 upstream.

We free the misc device string twice on rmmod; fix this.  Without this
we cannot remove the module without crashing.

Link: http://lkml.kernel.org/r/20181124050500.5257-1-mcgrof@kernel.org
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>	[4.12+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_kmod.c |    1 -
 1 file changed, 1 deletion(-)

--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1221,7 +1221,6 @@ void unregister_test_dev_kmod(struct kmo
 
 	dev_info(test_dev->dev, "removing interface\n");
 	misc_deregister(&test_dev->misc_dev);
-	kfree(&test_dev->misc_dev.name);
 
 	mutex_unlock(&test_dev->config_mutex);
 	mutex_unlock(&test_dev->trigger_mutex);


