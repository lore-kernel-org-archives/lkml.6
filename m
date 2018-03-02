Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936092AbeCBGmY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 01:42:24 -0500
Received: from magic.merlins.org ([209.81.13.136]:42366 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935880AbeCBGmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 01:42:21 -0500
Date: Thu, 1 Mar 2018 22:22:39 -0800
From: Marc MERLIN <marc@merlins.org>
To: tony.luck@intel.com, Matthew Garrett <mjg59@srcf.ucam.org>,
        "Theodore Ts'o" <tytso@mit.edu>, vstavrinov@gmail.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Deleting pstore data causes immediate hang of 4.15.5 on Lenovo P70 with upgraded bios
Message-ID: <20180302062239.GA17688@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I have a thinkpad P70 which started to fail resuming from S3 sleep after any
kernel past 4.12 (sometimes it would work, sometimes the HD led would come
on when trying to resume, but nothing else).
After much debugging trying to figure what was causing it and coming short,
I decided to upgrade the very old firmware/bios on that laptop, since it likely
had many bugs.

The firmware update from a boot CD was weird, long, and worrisome. It looks
like after 1h or so (very long procedure), I got the latest firmware now,
but it won't boot my NVME M2 drive anymore, it shows in the boot menu, but
just hangs if I use it to boot.
However, I can get it to boot my M2 SATA drive. The nvme drive shows up fine
and works once linux has booted.

So, I figured I'd try a new bootmgr entry
saruman:~# efibootmgr -v -c -d /dev/nvme0n1 -p 1 -L "GrubNVME" -l '\EFI\debian\grubx64.efi'
Could not prepare Boot variable: No space left on device <<<

Ok, this brought me to
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=845023
and
https://mjg59.dreamwidth.org/23554.html

Sure enough,
saruman:~# df /sys/fs/pstore/
Filesystem     1K-blocks  Used Available Use% Mounted on
pstore                 0     0         0    - /sys/fs/pstore
it's full of files, and I'm assuming the variable storage is full of crap
(see below)

The problem is trying to delete any file in there causes an immediate hange of the kernel.

Any idea how to get around this problem?  I realize it may be the bios
that's crashing/hanging and not linux.
At least filling up the space did not brick my machine like Matthew pointing out
some firwmare crashes when it's full ( https://mjg59.dreamwidth.org/23554.html )

Is there any way to clear all this space, maybe from inside the bios by
resetting everything to default, or some other way?

saruman:~# l /sys/fs/pstore/ | wc -l
151
saruman:~# l /sys/fs/pstore/ | head
total 0
drwxr-x---  2 root root    0 Mar  1 22:00 ./
drwxr-xr-x 10 root root    0 Mar  1 22:02 ../
-r--r--r--  1 root root  983 Feb 16  2016 dmesg-efi-145565830401001
-r--r--r--  1 root root 1744 Feb 16  2016 dmesg-efi-145565830401002
-r--r--r--  1 root root  952 Feb 16  2016 dmesg-efi-145565830402001
-r--r--r--  1 root root 1636 Feb 16  2016 dmesg-efi-145565830402002
-r--r--r--  1 root root 1014 Feb 16  2016 dmesg-efi-145565830403001
-r--r--r--  1 root root 1781 Feb 16  2016 dmesg-efi-145565830403002
-r--r--r--  1 root root  351 Feb 16  2016 dmesg-efi-145565830404001
saruman:~# cat /sys/fs/pstore/dmesg-efi-145565830401001
Oops#1 Part1
<4>[ 4508.389437]  [<ffffffff81183ea3>] do_execveat_common.isra.26+0x450/0x5fd
<4>[ 4508.389495]  [<ffffffff81184073>] do_execve+0x23/0x25
<4>[ 4508.389541]  [<ffffffff81184298>] SyS_execve+0x2a/0x2e
<4>[ 4508.389582]  [<ffffffff816e1955>] stub_execve+0x5/0x5
<4>[ 4508.389624]  [<ffffffff816e16b6>] ? entry_SYSCALL_64_fastpath+0x16/0x75
<4>[ 4508.389682] Code: 45 31 e4 48 8b 47 78 4c 8b 30 48 8d 58 f0 48 8d 47 78 48 89 45 d0 49 83 ee 10 48 8d 43 10 48 39 45 d0 74 6f 4c 8b 6b 08 4c 89 e7 <49> 8b 75 00 e8 3a f0 ff ff 49 8d 75 40 48 89 df 49 89 c4 e8 6b
<1>[ 4508.390025] RIP  [<ffffffff8114edf1>] unlink_anon_vmas+0x41/0x13e
<4>[ 4508.390086]  RSP <ffff88070c137c20>
<4>[ 4508.390119] CR2: 00000000000000fb
<7>[ 4508.390339] pci_bus 0000:3b: busn_res: [bus 3b] is released
<7>[ 4508.390468] pci_bus 0000:3c: busn_res: [bus 3c-6f] is released
<7>[ 4508.390605] pci_bus 0000:06: busn_res: [bus 06-6f] is released
<4>[ 4508.470221] ---[ end trace e21f39de184e5ef4 ]---

Yeah, there is another issue that I have something that kept writing here until 
it filled up, and nothing that ever emptied it. I guess my old bios didn't care and the new 
one is having issues with this.
If I'm unlucky, this may even have caused the firmware upgrade to fail partially?

Handle 0x000E, DMI type 0, 24 bytes
BIOS Information
        Vendor: LENOVO
        Version: N1DET95W (2.21 )
        Release Date: 12/13/2017
        Runtime Size: 128 kB
        ROM Size: 16384 kB
        BIOS Revision: 2.21
        Firmware Revision: 1.17

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/
