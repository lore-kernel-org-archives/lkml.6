Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeCKOhq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 10:37:46 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36427 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeCKOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 10:37:45 -0400
X-Google-Smtp-Source: AG47ELsc1r7wIhV4jNLJaGuofQjYvYNtaUu6FTMz5Jf2YryPj0MK/3kC/3IHU7xlwFdbdx0BFvsuQA==
Subject: Re: [Possible REGRESSION, 4.16-rc4] Error updating SMART data during
 runtime and could not connect to lvmetad at some boot attempts
To: Martin Steigerwald <martin@lichtvoll.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        Tejun Heo <tj@kernel.org>
References: <27165802.vQ9JbjrmvU@merkaba>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <f6e73c8e-1186-744b-c856-2c56ceeeab10@redhat.com>
Date: Sun, 11 Mar 2018 15:37:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <27165802.vQ9JbjrmvU@merkaba>
Content-Type: multipart/mixed;
 boundary="------------A03418BFF6026D45F7B2BB5B"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A03418BFF6026D45F7B2BB5B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 11-03-18 09:20, Martin Steigerwald wrote:
> Hello.
> 
> Since 4.16-rc4 (upgraded from 4.15.2 which worked) I have an issue
> with SMART checks occassionally failing like this:
> 
> smartd[28017]: Device: /dev/sdb [SAT], is in SLEEP mode, suspending checks
> udisksd[24408]: Error performing housekeeping for drive /org/freedesktop/UDisks2/drives/INTEL_SSDSA2CW300G3_[…]: Error updating SMART
> data: Error sending ATA command CHECK POWER MODE: Unexpected sense data returned:#0120000: 0e 09 0c 00  00 00 ff 00  00 00 00 00  00 00 50 00    ..............P.#0120010:
> 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00    ................#012 (g-io-error-quark, 0)
> merkaba udisksd[24408]: Error performing housekeeping for drive /org/freedesktop/UDisks2/drives/Crucial_CT480M500SSD3_[…]: Error updating SMART dat
> a: Error sending ATA command CHECK POWER MODE: Unexpected sense data returned:#0120000: 01 00 1d 00  00 00 0e 09  0c 00 00 00  ff 00 00 00    ................#0120010: 00 0
> 0 00 00  50 00 00 00  00 00 00 00  00 00 00 00    ....P...........#012 (g-io-error-quark, 0)
> 
> (Intel SSD is connected via SATA, Crucial via mSATA in a ThinkPad T520)
> 
> However when I then check manually with smartctl -a | -x | -H the device
> reports SMART data just fine.
> 
> As smartd correctly detects that device is in sleep mode, this may be an
> userspace issue in udisksd.
> 
> Also at some boot attempts the boot hangs with a message like "could not
> connect to lvmetad, scanning manually for devices". I use BTRFS RAID 1
> on to LVs (each on one of the SSDs). A configuration that requires a manual
> adaption to InitRAMFS in order to boot (basically vgchange -ay before
> btrfs device scan).
> 
> I wonder whether that has to do with the new SATA LPM policy stuff, but as
> I had issues with
> 
>   3 => Medium power with Device Initiated PM enabled
> 
> (machine did not boot, which could also have been caused by me accidentally
> removing all TCP/IP network support in the kernel with that setting)
> 
> I set it back to
> 
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> 
> (firmware settings)

Right, so at that settings the LPM policy changes are effectively
disabled and cannot explain your SMART issues.

Still I would like to zoom in on this part of your bug report, because
for Fedora 28 we are planning to ship with CONFIG_SATA_MOBILE_LPM_POLICY=3
and AFAIK Ubuntu has similar plans.

I suspect that the issue you were seeing with CONFIG_SATA_MOBILE_LPM_POLICY=3
were with the Crucial disk ? I've attached a patch for you to test, which
disabled LPM for your model Crucial SSD (but keeps it on for the Intel disk)
if you can confirm that with that patch you can run with
CONFIG_SATA_MOBILE_LPM_POLICY=3 without issues that would be great.

Regards,

Hans

--------------A03418BFF6026D45F7B2BB5B
Content-Type: text/x-patch;
 name="0001-libata-Apply-NOLPM-quirk-to-Crucial-M500-480GB-SSDs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-libata-Apply-NOLPM-quirk-to-Crucial-M500-480GB-SSDs.pat";
 filename*1="ch"

>From 551654d311d91c3cecde233eda86686f5d786fc2 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 11 Mar 2018 15:32:00 +0100
Subject: [PATCH] libata: Apply NOLPM quirk to Crucial M500 480GB SSDs

There have been reports of the Crucial M500 480GB model not working
with LPM set to min_power / med_power_with_dipm level.

It has no been tested with medium_power, but that typically has no
measurable power-savings.

This commit adds a NOLPM quirk to avoid LPM causing issues with these SSDs.

Cc: stable@vger.kernel.org
Reported-by: Martin Steigerwald <martin@lichtvoll.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d8be0fe548f7..197e2c7f560e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4535,6 +4535,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* The 480GB version of the M500 has both queued TRIM and LPM issues */
+	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.14.3


--------------A03418BFF6026D45F7B2BB5B--
