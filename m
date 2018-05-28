Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938598AbeE1MEn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423204AbeE1LGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 046/272] firmware: dmi_scan: Fix UUID length safety check
Date: Mon, 28 May 2018 12:01:19 +0200
Message-Id: <20180528100244.705937801@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit 90fe6f8ff00a07641ca893d64f75ca22ce77cca2 ]

The test which ensures that the DMI type 1 structure is long enough
to hold the UUID is off by one. It would fail if the structure is
exactly 24 bytes long, while that's sufficient to hold the UUID.

I don't expect this bug to cause problem in practice because all
implementations I have seen had length 8, 25 or 27 bytes, in line
with the SMBIOS specifications. But let's fix it still.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: a814c3597a6b ("firmware: dmi_scan: Check DMI structure length")
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/dmi_scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -186,7 +186,7 @@ static void __init dmi_save_uuid(const s
 	char *s;
 	int is_ff = 1, is_00 = 1, i;
 
-	if (dmi_ident[slot] || dm->length <= index + 16)
+	if (dmi_ident[slot] || dm->length < index + 16)
 		return;
 
 	d = (u8 *) dm + index;
