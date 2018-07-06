Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4D3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468EE23C4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468EE23C4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeGFRn2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:43:28 -0400
Received: from complete.lackof.org ([198.49.126.79]:36378 "EHLO
        complete.lackof.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933090AbeGFRn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:43:26 -0400
Received: from localhost (c-73-78-137-212.hsd1.co.comcast.net [73.78.137.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by complete.lackof.org (Postfix) with ESMTPSA id AE66533E006A;
        Fri,  6 Jul 2018 11:43:24 -0600 (MDT)
Date:   Fri, 6 Jul 2018 11:43:24 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yanaijie@huawei.com,
        colin.king@canonical.com, kamal.mostafa@canonical.com,
        ike.pan@canonical.com
Subject: [Bisect] ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt
 inode bitmap
Message-ID: <20180706174324.GA3049@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Virus-Scanned: clamav-milter 0.100.0 at complete.lackof.org
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  We're seeing a regression triggered by the stress-ng[*] "chdir" test
that I've bisected to:

044e6e3d74a3 ext4: don't update checksum of new initialized bitmaps

So far we've only seen failures on servers based on HiSilicon's family
of ARM64 SoCs (D05/Hi1616 SoC, D06/Hi1620 SoC). On these systems it is
very reproducible.

= Test Case =
#!/bin/sh
umount /tmp/mnt || /bin/true
mkdir -p /tmp/mnt
mkfs.ext4 -F /dev/sda1
mount /dev/sda1 /tmp/mnt
# Running directly under /tmp/mnt doesn't trigger the issue, we need
# this subdirectory for some reason
dir="/tmp/mnt/tmp/disk_stress_ng_f70f0f26-b332-4c48-9e07-67c529770e3d"
mkdir -p "$dir"
stress-ng --aggressive --verify --timeout 240 --temp-path "$dir" \
	  --chdir 0 --hdd-opts dsync --readahead-bytes 16M -k

= Result =
[70586.263840] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[70586.637085] EXT4-fs error (device sda1): ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt inode bitmap - block_group = 43936, inode_bitmap = 1439694864
[70602.296551] EXT4-fs error (device sda1): ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt inode bitmap - block_group = 48896, inode_bitmap = 1602224144
[70602.409291] EXT4-fs error (device sda1): ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt inode bitmap - block_group = 48928, inode_bitmap = 1603272720

Full dmesg:
  http://people.canonical.com/~dannf/d05-stress-ng/d05-sas-chdir-4.18.0-rc3+.dmesg

[*] http://kernel.ubuntu.com/~cking/stress-ng/
