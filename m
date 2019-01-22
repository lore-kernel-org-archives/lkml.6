Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0D1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511E4217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170647;
	bh=C9t1G+XJBuFXEDl5amB0oYoq/0mDQuFNCP89ObAtSY8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FcC2hOnr11xPGwFLbmR+fnc7MBWgQrnrrBvbgGPTpQoohIMQ6Nmwsv2tO+oIxLeDd
	 zrwM7XEQLHWPJ2qZzwpdv+YaPaQj1HqZ3kiXpLns6tnqUgRNvP0FDw2xyrql+0VUUo
	 uF5dNIoHnG/EIMmrqjHvMs+GYthg2cJEpXcdsp+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfAVPYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:24:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbfAVPYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:24:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C5720879;
        Tue, 22 Jan 2019 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170639;
        bh=C9t1G+XJBuFXEDl5amB0oYoq/0mDQuFNCP89ObAtSY8=;
        h=From:To:Cc:Subject:Date:From;
        b=kyL991kn/O0WvvYmsmVV7Yp2wvp//wUCXVBmbkaoXLnH8JoL304yqIsQw0EFKTUlg
         HcL4KuPpb/Yn7acrGzuMs8Cf43e/ev9oH0URTW1KFkJxaYRF2MihymPHjrR4j7gWqL
         Gk/Qkz+4tzXNkXckydnE3UcVFFhC4PepoRSm1tLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: [PATCH] realtek: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:33 +0100
Message-Id: <20190122152151.16139-34-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/debug.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index d70385be9976..8186650efc56 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -463,12 +463,9 @@ static const struct file_operations file_ops_common_write = {
 #define RTL_DEBUGFS_ADD_CORE(name, mode, fopname)			   \
 	do {								   \
 		rtl_debug_priv_ ##name.rtlpriv = rtlpriv;		   \
-		if (!debugfs_create_file(#name, mode,			   \
-					 parent, &rtl_debug_priv_ ##name,  \
-					 &file_ops_ ##fopname))		   \
-			pr_err("Unable to initialize debugfs:%s/%s\n",	   \
-			       rtlpriv->dbg.debugfs_name,		   \
-			       #name);					   \
+		debugfs_create_file(#name, mode, parent,		   \
+				    &rtl_debug_priv_ ##name,		   \
+				    &file_ops_ ##fopname);		   \
 	} while (0)
 
 #define RTL_DEBUGFS_ADD(name)						   \
@@ -486,11 +483,6 @@ void rtl_debug_add_one(struct ieee80211_hw *hw)
 
 	rtlpriv->dbg.debugfs_dir =
 		debugfs_create_dir(rtlpriv->dbg.debugfs_name, debugfs_topdir);
-	if (!rtlpriv->dbg.debugfs_dir) {
-		pr_err("Unable to init debugfs:/%s/%s\n", rtlpriv->cfg->name,
-		       rtlpriv->dbg.debugfs_name);
-		return;
-	}
 
 	parent = rtlpriv->dbg.debugfs_dir;
 
-- 
2.20.1

