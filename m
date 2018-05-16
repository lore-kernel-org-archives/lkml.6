Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeEPNmX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:42:23 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:42091 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEPNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:42:21 -0400
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, geert@glider.be, magnus.damm@gmail.com,
        robh+dt@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: Draak: Enable video inputs and VIN4
Date: Wed, 16 May 2018 15:42:06 +0200
Message-Id: <1526478129-16465-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   the second iteration of this series enables HDMI and CVBS video inputs
for the Draak board.

>From v1 series the description of VIN4 video interface for R8A77995 SoC has
already been collected by Simon, thus I'm not resending it.

This new version describes the HDMI input as v1 did, but does not connect it
to the VIN4 interface, as the video input path is shared between HDMI and
CVBS, and the default switches configuration selects CVBS.

I've not been able to test CVBS capture as I don't have any CVBS video source
here, but the devices shows up in the media controller graph as expected.

-------------------------------------------------------------------------------
[root@alarm ~]# media-ctl  -p -d /dev/media1
Media controller API version 4.17.0

Media device information
------------------------
driver          rcar_vin
model           renesas,vin-r8a77995
serial
bus info        platform:e6ef4000.video
hw revision     0x0
driver version  4.17.0

Device topology
- entity 1: adv7180 0-0020 (1 pad, 1 link)
            type V4L2 subdev subtype Unknown flags 20004
            device node name /dev/v4l-subdev6
        pad0: Source
                [fmt:UYVY8_2X8/720x480 field:interlaced colorspace:smpte170m]
                -> "VIN4 output":0 []

- entity 5: VIN4 output (1 pad, 1 link)
            type Node subtype V4L flags 0
            device node name /dev/video3
        pad0: Sink
                <- "adv7180 0-0020":0 []
-------------------------------------------------------------------------------

Compared to Gen2 boards that use adv7180 (Lager, Alt, Koelsch, Porter, Gose
and Silk) I have removed the 'bus-width' property as it is not parsed by the
driver nor mentioned in the chip device tree binding description.

Switching from CVBS to HDMI input requires connecting the HDMI decoder endpoint
to VIN4, change the pin muxing to increase the VIN4 input bus width to 24 bits,
and add the synchronism signal polarities to the vin endpoint, as the HDMI
decoder uses BT.601 while the analog video decoder uses BT.656 unconditionally.

The series has been developed on top of media-master tree but applies cleanly
on top of latest renesas-driver.

Patches for testing are available at:
git://jmondi.org/linux d3/media-master/driver-v2
git://jmondi.org/linux d3/media-master/dts-v2
git://jmondi.org/vin-tests d3

Thanks
    j

Jacopo Mondi (3):
  dt-bindings: media: rcar-vin: Add R8A77995 support
  arm64: dts: renesas: draak: Describe CVBS input
  arm64: dts: renesas: draak: Describe HDMI input

 .../devicetree/bindings/media/rcar_vin.txt         |  1 +
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 74 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)

--
2.7.4
