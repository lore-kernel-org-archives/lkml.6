Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60888C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E1C204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E1C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeK1Ldu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:33:50 -0500
Received: from [195.159.176.226] ([195.159.176.226]:59945 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1Ldt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:33:49 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1gRnlk-00070z-1K
        for linux-kernel@vger.kernel.org; Wed, 28 Nov 2018 01:31:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   "Andrey Jr. Melnikov" <temnota.am@gmail.com>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
Date:   Wed, 28 Nov 2018 03:16:33 +0300
Message-ID: <vb31df-25g.ln1@banana.localnet>
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net> <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net>
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.2.1-20140504 ("Tober an Righ") (UNIX) (Linux/4.3.3-bananian (armv7l))
Cc:     linux-ext4@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.comp.file-systems.ext4 Guenter Roeck <linux@roeck-us.net> wrote:
> [trying again, this time with correct kernel.org address]

> Hi,

> I have seen the following and similar problems several times,
> with both v4.19.3 and v4.19.4:

> Nov 23 04:32:25 mars kernel: [112668.673671] EXT4-fs error (device sdb1): ext4_iget:4831: inode #12602889: comm git: bad extra_isize 33661 (inode size 256)
> Nov 23 04:32:25 mars kernel: [112668.675217] Aborting journal on device sdb1-8.
> Nov 23 04:32:25 mars kernel: [112668.676681] EXT4-fs (sdb1): Remounting filesystem read-only
> Nov 23 04:32:25 mars kernel: [112668.808886] EXT4-fs error (device sdb1): ext4_iget:4831: inode #12602881: comm rm: bad extra_isize 33685 (inode size 256)
> ...

> Nov 25 00:12:43 saturn kernel: [59377.725984] EXT4-fs error (device sda1): ext4_lookup:1578: inode #238034131: comm updatedb.mlocat: deleted inode referenced: 238160407
> Nov 25 00:12:43 saturn kernel: [59377.766638] Aborting journal on device sda1-8.
> Nov 25 00:12:43 saturn kernel: [59377.779372] EXT4-fs (sda1): Remounting filesystem read-only
> ...

> Nov 24 01:52:31 saturn kernel: [189085.240016] EXT4-fs error (device sda1): ext4_lookup:1578: inode #52038457: comm nfsd: deleted inode referenced: 52043796
> Nov 24 01:52:31 saturn kernel: [189085.263427] Aborting journal on device sda1-8.
> Nov 24 01:52:31 saturn kernel: [189085.275313] EXT4-fs (sda1): Remounting filesystem read-only


> The same systems running v4.18.6 never experienced a problem.

> Has anyone else seen similar problems ? Is there anything I can do
> to help tracking down the problem ?

I see this problem on 4.19.1, 4.19.2 & 4.19.5 (4.19.3 & 4.19.4 - skipped).

kernel always report:
ext4_iget:4851: inode #XXXXXXX: comm updatedb.mlocat: checksum invalid

/dev/sde2 mounted as ext4 with relatime,errors=remount-ro options.

last one (from 4.19.5):
[  355.926146] EXT4-fs error (device sde2): ext4_iget:4851: inode #63184919: comm updatedb.mlocat: checksum invalid
[  355.966810] EXT4-fs (sde2): Remounting filesystem read-only
[  355.987887] EXT4-fs error (device sde2): ext4_journal_check_start:61: Detected aborted journal

# debugfs -n /dev/sde2
debugfs 1.44.4 (18-Aug-2018)
debugfs:  ncheck 63184919
Inode   Pathname
63184919        /home/lynxchaus/openwrt/lede/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7621/linux-4.15/drivers/gpu
debugfs:  ls /home/lynxchaus/openwrt/lede/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7621/linux-4.15/drivers/gpu

/home/lynxchaus/openwrt/lede/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7621/linux-4.15/drivers/gpu: Ext2 inode is not a directory
debugfs:  stat /home/lynxchaus/openwrt/lede/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7621/linux-4.15/drivers/gpu
Inode: 63184919   Type: regular    Mode:  0644   Flags: 0x80000
Generation: 1951786937    Version: 0x00000000:00000001
User:  1000   Group:  1000   Project:     0   Size: 6013
File ACL: 0
Links: 1   Blockcount: 16
Fragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x59bfa71f:bee151ac -- Mon Sep 18 13:59:43 2017
 atime: 0x59bfa71f:bee151ac -- Mon Sep 18 13:59:43 2017
 mtime: 0x59b9a16d:00000000 -- Thu Sep 14 00:21:49 2017
crtime: 0x59bfa71f:bee151ac -- Mon Sep 18 13:59:43 2017
Size of extra inode fields: 32
Inode checksum: 0x39c8526f
EXTENTS:  
(0-1):214480636-214480637

After repair /home/lynxchaus/openwrt/lede/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7621/linux-4.15/drivers/gpu deleted,
all files in it - connected to lost+found.

Corrupted inodes - always directory, not touched at least year or more for writing. Something wrong when updating atime?

