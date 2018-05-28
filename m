Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033850AbeE1KYf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033613AbeE1KY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:24:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 232/268] media: em28xx: USB bulk packet size fix
Date: Mon, 28 May 2018 12:03:26 +0200
Message-Id: <20180528100229.629939514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit c7c7e8d7803406daa21e96d00c357de8b77b6764 ]

Hauppauge em28xx bulk devices exhibit continuity errors and corrupted
packets, when run in VMWare virtual machines. Unknown if other
manufacturers bulk models exhibit the same issue. KVM/Qemu is unaffected.

According to documentation the maximum packet multiplier for em28xx in bulk
transfer mode is 256 * 188 bytes. This changes the size of bulk transfers
to maximum supported value and have a bonus beneficial alignment.

Before:

After:

This sets up USB to expect just as many bytes as the em28xx is set to emit.

Successful usage under load afterwards natively and in both VMWare
and KVM/Qemu virtual machines.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Reviewed-by: Michael Ira Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/em28xx/em28xx.h
+++ b/drivers/media/usb/em28xx/em28xx.h
@@ -187,7 +187,7 @@
    USB 2.0 spec says bulk packet size is always 512 bytes
  */
 #define EM28XX_BULK_PACKET_MULTIPLIER 384
-#define EM28XX_DVB_BULK_PACKET_MULTIPLIER 384
+#define EM28XX_DVB_BULK_PACKET_MULTIPLIER 94
 
 #define EM28XX_INTERLACED_DEFAULT 1
 
