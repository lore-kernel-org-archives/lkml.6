Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeDKHuy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:50:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35607 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeDKHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:50:52 -0400
X-Google-Smtp-Source: AIpwx4+jEJKLmW32DcyMvYWjbxj4oXz6IeNXGD3OkVpqZWXSlybiX6xA3efyX3fX8Hm8rQE7vbwyQg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, source@mvista.com, alan@lxorguk.ukuu.org.uk
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ide: hpt366: Replace mdelay with usleep_range in init_chipset_hpt366
Date: Wed, 11 Apr 2018 15:50:43 +0800
Message-Id: <1523433043-3811-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_chipset_hpt366() is never called in atomic context.

init_chipset_hpt366() is set as ".init_chipset" in struct ide_port_info.
This function is not called in atomic context.

Despite never getting called from atomic context, init_chipset_hpt366()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ide/hpt366.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 4b5dc01..4045559 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -984,7 +984,7 @@ static int init_chipset_hpt366(struct pci_dev *dev)
 			for (temp = i = 0; i < 128; i++) {
 				pci_read_config_word(dev, 0x78, &f_cnt);
 				temp += f_cnt & 0x1ff;
-				mdelay(1);
+				usleep_range(1000, 2000);
 			}
 			f_cnt = temp / 128;
 		} else
-- 
1.9.1
