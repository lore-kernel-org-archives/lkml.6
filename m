Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754327AbeDZHyh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:54:37 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:45009 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754282AbeDZHya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:54:30 -0400
X-Google-Smtp-Source: AIpwx49D7qgNCiBbB4EGSwjdvkTqaZeThKp8DF9wQFWcix6o3ldkn1AKX0ClMEESAO9EEdnjQtG50w==
From: Holger Schurig <holgerschurig@gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] igb: reconnecting of cable not always detected
In-Reply-To: <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com>
References: <87h8o0ocul.fsf@gmail.com> <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com> <877eovobxl.fsf@gmail.com> <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com>
Date: Thu, 26 Apr 2018 09:54:27 +0200
Message-ID: <8736zio11o.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Was the orange LED on the igb NIC or on the TL SG-108? Based on the
> comment below I am assuming it is the switch.

The LEDs were on the switch.

When everything works, the switch says green == 1000 MB/s.

When cable is disconnected, switch doesn't light any LED.

When cable is inserted and things fail, the switch says orange LED == 100 MB/s.
Sometimes the insertion process works, then the switch will go, of
course, to the green LED == 1000 MB/s.

I must admit that I didn't look at the LEDs of the device.


Now I looked there, and the device the left+green LED is on. In the
failed case (so, in the dmesg output the last thing I see is "Link is
Down", but the device still has left+green LED on.

The right+orange LED on the device seems to indicate traffic, and it is
constantly off in the failed case.



> I assume you mean "ethtool -r" since that is what is supposed to be
> restarting negotiation. The "ethtool -i" is what you provided above.

Maybe I've edited my text too much and moved output along. Anyway, in
the failed case neither "ethtool- r eth0" nor "ethtool -i eth0" nor
"mii-tool eth0" work at all, they all emit error warning.

> Thanks. I'm suspecting we may need to instrument igb_rd32 at this
> point. In order to trigger what you are seeing I am assuming the
> device has been detached due to a read failure of some sort.

I'll do that and reply later. I first need to understand this source
part :-)


> Another thing you could look at doing is narrowing down the possible
> factors involved. You could go through and limit phy settings and look
> at possibly dropping features such as EEE if it is enabled on the
> device.

I actually tried a driver patch to remove 1000 GB/s from the driver, in
the assumption that maybe this specific hardware has a bad layout and
thus trouble (I don't really think that, because I never observed any
data transfer problem).

So, is the following patch (that didn't help) what in the line of what
you suggested?


Index: linux-4.16/drivers/net/ethernet/intel/igb/igb_main.c
===================================================================
--- linux-4.16.orig/drivers/net/ethernet/intel/igb/igb_main.c	2018-04-01 23:20:27.000000000 +0200
+++ linux-4.16/drivers/net/ethernet/intel/igb/igb_main.c	2018-04-24 11:35:17.420760650 +0200
@@ -2080,7 +2080,7 @@
 
 	if ((adapter->flags & IGB_FLAG_EEE) &&
 	    (!hw->dev_spec._82575.eee_disable))
-		adapter->eee_advert = MDIO_EEE_100TX | MDIO_EEE_1000T;
+		adapter->eee_advert = MDIO_EEE_100TX /* | MDIO_EEE_1000T */;
 
 	return 0;
 }
@@ -2908,7 +2908,7 @@
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;
 	hw->mac.autoneg = true;
-	hw->phy.autoneg_advertised = 0x2f;
+	hw->phy.autoneg_advertised = 0x0f;
 
 	hw->fc.requested_mode = e1000_fc_default;
 	hw->fc.current_mode = e1000_fc_default;
@@ -3099,7 +3099,7 @@
 			if ((!err) &&
 			    (!hw->dev_spec._82575.eee_disable)) {
 				adapter->eee_advert =
-					MDIO_EEE_100TX | MDIO_EEE_1000T;
+					MDIO_EEE_100TX /* | MDIO_EEE_1000T */;
 				adapter->flags |= IGB_FLAG_EEE;
 			}
 			break;
@@ -3110,7 +3110,7 @@
 				if ((!err) &&
 					(!hw->dev_spec._82575.eee_disable)) {
 					adapter->eee_advert =
-					   MDIO_EEE_100TX | MDIO_EEE_1000T;
+					   MDIO_EEE_100TX /* | MDIO_EEE_1000T */;
 					adapter->flags |= IGB_FLAG_EEE;
 				}
 			}
Index: linux-4.16/drivers/net/ethernet/intel/igb/igb_ethtool.c
===================================================================
--- linux-4.16.orig/drivers/net/ethernet/intel/igb/igb_ethtool.c	2018-04-01 23:20:27.000000000 +0200
+++ linux-4.16/drivers/net/ethernet/intel/igb/igb_ethtool.c	2018-04-24 11:42:36.737959749 +0200
@@ -170,7 +170,7 @@
 			     SUPPORTED_10baseT_Full |
 			     SUPPORTED_100baseT_Half |
 			     SUPPORTED_100baseT_Full |
-			     SUPPORTED_1000baseT_Full|
+			     /* SUPPORTED_1000baseT_Full| */ 
 			     SUPPORTED_Autoneg |
 			     SUPPORTED_TP |
 			     SUPPORTED_Pause);
@@ -3003,7 +3003,7 @@
 	    (hw->phy.media_type != e1000_media_type_copper))
 		return -EOPNOTSUPP;
 
-	edata->supported = (SUPPORTED_1000baseT_Full |
+	edata->supported = (/* SUPPORTED_1000baseT_Full | */
 			    SUPPORTED_100baseT_Full);
 	if (!hw->dev_spec._82575.eee_disable)
 		edata->advertised =
