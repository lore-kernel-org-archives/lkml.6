Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758662AbeD0QF2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:05:28 -0400
Received: from muru.com ([72.249.23.125]:39002 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758603AbeD0QFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:05:25 -0400
Date: Fri, 27 Apr 2018 09:05:22 -0700
From: Tony Lindgren <tony@atomide.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>
Subject: Re: drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: warning:  is
 used uninitialized in this function
Message-ID: <20180427160522.GC5671@atomide.com>
References: <201804190133.menhK9Gu%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804190133.menhK9Gu%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* kbuild test robot <lkp@intel.com> [180418 17:48]:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a27fc14219f2e3c4a46ba9177b04d9b52c875532
> commit: 5d1ebbda0318b1ba55eaa1fae3fd867af17b0774 phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on Droid 4
> date:   5 weeks ago
> config: x86_64-randconfig-a0-04190121 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 5d1ebbda0318b1ba55eaa1fae3fd867af17b0774
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    #'target_mem_ref' not supported by expression#'drivers/phy/motorola/phy-mapphone-mdm6600.c: In function 'phy_mdm6600_status':
> >> drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: warning:  is used uninitialized in this function [-Wuninitialized]
>       val |= values[i] << i;
>              ~~~~~~^~~

Thanks for the report and sorry for the delay in responding. Looks
like gpiod_get_array_value_cansleep initializes values. But we do
have wrong defines here, see the patch belwo.

Not sure if that is enough to fix the warning here though? I'm not
seeing the warning here with gcc-7.3.0 binutils-2.30.

Regards,

Tony

8< ---------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 25 Apr 2018 07:47:57 -0700
Subject: [PATCH] phy: mapphone-mdm6600: Fix wrong enum used for status
 lines

Kbuilt test robot reported:

drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: warning:  is used
uninitialized in this function [-Wuninitialized]
        val |= values[i] << i;
               ~~~~~~^~~

Looking at the phy_mdm6600_status() values does get initialized by
gpiod_get_array_value_cansleep(), but we are using wrong enum
in that function. Let's fix the use, both end up being three though
so urgent rush on this one AFAIK.

Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for
MDM6600 on Droid 4")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -178,13 +178,13 @@ static void phy_mdm6600_status(struct work_struct *work)
 	ddata = container_of(work, struct phy_mdm6600, status_work.work);
 	dev = ddata->dev;
 
-	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
+	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_STATUS_LINES,
 					       ddata->status_gpios->desc,
 					       values);
 	if (error)
 		return;
 
-	for (i = 0; i < PHY_MDM6600_NR_CMD_LINES; i++) {
+	for (i = 0; i < PHY_MDM6600_NR_STATUS_LINES; i++) {
 		val |= values[i] << i;
 		dev_dbg(ddata->dev, "XXX %s: i: %i values[i]: %i val: %i\n",
 			__func__, i, values[i], val);
-- 
2.17.0
