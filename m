Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbeBQN1A (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 08:27:00 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:32774 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeBQN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 08:26:58 -0500
Date: Sat, 17 Feb 2018 14:25:43 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: tim@krieglstein.org, jarkko.nikula@linux.intel.com,
        andriy.shevchenko@linux.intel.com, preid@electromag.com.au,
        wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: i2c-designware: sound and s2ram broken on Broadwell-U system since
 commit ca382f5b38f367b6 (add i2c gpio recovery option)
Message-ID: <20180217132543.GA21571@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

on v4.16-rc1+, sound does not work any more on my Dell XPS 13;
suspend-to-RAM hangs as well. I have bisected this problem down to
commit ca382f5b38f3; reverting this on top of Linus' latest (1e3510b2b053)
fixes these issues. A bit info on the system (from a working kernel):

00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)

ls -l /sys/devices/pci0000:00/INT3432:00/i2c-0/i2c-INT343A:00 
total 0
lrwxrwxrwx 1 root root    0 Feb 17 14:20 driver -> ../../../../../bus/i2c/drivers/rt286
lrwxrwxrwx 1 root root    0 Feb 17 14:20 firmware_node -> ../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT3432:00/INT343A:00
-r--r--r-- 1 root root 4096 Feb 17 14:20 modalias
-r--r--r-- 1 root root 4096 Feb 17 14:20 name
drwxr-xr-x 2 root root    0 Feb 17 14:19 power
lrwxrwxrwx 1 root root    0 Feb 17 14:10 subsystem -> ../../../../../bus/i2c
-rw-r--r-- 1 root root 4096 Feb 17 14:20 uevent

>From a working dmesg:

	sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
	haswell-pcm-audio haswell-pcm-audio: Direct firmware load for intel/IntcPP01.bin failed with error -2
	haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not available(-2)
	haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
	broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mapping ok
	broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapping ok
	broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapping ok
	broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapping ok
	broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mapping ok
	input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwell-audio/sound/card1/input15

And a few snippets from a broken kernel dmesg:

	i2c_designware: probe of INT3432:00 failed with error -38
	i2c_designware: probe of INT3433:00 failed with error -38
	broadwell-audio broadwell-audio: ASoC: CPU DAI System Pin not registered
	broadwell-audio broadwell-audio: ASoC: CODEC DAI rt286-aif1 not registered
	
Ideas on how to fix this properly?

Thanks,
	Dominik
