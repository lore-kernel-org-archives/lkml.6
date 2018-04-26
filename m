Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756588AbeDZOo7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:44:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38297 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbeDZOo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:44:57 -0400
X-Google-Smtp-Source: AIpwx4+NTD8TBkwEx4jdb3I1d/Owm1Px1JL9OKGp3ZR9FVb2k2VA2fs58+I/85JTLyAz3UOcOReM03vgrk9lGfHrCAg=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Apr 2018 16:44:56 +0200
X-Google-Sender-Auth: RG62aGMuwfD4VoCaZ6nnuYrG2r4
Message-ID: <CAJZ5v0i9VLKS5bz8R8EGWjBQaHEsm-jOYwHAAWNt+eS8301cvA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v4.17-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.17-rc3

with top-most commit bd6dff55de7acb2e5065e69706400c41b1bd0521

 Merge branches 'acpi-watchdog', 'acpi-button' and 'acpi-video'

on top of commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e

 Linux 4.17-rc2

to receive ACPI fixes for 4.17-rc3.

These are two watchdog-related fixes, fix for a backlight regression
from the 4.16 cycle that unfortunately was propagated to -stable and
a button module modification to prevent graphics driver modules from
failing to load due to unmet dependencies if ACPI is disabled from
the kernel command line.

Specifics:

 - Change the ACPI subsystem initialization ordering to initialize
   the WDAT watchodg before reserving PNP motherboard resources so
   as to allow the watchdog to allocate its resources before the PNP
   code gets to them and prevents it from working correctly (Mika
   Westerberg).

 - Add a quirk for Lenovo Z50-70 to use the iTCO watchdog instead of
   the WDAT one which conflicts with the RTC on that platform (Mika
   Westerberg).

 - Avoid breaking backlight handling on Dell XPS 13 2013 model by
   allowing laptops to use the ACPI backlight by default even if they
   are Windows 8-ready in principle (Hans de Goede).

 - Prevent the ACPI button module from failing to load if ACPI is
   disabled via the kernel command line so as to allow graphics
   driver modules depending on the ACPI button module to load in
   that case (Ard Biesheuvel).

Thanks!


---------------

Ard Biesheuvel (1):
      ACPI / button: make module loadable when booted in non-ACPI mode

Hans de Goede (1):
      ACPI / video: Only default only_lcd to true on Win8-ready _desktops_

Mika Westerberg (2):
      ACPI / scan: Initialize watchdog before PNP
      ACPI / watchdog: Prefer iTCO_wdt on Lenovo Z50-70

---------------

 drivers/acpi/acpi_video.c    | 27 ++++++++++++++++++--
 drivers/acpi/acpi_watchdog.c | 59 ++++++++++++++++++++++++++++++++++++--------
 drivers/acpi/button.c        | 24 +++++++++++++++++-
 drivers/acpi/scan.c          |  2 +-
 4 files changed, 98 insertions(+), 14 deletions(-)
