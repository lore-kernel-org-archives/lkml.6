Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82CCC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF72321470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmZGsXjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF72321470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbeJKXQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbeJKXQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:50 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B1CD21470;
        Thu, 11 Oct 2018 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272944;
        bh=3nMkJ0DcyEt7ffstctos+SP+EsmydVMsdV6dKEdqVTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmZGsXjceVpNIY4AcbpS09ou4ehmxJTy4XxDDaleDKDzR8UWjOi40SemZB3LuUImS
         wecntdqNzWW0eYfjpTob/Ap5SatCEwx6BxYIpSrOUTjz5RKEuwCmI5z34LYhUB4+Wr
         Cyj0nziHcd7JXMlQX3XzoU7GuSJVnmxGieI7V694=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+38bd0f7865e5c6379280@syzkaller.appspotmail.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.18 42/44] ubifs: Check for name being NULL while mounting
Date:   Thu, 11 Oct 2018 17:40:20 +0200
Message-Id: <20181011152454.318621224@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
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

From: Richard Weinberger <richard@nod.at>

commit 37f31b6ca4311b94d985fb398a72e5399ad57925 upstream.

The requested device name can be NULL or an empty string.
Check for that and refuse to continue. UBIFS has to do this manually
since we cannot use mount_bdev(), which checks for this condition.

Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
Reported-by: syzbot+38bd0f7865e5c6379280@syzkaller.appspotmail.com
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/super.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1929,6 +1929,9 @@ static struct ubi_volume_desc *open_ubi(
 	int dev, vol;
 	char *endptr;
 
+	if (!name || !*name)
+		return ERR_PTR(-EINVAL);
+
 	/* First, try to open using the device node path method */
 	ubi = ubi_open_volume_path(name, mode);
 	if (!IS_ERR(ubi))


