Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38EFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEBC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYj2wupN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEBC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbeKTC4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729979AbeKTC4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68AF20831;
        Mon, 19 Nov 2018 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645127;
        bh=RhTKSX7cAXXjN/I4gV5xDcfOZzBieRqWLKYrueZ1UPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYj2wupNPes3jLWLbxc35HPCI9CF7dbU2YXMicn81RHmdFeq7AhZ4BiAjxRxKQvii
         5NesjAfcwKsfxGscBDb4JWc61ynACuYl1lXW+tVnL8B2nCQhwLsVbAiYMFUMd4b+Wa
         Me53yDcvl82xuBZNQKmSSaJZ6BRDCCcMrXameAfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+ff03fe05c717b82502d0@syzkaller.appspotmail.com,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 046/205] ovl: fix error handling in ovl_verify_set_fh()
Date:   Mon, 19 Nov 2018 17:25:53 +0100
Message-Id: <20181119162625.590450047@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit babf4770be0adc69e6d2de150f4040f175e24beb upstream.

We hit a BUG on kfree of an ERR_PTR()...

Reported-by: syzbot+ff03fe05c717b82502d0@syzkaller.appspotmail.com
Fixes: 8b88a2e64036 ("ovl: verify upper root dir matches lower root dir")
Cc: <stable@vger.kernel.org> # v4.13
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/namei.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -422,8 +422,10 @@ int ovl_verify_set_fh(struct dentry *den
 
 	fh = ovl_encode_real_fh(real, is_upper);
 	err = PTR_ERR(fh);
-	if (IS_ERR(fh))
+	if (IS_ERR(fh)) {
+		fh = NULL;
 		goto fail;
+	}
 
 	err = ovl_verify_fh(dentry, name, fh);
 	if (set && err == -ENODATA)


