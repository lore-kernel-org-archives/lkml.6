Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeE3L1l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:27:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33285 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752656AbeE3LYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:15 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.935554343@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 031/153] media: bt8xx: Fix err 'bt878_probe()'
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 45392ff6881dbe56d41ef0b17c2e576065f8ffa1 upstream.

This is odd to call 'pci_disable_device()' in an error path before a
coresponding successful 'pci_enable_device()'.

Return directly instead.

Fixes: 77e0be12100a ("V4L/DVB (4176): Bug-fix: Fix memory overflow")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/dvb/bt8xx/bt878.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/dvb/bt8xx/bt878.c
+++ b/drivers/media/dvb/bt8xx/bt878.c
@@ -434,8 +434,7 @@ static int __devinit bt878_probe(struct
 	       bt878_num);
 	if (bt878_num >= BT878_MAX) {
 		printk(KERN_ERR "bt878: Too many devices inserted\n");
-		result = -ENOMEM;
-		goto fail0;
+		return -ENOMEM;
 	}
 	if (pci_enable_device(dev))
 		return -EIO;
