Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeDBS23 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 14:28:29 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35835 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeDBS21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 14:28:27 -0400
X-Google-Smtp-Source: AIpwx48wlE4PVKwKKGYg7A/I89n2BNv0El1fGaSBUnFDg4GQovJIQyBibccC93HQomzPqN1SrHFcIQ==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v8 0/2] hid-steam driver with user mode client dection
Date: Mon,  2 Apr 2018 20:28:05 +0200
Message-Id: <20180402182807.19878-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another reroll of the Steam Controller driver.

This time there is a complete rewrite of steam_probe(), that had been
growing _organically_. I gave up on trying to initialize the hidraw
device on partial probe failure, it makes the code much more complicated
and for little gain.

Maybe it is not to appropriate to add features on reroll 8, but...
now that we are, I think, race-free regarding to the Steam Client, and
I've been playing with a few games, I noticed a couple of issues:
 * The right pad has a dead margin, I don't know what its use is, but
   Steam Client disables it, so I'm doing the same in game-pad mode. It
   just serves no function (left pad does not have it). I enable it
   together with lizard-mode, of course.
 * The DPAD (clicking on the border of the left pad) cannot emit
   diagonals. That's not nice, so I'm currently synthesizing them from
   the lpad coordinates. I don't know if it is appropriate... if not,
   just let me know. This is register 0x18.

Since now there are quite a few registers and commands, I've added names
for the major constants in the protocol.

Also there was an overflow when any Y coordinate reached -32768, fixed.

And I changed the lizard_mode to a boolean parameter, but with a
callback. I've added a global list of steam_device to be able to do the
runtime change. The meaning of this parameter is now:
 * When hidraw is in use, nothing is done.
 * When the gamepad is in use, lizard_mode is always disabled.
 * When the gamepad is not in use:
    - lizard_mode=N: mouse/keyboard emulation disabled.
    - lizard_mode=Y (default): mouse/keyboard emulation enabled.

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
 drivers/hid/hid-steam.c | 1112 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h     |    1 +
 5 files changed, 1126 insertions(+)
 create mode 100644 drivers/hid/hid-steam.c

-- 
2.16.3
