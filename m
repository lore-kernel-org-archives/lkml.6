Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034263AbeBPOYF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:24:05 -0500
Received: from mout.web.de ([212.227.17.11]:57379 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034154AbeBPOYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:24:03 -0500
Subject: [PATCH 2/2] pata_it821x: Use common error handling code in
 it821x_firmware_command()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <6cdadc5e-bfbd-9866-a69f-d225e68c3b22@users.sourceforge.net>
Message-ID: <6fc4ab6f-1168-d362-6a92-7d79b90489a2@users.sourceforge.net>
Date: Fri, 16 Feb 2018 15:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6cdadc5e-bfbd-9866-a69f-d225e68c3b22@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:AEf4/ib3GV6cEGCQ+nyZH1U75cDvZMhzB4doBBmiOxwLHGfMpj1
 MvMNCTiQBXVJCYGghXsvZdcUe1rAA5Cq3FZ/eldlFCmIKDOL4qRjsifXhNdPb8mNM8qcnN7
 FA5B70k4bOqbcN0xAuAzdN5DTTn9Zf30D+upyJ1o/8v2lSOg2j63wRoTer7P4JLIwy+qT4/
 YPpHYdjsRvL1SMzf+YXRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RRPtHZ1FzkA=:zZLPFnrOfjHaJ3am/nHKSj
 hlvIsu4V3xqbf/lLS3ZniYM77y92z0vmwx8gohFbgCEIifd2sxnzC2rn4zYjbkUXpXTbcPjs6
 Pb99LxSkOSojhuGFpb5MP4Y1ycrvYUsw44wRMiSvPnpkMZ+zTGrXzBwXioumaeMNZqg6NYC8R
 /B12GUFpvqoDQKku78DhC/2gv34gxTYxd9AIUBoQnlOtMz0PTQSVmDYEMnz8L4L07xNJ/IKB4
 cZe80m21gNESkkKDMSeEb10QQcuvZ7YFdi5S0eRLy4k0vCvVHJbeI6+iR69kulg0fTUDMSBBq
 5H5eS3Np0BZ+DaVNjY0dCiMsD/WHyQk2vF/54PJo7M/eVZ6mVpR1ekpbnRpEMQehg1q3kQvCz
 HwPsE11Qi3sj3px9Rl29OBA/BvERUfweSUcBK9O3+SacKN2NdL5jwYuEyKb41vkPhyW8O7px6
 w+F7r0TE8LGJHyIuGnyNE06t1bbwgVzl0/R4wbTV04eGOJ/RdmPPFH1/ztNrtHfHgxNApZ5tt
 rzPxythSZezCxooZ+LEsDSoefg4PBh1bSkBDOYFDFxVhpTgVSk1oXyPNJGDbnrTcvR2BE3RVz
 ImAZib1ep4pBtD/yQ8G4qhz0s+3b8U/mLxESvM0U7xjpRld7ky9QBrAxVH9+fCGQdvQsgsLka
 tvEZjRHggem8V1aE11T7PFcnAT61NonfMqxM8+jCl6yGR6MZZqYvhI1QsW+Yw72tcY6AChaAr
 wsrtw4AqdBaRmJENXcSMWB0PEFKcmiLrz3pB/RrJIaPlR4+RSC6kwBHWorCDrB0JWISKCqssr
 8TImfR1AXQg2WJ/2JIFtV5C0BEO4IX3mEd59kF8k99WMUQcRHQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 14:40:42 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Reorder three function calls.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_it821x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 46eacb6b93dd..6470112e5b48 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -675,9 +675,8 @@ static u8 *it821x_firmware_command(struct ata_port *ap, u8 cmd, int len)
 	while(n++ < 10) {
 		status = ioread8(ap->ioaddr.status_addr);
 		if (status & ATA_ERR) {
-			kfree(buf);
 			printk(KERN_ERR "it821x_firmware_command: rejected\n");
-			return NULL;
+			goto free_buffer;
 		}
 		if (status & ATA_DRQ) {
 			ioread16_rep(ap->ioaddr.data_addr, buf, len/2);
@@ -687,6 +686,8 @@ static u8 *it821x_firmware_command(struct ata_port *ap, u8 cmd, int len)
 	}
-	kfree(buf);
+
 	printk(KERN_ERR "it821x_firmware_command: timeout\n");
+free_buffer:
+	kfree(buf);
 	return NULL;
 }
 
-- 
2.16.1
