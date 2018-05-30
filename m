Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeE3LKu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:10:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60802 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751921AbeE3LHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:49 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Enrico Mioso" <mrkiko.rs@gmail.com>,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.117977929@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 065/153] media: cxusb, dib0700: ignore XC2028_I2C_FLUSH
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

commit 9893b905e743ded332575ca04486bd586c0772f7 upstream.

The XC2028_I2C_FLUSH only needs to be implemented on a few
devices. Others can safely ignore it.

That prevents filling the dmesg with lots of messages like:

	dib0700: stk7700ph_xc3028_callback: unknown command 2, arg 0

Fixes: 4d37ece757a8 ("[media] tuner/xc2028: Add I2C flush callback")
Reported-by: Enrico Mioso <mrkiko.rs@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
[bwh: Backported to 3.2: adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/dvb/dvb-usb/cxusb.c           | 2 ++
 drivers/media/dvb/dvb-usb/dib0700_devices.c | 1 +
 2 files changed, 3 insertions(+)

--- a/drivers/media/dvb/dvb-usb/cxusb.c
+++ b/drivers/media/dvb/dvb-usb/cxusb.c
@@ -772,6 +772,8 @@ static int dvico_bluebird_xc2028_callbac
 	case XC2028_RESET_CLK:
 		deb_info("%s: XC2028_RESET_CLK %d\n", __func__, arg);
 		break;
+	case XC2028_I2C_FLUSH:
+		break;
 	default:
 		deb_info("%s: unknown command %d, arg %d\n", __func__,
 			 command, arg);
--- a/drivers/media/dvb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/dvb/dvb-usb/dib0700_devices.c
@@ -405,6 +405,7 @@ static int stk7700ph_xc3028_callback(voi
 		dib7000p_set_gpio(adap->fe_adap[0].fe, 8, 0, 1);
 		break;
 	case XC2028_RESET_CLK:
+	case XC2028_I2C_FLUSH:
 		break;
 	default:
 		err("%s: unknown command %d, arg %d\n", __func__,
