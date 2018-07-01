Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E08DC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACC0258CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="Bz2w2Oey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACC0258CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeGAU5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 16:57:21 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:55492 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbeGAU5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 16:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZxLY72P4gbob6FIA2od3X9c3Lktdekx5XV5Dn4bZEHk=; b=Bz2w2OeyNqZJXk6+XYdXooDHv9
        2GsbPOxsbrnPIY1wvB0+a8yu6GugrzF7x8aomD/BiQDSSST9wu+5JIha17SZaPXauccZXhofuqTVz
        A7w2X7d8/P0jL/BRu0wHVcF6OdQbSyyRISe0pu638ARUfJEjmvXSe/uC82T+eRg07PEyCn8t8OVlA
        WeYwi6L6BXBi3piDB7KxRaEtZUZS9ERpaxmfNEovUwoyaRz4LHphyDZAhy4/MBqxTjHTXBfMVgsvR
        SUrTG43/lxuPYdRJImvW/UccMy7KLZ0SJ46KGFqSh4fB6WEiOCTMdxU7Azh3RTOrVVwicnBeP99Sy
        M7sBUJVQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48686 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fZjPI-007eAP-AC; Sun, 01 Jul 2018 20:57:16 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] kernfs: Replace strncpy with memcpy
Date:   Sun,  1 Jul 2018 13:57:13 -0700
Message-Id: <1530478633-16486-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 8.1.0 complains:

fs/kernfs/symlink.c:91:3: warning:
	'strncpy' output truncated before terminating nul copying
	as many bytes from a string as its length
fs/kernfs/symlink.c: In function 'kernfs_iop_get_link':
fs/kernfs/symlink.c:88:14: note: length computed here

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/kernfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 08ccabd7047f..5145ae2f0572 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -88,7 +88,7 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 		int slen = strlen(kn->name);
 
 		len -= slen;
-		strncpy(s + len, kn->name, slen);
+		memcpy(s + len, kn->name, slen);
 		if (len)
 			s[--len] = '/';
 
-- 
2.7.4

