Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754147AbeDPM2X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:28:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43347 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753931AbeDPM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:28:21 -0400
X-Google-Smtp-Source: AIpwx48iXQvln0QHBELf3IKcK9nNPXbRuUgUvBCQzCaocDUlKTjZA/2giSM0VvYpZb+AdmPwjs+C2Q==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v9 0/2] hid-steam driver with user mode client dection
Date: Mon, 16 Apr 2018 14:27:01 +0200
Message-Id: <20180416122703.22306-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! This is reroll v9 of the Steam Controller driver.

@Pierre-Loup, @Clément, could you please check if this driver is acceptable by
Valve? I think this could be the one ;-).

I've rolled back the synthetic LPAD diagonals. It happens that the actual
coordinates of the pads are rotated about 15 degrees to the center, but the
marks in the pad are aligned to 0/90 degrees. That, and my poor's man
trigonometry, makes clicking the diagonals quite unreliable.
Sorry for the noise, but now I think that we are better limiting ourselves to
the events emitted by the hardware, as is.

Other than that, I've doing some torture testing, with and without the Steam
Client running. I've changed:
 1. The way EPIPE is handled when sending a report: I've noticed that Steam
    Client retries up to 50 times, with little or no delay between them, so I do
    the same.
 2. I've added a fallback in case this driver is unable to get the serial number
    of the controller. Failures on any other report can be ignored safely. But
    failing to get the serial number was preventing the creating of the hidraw
    node (wired controller only), and that could prevent Steam Client from
    working. 
 3. I've received a mail from Valve with a bunch of constants for the
    protocol. Most are related to the setting of new mappings (that we do not
    need) and a few of the rest are deprecated. Anyway, I've renamed the
    constants STEAM_CMD_* to align them with the official names, and added a
    few more that were unknown to me, just for future reference. Still, commands
    used for enabling/disabling lizard mode are the same.

Best regards.

Changes in v9:
 * Remove synthetic diagonals for the DPAD (bad idea).
 * Rename protocol constants to follow Valve names.
 * Rewrite the retry fo steam_send_report() when EPIPE.
 * Add a fallback for failure getting the serial number.

Changes in v8:
 * Add constants for the protocol major magic numbers.
 * Disable/Enable margin of the rpad, together with the lizard-mode.
 * Synthesize diagonals for the DPAD.
 * Fix overflow with Y=-32768.
 * Make lizard_mode parameter a bool, dynamically updatable.

Changes in v7:
 * All the automatic lizard_mode stuff.
 * Added the lizard_mode parameter.
 * The patchset is reduced to 2 commits. The separation of the
   steam_get_serial command no longer makes sense, since I need the
   steam_send_cmd in the first commit to implement the lizard mode.
 * Change the input mapping to conform to Documentation/gamepad.rst.

(v6 was a RFC, it does not count).

Changes in v5:
 * Fix license SPDX to GPL-2.0+.
 * Minor stylistic changes (BIT(3) instead 0x08 and so on).

Changes in v4:
 * Add command to check the wireless connection status on probe, without
   waiting for a message (thanks to Clément Vuchener for the tip).
 * Removed the error code on redundant connection/disconnection messages. That
   was harmless but polluted dmesg.
 * Added buttons for touching the left-pad and right-pad.
 * Fixed a misplaced #include from 2/4 to 1/4.

Changes in v3:
 * Use RCU to do the dynamic connec/disconnect of wireless devices.
 * Remove entries in hid-quirks.c as they are no longer needed. This allows
   this module to be blacklisted without side effects.
 * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
   existing use cases (lizard mode). A user-space tool to do that is
   linked.
 * Fully separated axes for joystick and left-pad. As it happens.
 * Add fuzz values for left/right pad axes, they are a little wiggly.

Changes in v2:
 * Remove references to USB. Now the interesting interfaces are selected by
   looking for the ones with feature reports.
 * Feature reports buffers are allocated with hid_alloc_report_buf().
 * Feature report length is checked, to avoid overflows in case of
   corrupt/malicius USB devices.
 * Resolution added to the ABS axes.
 * A lot of minor cleanups.

Rodrigo Rivas Costa (2):
  HID: add driver for Valve Steam Controller
  HID: steam: add battery device.

 drivers/hid/Kconfig     |    8 +
 drivers/hid/Makefile    |    1 +
 drivers/hid/hid-ids.h   |    4 +
 drivers/hid/hid-steam.c | 1112 +++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h     |    1 +
 5 files changed, 1126 insertions(+)
 create mode 100644 drivers/hid/hid-steam.c

-- 
2.17.0
