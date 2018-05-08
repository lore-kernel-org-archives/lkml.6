Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeEHCcG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:32:06 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35651 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753782AbeEHCcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:32:02 -0400
X-Google-Smtp-Source: AB8JxZrtmczm3mKmee77uP3A+OxhShTEeqFyoxmIdqRbUFQBskac6Y5jDS0AbKiHY1zKEqFN0pg0tQ==
From: Connor McAdams <conmanx360@gmail.com>
Cc: o-takashi@sakamocchi.jp, Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/13] ALSA: hda/ca0132: Patch Series for Recon3Di and Sound Blaster Z Support
Date: Mon,  7 May 2018 22:31:08 -0400
Message-Id: <1525746683-18535-1-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Sound Blaster Z and the Recon3Di.

In order to figure out how to get these cards to work, I made a program called
QemuHDADump[1], which uses the trace function of qemu to see interactions with
the memory mapped pci BAR space of the card being used in the virtual machine.
With this, I obtain the CORB buffer location to get the command verbs, and then
dump them each time the buffer rolls over. This program may be useful for fixing
other HDA related driver issues where there is no documentation for the device.

So far, I have been able to get all features supported on the Sound Blaster Z
and the Recon3Di. All output and input effects work, all inputs and outputs
work, and just about anything else I can think of. I have also added new
controls in order to select the new inputs and outputs, as well as controls to
change the effect levels and presets.

I have also added the ability to use firmware taken from the Windows drivers of
both the Sound Blaster Z and Recon3Di. I am trying to get into contact with
Creative to get permission to redistribute these along with the current
file included with the Chromebook, but they have not been very responsive.
Luckily, the cards work with the Chromebook firmware just fine, although I
believe there has to be a reason they have different firmware in Windows. I
will not link to the firmwares here, but if you look up my thread on Creative
Labs forums, you will find the link to download the firmwares there.

I am willing to help get the other non-working cards such as the ZxR and the
newer AE-5 working too, but I will need someone willing to run QemuHDADump in a
virtual machine in order to get the commands.

So, in summary:
-This patchset makes the cards work better than they did before (they really
 didn't work before)

-This patchset leaves the original chromebook related stuff alone.

Thanks.

[1] https://github.com/Conmanx360/QemuHDADump

Bugs:
-------------------------------------------------------------------------------
Recon3Di: (Reported by Mariusz Ceier)
*******************
-Occasionally switching between rear and front mic breaks the input until
 computer is shutdown or put to sleep.

-Surround Sound works, but is inconsistent. Sometimes, just updating the volume
 fixes it, and sometimes, it requires a restart.

Sound Blaster Z:
*******************
-none that I'm aware of.


Version changes:
-------------------------------------------------------------------------------
v1:
*******************
-Massive patch formatting failure, please ignore v1.

v2:
*******************
-Fixed patch formatting failure.

v3:
*******************
-Fixed mem_base unmap, instead of checking for QUIRK_SBZ on exit, have it check
 if the area is mapped, and if it is, unmap it. Also make it unmap after all
 other commands are finished.

-Change notification of failure to map mem_base from codec_dbg to codec_warn,
 and use codec_info to tell the user that their card might have been incorrectly
 identified as a Sound Blaster Z.

-Remove commented out commands in sbz_exit_chip function, only reintroduce them
 when their functions are defined.

v4:
*******************
-Split patch into smaller pieces.

-Added const to alt_out_presets array.

-Fixed command that was commented out and only put it in when
 it was actually used.


Connor McAdams (13):
  ALSA: hda/ca0132: R3Di and SBZ quirk entires + alt firmware loading
  ALSA: hda/ca0132: Add pincfg for SBZ + R3Di, add fp hp auto-detect
  ALSA: hda/ca0132: Add PCI region2 iomap for SBZ
  ALSA: hda/ca0132: Add extra exit functions for R3Di and SBZ
  ALSA: hda/ca0132: add extra init functions for r3di + sbz
  ALSA: hda/ca0132: update core functions for sbz + r3di
  ALSA: hda/ca0132: add dsp setup related commands for the sbz
  ALSA: hda/ca0132: Add dsp setup + gpio functions for r3di
  ALSA: hda/ca0132: add the ability to set src_id on scp commands
  ALSA: hda/ca0132: add alt_select_in/out for R3Di + SBZ
  ALSA: hda/ca0132: Add DSP Volume set and New mixers for SBZ + R3Di
  ALSA: hda/ca0132: add ca0132_alt_set_vipsource
  ALSA: hda/ca0132: Add new control changes for SBZ + R3Di

 sound/pci/hda/patch_ca0132.c | 3057 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 2941 insertions(+), 116 deletions(-)

-- 
2.7.4
