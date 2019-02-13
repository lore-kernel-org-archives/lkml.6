Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB0CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50EB222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083357;
	bh=njhlwNr/4tc5cWJiGJahpXAWfSSU9VyI4LIEf2X6Ve0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvMS4gyKcIDcJw3O+Dkfq4tmSqISwO9bK+SBiYVizbBfxtYhq/A8tzhvePMmRHmKn
	 42OGXTtsYCLGI5o3hcvWvcpLbxI99K/s7zd9ep+T47qDbNq493Eawx3aj8fG8ak1Gf
	 B3zDpheT+EFzZQVVJh3Ic2uEmQ48Ox+zdID3s0Y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405703AbfBMSmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405649AbfBMSmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC9F222D9;
        Wed, 13 Feb 2019 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083352;
        bh=njhlwNr/4tc5cWJiGJahpXAWfSSU9VyI4LIEf2X6Ve0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R16Y+ZkTnCo/AK/6cFdSXrK6mI+ANvW7DiToHi8NWXdLEAkce5ry8eyQQuIi67C0C
         NZPg1ny9E+27ijZEz/30sJKBL4Y0YhBCuz+PQLsgXEYx3t9Af7L/WM2QNaxBkSEHoh
         xWws8wBiXM0pcQUgUxHubACHhnxp5y5CNkxyi8K4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4.19 01/44] mtd: Make sure mtd->erasesize is valid even if the partition is of size 0
Date:   Wed, 13 Feb 2019 19:38:02 +0100
Message-Id: <20190213183651.764150579@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Boris Brezillon <bbrezillon@kernel.org>

commit ad4635153034c20c6f6e211e2ed3fd38b658649a upstream.

Commit 33f45c44d68b ("mtd: Do not allow MTD devices with inconsistent
erase properties") introduced a check to make sure ->erasesize and
->_erase values are consistent with the MTD_NO_ERASE flag.
This patch did not take the 0 bytes partition case into account which
can happen when the defined partition is outside the flash device memory
range. Fix that by setting the partition erasesize to the parent
erasesize.

Fixes: 33f45c44d68b ("mtd: Do not allow MTD devices with inconsistent erase properties")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <stable@vger.kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/mtdpart.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -470,6 +470,10 @@ static struct mtd_part *allocate_partiti
 		/* let's register it anyway to preserve ordering */
 		slave->offset = 0;
 		slave->mtd.size = 0;
+
+		/* Initialize ->erasesize to make add_mtd_device() happy. */
+		slave->mtd.erasesize = parent->erasesize;
+
 		printk(KERN_ERR"mtd: partition \"%s\" is out of reach -- disabled\n",
 			part->name);
 		goto out_register;


