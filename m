Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7270C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7823E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169112;
	bh=gYZj9qaJ7bptTBgQer0YtqW1bdsjHU1QLtHpEBye3W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BtHs4Gqn7gFsWx/Qes0y1lz2SxjjgmWrBbA44kFgmGGJEN+cvK6bp8N7OwLZugF2f
	 cVTMdM3Z/bvAYG/hbHZ4yyohJb2IYVMgc4s1ZYGJvKd/jhAfxLDfTQWm2Z6N+lIKkB
	 sNruxm5e3exchnBuCZq+y4IGEvrzgQyRG9RytGsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfAVO6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:58:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbfAVO62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:58:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B415621721;
        Tue, 22 Jan 2019 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169108;
        bh=gYZj9qaJ7bptTBgQer0YtqW1bdsjHU1QLtHpEBye3W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pql8MFFMb4i8rPRx/sfcNWjj7huukMHE76OplC7DdwjCZrKdVgmsl81e5YaXo1V0F
         VkJMfSyRt79NduPBlfchtdbEz3yFCumF/rGVQwkEV9p/OYGyNyPuLFgrajp6Dl1AJI
         U7TcjrltT12iUFn429cPv6Sq4AmTf6vCEq7eixNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/5] mips: ralink: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:57:39 +0100
Message-Id: <20190122145742.11292-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122145742.11292-1-gregkh@linuxfoundation.org>
References: <20190122145742.11292-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/ralink/bootrom.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/mips/ralink/bootrom.c b/arch/mips/ralink/bootrom.c
index e1fa5972a81d..648f5eb2ba68 100644
--- a/arch/mips/ralink/bootrom.c
+++ b/arch/mips/ralink/bootrom.c
@@ -35,13 +35,7 @@ static const struct file_operations bootrom_file_ops = {
 
 static int bootrom_setup(void)
 {
-	if (!debugfs_create_file("bootrom", 0444,
-			NULL, NULL, &bootrom_file_ops)) {
-		pr_err("Failed to create bootrom debugfs file\n");
-
-		return -EINVAL;
-	}
-
+	debugfs_create_file("bootrom", 0444, NULL, NULL, &bootrom_file_ops);
 	return 0;
 }
 
-- 
2.20.1

