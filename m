Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395CDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22E22075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22E22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeIFVUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:20:21 -0400
Received: from muru.com ([72.249.23.125]:55362 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbeIFVUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:20:21 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 05A1A806C;
        Thu,  6 Sep 2018 16:48:02 +0000 (UTC)
Date:   Thu, 6 Sep 2018 09:43:58 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Regression in next with filesystem context concept
Message-ID: <20180906164358.GI5659@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like next-20180906 now has a regression where mounting
root won't work with commit fd0002870b45 ("vfs: Implement a
filesystem superblock creation/configuration context").

Here's what happens for me on MMC for example:

Waiting for root device /dev/mmcblk0p2...
mmc0: host does not support reading read-only switch, assuming write-enable
mmc1: new SDIO card at address 0001
mmc0: new high speed SDXC card at address e624
mmcblk0: mmc0:e624 SU64G 59.5 GiB
 mmcblk0: p1 p2 p3
VFS: Cannot open root device "mmcblk0p2" or unknown-block(179,2): error -2
Please append a correct "root=" boot option; here are the available partitions:
...
  b302        60298240 mmcblk0p2 000b9930-02
...
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,2)

And NFSroot fails with:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = (ptrval)
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc1-00104-gfd0002870b45 #867
Hardware name: Generic OMAP4 (Flattened Device Tree)
PC is at nfs_fs_mount+0x4d4/0x9dc
LR is at nfs_fs_mount+0x450/0x9dc
pc : [<c04100c0>]    lr : [<c041003c>]    psr: 60000153
sp : ee8bde10  ip : 00000000  fp : 00000400
r10: 00001000  r9 : 00008001  r8 : 00000000
r7 : eefc7110  r6 : c0d08948  r5 : eefdc000  r4 : eefc7000
r3 : 00000000  r2 : 00000002  r1 : eefc71a0  r0 : eefc710c
Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 8000404a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
...
[<c04100c0>] (nfs_fs_mount) from [<c031c4f0>] (legacy_get_tree+0x2c/0xe4)
[<c031c4f0>] (legacy_get_tree) from [<c02e014c>] (vfs_get_tree+0x70/0x1a0)
[<c02e014c>] (vfs_get_tree) from [<c0305a98>] (do_mount+0x788/0xb18)
[<c0305a98>] (do_mount) from [<c03061e4>] (ksys_mount+0x8c/0xb4)
[<c03061e4>] (ksys_mount) from [<c0c01988>] (mount_root+0x70/0x158)
[<c0c01988>] (mount_root) from [<c0c01bd0>] (prepare_namespace+0x160/0x1c4)
[<c0c01bd0>] (prepare_namespace) from [<c0c012a4>] (kernel_init_freeable+0x444/0x4b4)
[<c0c012a4>] (kernel_init_freeable) from [<c08f0558>] (kernel_init+0x8/0x114)
[<c08f0558>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xee8bdfb0 to 0xee8bdff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e352000a 1a000001 e6bf3fb3 e1c730b2 (e5d83000)

Regards,

Tony
