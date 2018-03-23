Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804169-2-8965807921979367810
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804168; b=cEQ2JQf2kpkBHClFqMcWrCJUy7YTrwJg9WS5tyZqRCSTnbr
    I9e+nS5WGuqYyN0eGvmElB3nRNzAJf2+dMl2pjt9jBd1tx2AFNNVH2OtEV8zcSrh
    2pavUXLRwF9rY9tpNY/Qqu3FtAzetFPD4q7QY+0IdIXrGzLTU140L5KjB+oHetN/
    LT8GUwtH4VmQthtmoUkMvOzdNrlsKTkgmMxXUz2cRntvmezhDi1AjFejL+MZRYmY
    hn4XFVx1oMPVIYYw/CRykxfOsuE0OS3R6P/KIiEgc9xCVMhHvuqgiOr+HDSqHsFS
    bIhNuGOQONEs2bZx601kfuNrVWGZjbIICooS4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804168; bh=Gamv6oFa9cn3jGIUfbw2wr5++C
    21x4UrsSs4hgd3KFw=; b=Q83twZtOxM4YztpNln0Xx+rjOBL/Tz+fgY86WfyvEZ
    UmjdVQq9BSU9919bu7j+W6dj4EwRHs7E/xvyufbEY7rVcbzEMpiK9WOVBpfzw1xR
    fby9Btju/G9/QC7Kgltf9wazFVMSTcFXUVBT5L23Brg7dHTO3d5gNDDuX3lxufFJ
    E3cMfzT+/9uRs+z1Z8gTFB7wSdNePSuCe5XsS/Ss35jGyAJeuiFrVn010HrPWxjo
    FZ2J36BJvX+s8X7YIFsIxTp16jncmtEl6AEhZ8eapmYy9fV7VGu0LN1mq6lKlUbv
    hnEC1cTJbIGwfq/MOCEM1qjrsoaary/zmMkocesTwrVg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755477AbeCWKIK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755128AbeCWKIH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 076/177] Btrfs: fix incorrect space accounting after failure to insert inline extent
Date: Fri, 23 Mar 2018 10:53:24 +0100
Message-Id: <20180323094208.668814409@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>


[ Upstream commit 1c81ba237bcecad9bc885a1ddcf02d725ea38482 ]

When using compression, if we fail to insert an inline extent we
incorrectly end up attempting to free the reserved data space twice,
once through extent_clear_unlock_delalloc(), because we pass it the
flag EXTENT_DO_ACCOUNTING, and once through a direct call to
btrfs_free_reserved_data_space_noquota(). This results in a trace
like the following:

[  834.576240] ------------[ cut here ]------------
[  834.576825] WARNING: CPU: 2 PID: 486 at fs/btrfs/extent-tree.c:4316 btrfs_free_reserved_data_space_noquota+0x60/0x9f [btrfs]
[  834.579501] Modules linked in: btrfs crc32c_generic xor raid6_pq ppdev i2c_piix4 acpi_cpufreq psmouse tpm_tis parport_pc pcspkr serio_raw tpm_tis_core sg parport evdev i2c_core tpm button loop autofs4 ext4 crc16 jbd2 mbcache sr_mod cdrom sd_mod ata_generic virtio_scsi ata_piix virtio_pci libata virtio_ring virtio scsi_mod e1000 floppy [last unloaded: btrfs]
[  834.592116] CPU: 2 PID: 486 Comm: kworker/u32:4 Not tainted 4.10.0-rc8-btrfs-next-37+ #2
[  834.593316] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.1-0-gb3ef39f-prebuilt.qemu-project.org 04/01/2014
[  834.595273] Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
[  834.596103] Call Trace:
[  834.596103]  dump_stack+0x67/0x90
[  834.596103]  __warn+0xc2/0xdd
[  834.596103]  warn_slowpath_null+0x1d/0x1f
[  834.596103]  btrfs_free_reserved_data_space_noquota+0x60/0x9f [btrfs]
[  834.596103]  compress_file_range.constprop.42+0x2fa/0x3fc [btrfs]
[  834.596103]  ? submit_compressed_extents+0x3a7/0x3a7 [btrfs]
[  834.596103]  async_cow_start+0x32/0x4d [btrfs]
[  834.596103]  btrfs_scrubparity_helper+0x187/0x3e7 [btrfs]
[  834.596103]  btrfs_delalloc_helper+0xe/0x10 [btrfs]
[  834.596103]  process_one_work+0x273/0x4e4
[  834.596103]  worker_thread+0x1eb/0x2ca
[  834.596103]  ? rescuer_thread+0x2b6/0x2b6
[  834.596103]  kthread+0x100/0x108
[  834.596103]  ? __list_del_entry+0x22/0x22
[  834.596103]  ret_from_fork+0x2e/0x40
[  834.611656] ---[ end trace 719902fe6bdef08f ]---

So fix this by not calling directly btrfs_free_reserved_data_space_noquota()
if an error happened.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -567,8 +567,10 @@ cont:
 						     PAGE_SET_WRITEBACK |
 						     page_error_op |
 						     PAGE_END_WRITEBACK);
-			btrfs_free_reserved_data_space_noquota(inode, start,
-						end - start + 1);
+			if (ret == 0)
+				btrfs_free_reserved_data_space_noquota(inode,
+							       start,
+							       end - start + 1);
 			goto free_pages_out;
 		}
 	}
