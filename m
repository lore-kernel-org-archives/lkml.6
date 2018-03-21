Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbeCUUuJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:50:09 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34677 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753006AbeCUUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:49:57 -0400
X-Google-Smtp-Source: AG47ELt4mW38ATpo/Vgw0KtPJ94PVi7AIB/ue9SEzuAa8Ej9SUQKlEBAXn7+HgjY50LzlVRshppQDg==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [RFC PATCH v6 0/1] hid-steam driver with user mode client dection
Date: Wed, 21 Mar 2018 21:49:31 +0100
Message-Id: <20180321204932.12687-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a RFC for the problem of how to work with the Steam Controller from
a kernel driver without disturbing the user mode drivers.

The main user mode driver is the Steam Controller itself. From now on I will
call any user mode driver a "hidraw client" because that is the mode most of
them use.

Steam Client is able to use a raw libusb user mode driver, but it
looks like it does so only if hidraw is not available, so I'm not currently
concerned with those.

This driver, as is, does the following:
 1. It keeps the mouse/keyboard emulation (lizard mode) working while the
    hid-steam input device is not in use.
 2. When the hid-steam input device is opened, lizard mode is disabled, but
    ONLY IF there are no hidraw clients. This is necessary because with the
    lizard mode on, a gesture in the gamepad can make several unrelated input
    events and games go crazy.
 3. When the hid-steam input device is closed, lizard mode is re-enabled, but
    ONLY IF there are no hidraw clients.
 4. If while the hid-steam input device is opened, a hidraw client starts,
    then the input events are disabled for this driver, in order to avoid 
    double inputs in games that read all available game controllers.
 4. If a hid-steam input device and a hidraw client are running, and then the
    hidraw client finishes, then lizard mode is disabled, just like in 2.

Other than what to do exactly, IMO, there are three tricky parts that deserve
the RFC:
 1. Is the procedure avobe the right way to do it?
 2. How to detect whether a hidraw client is in use. Currently I'm looking at
    hid_device::ll_open_count and compare with the number of times I called
    hid_hw_open() - hid_hw_close(). I'm exploring using a custom hid_ll_driver
    instead...
 3. How to disable the lizard mode. Currently I'm sending a few feature
    reports that prevent the hardware from sending keyboard/mouse events. But
    maybe they can be disabled at hid level, so we can avoid messing with the
    hardware configuration, and the possible incompatibilities and races that
    arise.

PS. I've collapsed the patch-set into a single bigger commit, because my
original split makes sense no longer. Sorry for the inconvenience.

Thank you in advance for any comment.

Rodrigo Rivas Costa (1):
  HID: add driver for Valve Steam Controller

 drivers/hid/Kconfig     |   8 +
 drivers/hid/Makefile    |   1 +
 drivers/hid/hid-ids.h   |   4 +
 drivers/hid/hid-steam.c | 874 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 887 insertions(+)
 create mode 100644 drivers/hid/hid-steam.c

-- 
2.16.2
