Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B3B217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfBZTXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:23:20 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.2]:39880 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbfBZTXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:23:20 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 0A187400D3A7A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 13:23:19 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id yiJzglAQYYTGMyiJzg2CSW; Tue, 26 Feb 2019 13:23:19 -0600
X-Authority-Reason: nr=8
Received: from [189.250.127.169] (port=34456 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gyiJy-003zU1-2k; Tue, 26 Feb 2019 13:23:18 -0600
Date:   Tue, 26 Feb 2019 13:23:17 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] virt: vbox: Mark expected switch fall-through
Message-ID: <20190226192317.GA23656@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.169
X-Source-L: No
X-Exim-ID: 1gyiJy-003zU1-2k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.169]:34456
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/virt/vboxguest/vboxguest_core.c: In function ‘vbg_core_ioctl’:
drivers/virt/vboxguest/vboxguest_core.c:1486:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
   f32bit = true;
   ~~~~~~~^~~~~~
drivers/virt/vboxguest/vboxguest_core.c:1489:2: note: here
  case VBG_IOCTL_HGCM_CALL(0):
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 1475ed5ffcde..df7d09409efe 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1484,8 +1484,8 @@ int vbg_core_ioctl(struct vbg_session *session, unsigned int req, void *data)
 #ifdef CONFIG_COMPAT
 	case VBG_IOCTL_HGCM_CALL_32(0):
 		f32bit = true;
-		/* Fall through */
 #endif
+		/* Fall through */
 	case VBG_IOCTL_HGCM_CALL(0):
 		return vbg_ioctl_hgcm_call(gdev, session, f32bit, data);
 	case VBG_IOCTL_LOG(0):
-- 
2.21.0

