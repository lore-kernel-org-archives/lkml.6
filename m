Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D818C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5471C2177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfBCOXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:23:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55860 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730559AbfBCOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:34 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeK-0006SB-SL; Sun, 03 Feb 2019 14:21:33 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006t4-Dk; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Ian Abbott" <abbotti@mev.co.uk>,
        "Spencer E. Olson" <olsonse@umich.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.883553816@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 073/305] staging: comedi: ni_mio_common: protect
 register write overflow
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Spencer E. Olson" <olsonse@umich.edu>

commit 1cbca5852d6c16e85a21487a15d211195aacd4a1 upstream.

Fixes two problems introduced as early as
commit 03aef4b6dc12  ("Staging: comedi: add ni_mio_common code"):
(1) Ensures that the last four bits of NISTC_RTSI_TRIGB_OUT_REG register is
    not unduly overwritten on e-series devices.  On e-series devices, the
    first three of the last four bits are reserved.  The last bit defines
    the output selection of the RGOUT0 pin, otherwise known as
    RTSI_Sub_Selection.  For m-series devices, these last four bits are
    indeed used as the output selection of the RTSI7 pin (and the
    RTSI_Sub_Selection bit for the RGOUT0 pin is moved to the
    RTSI_Trig_Direction register.
(2) Allows all 4 RTSI_BRD lines to be treated as valid sources for RTSI
    lines.

This patch also cleans up the ni_get_rtsi_routing command for readability.

Fixes: 03aef4b6dc12  ("Staging: comedi: add ni_mio_common code")
Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Use NI_RTSI_OUTPUT_RTSI_BRD_0 + n instead of NI_RTSI_OUTPUT_RTSI_BRD(n)
 - Use num_configurable_rtsi_channels() instead of NISTC_RTSI_TRIG_NUM_CHAN()
 - Use old_RTSI_clock_channel instead of NISTC_RTSI_TRIG_OLD_CLK_CHAN
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 .../staging/comedi/drivers/ni_mio_common.c    | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -5486,6 +5486,9 @@ static int ni_valid_rtsi_output_source(s
 	case NI_RTSI_OUTPUT_G_GATE0:
 	case NI_RTSI_OUTPUT_RGOUT0:
 	case NI_RTSI_OUTPUT_RTSI_BRD_0:
+	case NI_RTSI_OUTPUT_RTSI_BRD_0 + 1:
+	case NI_RTSI_OUTPUT_RTSI_BRD_0 + 2:
+	case NI_RTSI_OUTPUT_RTSI_BRD_0 + 3:
 		return 1;
 		break;
 	case NI_RTSI_OUTPUT_RTSI_OSC:
@@ -5513,12 +5516,19 @@ static int ni_set_rtsi_routing(struct co
 		    RTSI_Trig_Output_Bits(chan, source);
 		devpriv->stc_writew(dev, devpriv->rtsi_trig_a_output_reg,
 				    RTSI_Trig_A_Output_Register);
-	} else if (chan < 8) {
+	} else if (chan < num_configurable_rtsi_channels(dev)) {
 		devpriv->rtsi_trig_b_output_reg &= ~RTSI_Trig_Output_Mask(chan);
 		devpriv->rtsi_trig_b_output_reg |=
 		    RTSI_Trig_Output_Bits(chan, source);
 		devpriv->stc_writew(dev, devpriv->rtsi_trig_b_output_reg,
 				    RTSI_Trig_B_Output_Register);
+	} else if (chan != old_RTSI_clock_channel) {
+		/* probably should never reach this, since the
+		 * ni_valid_rtsi_output_source above errors out if chan is too
+		 * high
+		 */
+		dev_err(dev->class_dev, "%s: unknown rtsi channel\n", __func__);
+		return -EINVAL;
 	}
 	return 2;
 }
@@ -5533,12 +5543,12 @@ static unsigned ni_get_rtsi_routing(stru
 	} else if (chan < num_configurable_rtsi_channels(dev)) {
 		return RTSI_Trig_Output_Source(chan,
 					       devpriv->rtsi_trig_b_output_reg);
-	} else {
-		if (chan == old_RTSI_clock_channel)
-			return NI_RTSI_OUTPUT_RTSI_OSC;
-		printk("%s: bug! should never get here?\n", __func__);
-		return 0;
+	} else if (chan == old_RTSI_clock_channel) {
+		return NI_RTSI_OUTPUT_RTSI_OSC;
 	}
+
+	dev_err(dev->class_dev, "%s: unknown rtsi channel\n", __func__);
+	return -EINVAL;
 }
 
 static int ni_rtsi_insn_config(struct comedi_device *dev,

