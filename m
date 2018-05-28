Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424480AbeE1LO5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424202AbeE1LOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:14:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 216/272] pinctrl: devicetree: Fix dt_to_map_one_config handling of hogs
Date: Mon, 28 May 2018 12:04:09 +0200
Message-Id: <20180528100258.631577028@linuxfoundation.org>
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

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit b89405b6102fcc3746f43697b826028caa94c823 ]

When dt_to_map_one_config() is called with a pinctrl_dev passed
in, it should only be using this if the node being looked up
is a hog. The code was always using the passed pinctrl_dev
without checking whether the dt node referred to it.

A pin controller can have pinctrl-n dependencies on other pin
controllers in these cases:

- the pin controller hardware is external, for example I2C, so
  needs other pin controller(s) to be setup to communicate with
  the hardware device.

- it is a child of a composite MFD so its of_node is shared with
  the parent MFD and other children of that MFD. Any part of that
  MFD could have dependencies on other pin controllers.

Because of this, dt_to_map_one_config() can't assume that if it
has a pinctrl_dev passed in then the node it looks up must be
a hog. It could be a reference to some other pin controller.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/devicetree.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -122,8 +122,10 @@ static int dt_to_map_one_config(struct p
 			/* OK let's just assume this will appear later then */
 			return -EPROBE_DEFER;
 		}
-		if (!pctldev)
-			pctldev = get_pinctrl_dev_from_of_node(np_pctldev);
+		/* If we're creating a hog we can use the passed pctldev */
+		if (pctldev && (np_pctldev == p->dev->of_node))
+			break;
+		pctldev = get_pinctrl_dev_from_of_node(np_pctldev);
 		if (pctldev)
 			break;
 		/* Do not defer probing of hogs (circular loop) */
