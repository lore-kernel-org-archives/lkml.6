Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FFEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D9820870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543294;
	bh=N6mEPIUBkE7ThVOPypNk904B1cNfsPfe/QlbfUqVzYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=efcGr9qqSnnyynLc9UD21dyaNmmMugU9qXE6FdWGs9XgP+5G+MR8Irj7A7TqpzBEO
	 4bbWT/LYss67IDMoGUuiYjO14ykPkI1Kko5Qgtbr2LZO4Nb8TUbVs1zni9ZKNXHUvJ
	 yDXLh0QKpJNJEWa1/Jz2YJUwN/BhROEj6ds8mhFU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D9820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeLKPsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbeLKPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C8720870;
        Tue, 11 Dec 2018 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543290;
        bh=N6mEPIUBkE7ThVOPypNk904B1cNfsPfe/QlbfUqVzYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxsddjIQEQ40GynZeWVctJtT1NVocJ48tdKhi3rcEdhqrKFo+hY6ZeAvAySDRyi5l
         Apzuh0IHxzFxeysnYYENo9P0ucBScmOBgo1VI9/Ep/p6QdVe5FjZg5eQIh6c4reEA/
         L8NVswPxRrg1LFzhqKD/ZRapldTHlntfx9j7KTec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paulo Alcantara <palcantara@suse.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.4 84/91] cifs: Fix separator when building path from dentry
Date:   Tue, 11 Dec 2018 16:41:43 +0100
Message-Id: <20181211151613.633521209@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

From: Paulo Alcantara <palcantara@suse.com>

commit c988de29ca161823db6a7125e803d597ef75b49c upstream.

Make sure to use the CIFS_DIR_SEP(cifs_sb) as path separator for
prefixpath too. Fixes a bug with smb1 UNIX extensions.

Fixes: a6b5058fafdf ("fs/cifs: make share unaccessible at root level mountable")
Signed-off-by: Paulo Alcantara <palcantara@suse.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -163,7 +163,7 @@ cifs_bp_rename_retry:
 
 		cifs_dbg(FYI, "using cifs_sb prepath <%s>\n", cifs_sb->prepath);
 		memcpy(full_path+dfsplen+1, cifs_sb->prepath, pplen-1);
-		full_path[dfsplen] = '\\';
+		full_path[dfsplen] = dirsep;
 		for (i = 0; i < pplen-1; i++)
 			if (full_path[dfsplen+1+i] == '/')
 				full_path[dfsplen+1+i] = CIFS_DIR_SEP(cifs_sb);


