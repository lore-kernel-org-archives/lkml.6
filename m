Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3551C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B60020871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhiWJr34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B60020871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbeKLJ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:58:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbeKLIRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:32 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D4B22353;
        Sun, 11 Nov 2018 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975257;
        bh=Bg9CvmJmM8wPC5BNn0d2BXZy6/2TlFry+XafXGHchs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhiWJr34p7fa+dvMDgwzwbWP4QTvNEYut/EuL7p1sytwQy+SeFxze49UVtqPSEiE/
         nDc4IlL4ReD9xhNWhmmCla/+yk2N5GPo7D43yhybDI2R3EWVfQqYKXd7ew8cMDd0XW
         xfo4CDQ9VP4kGdK4GEAAUnf4KlfEpPRyf7tvmWLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 131/361] cgroup, netclassid: add a preemption point to write_classid
Date:   Sun, 11 Nov 2018 14:17:58 -0800
Message-Id: <20181111221638.657612508@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

[ Upstream commit a90e90b7d55e789c71d85b946ffb5c1ab2f137ca ]

We have seen a customer complaining about soft lockups on !PREEMPT
kernel config with 4.4 based kernel

[1072141.435366] NMI watchdog: BUG: soft lockup - CPU#21 stuck for 22s! [systemd:1]
[1072141.444090] Modules linked in: mpt3sas raid_class binfmt_misc af_packet 8021q garp mrp stp llc xfs libcrc32c bonding iscsi_ibft iscsi_boot_sysfs msr ext4 crc16 jbd2 mbcache cdc_ether usbnet mii joydev hid_generic usbhid intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel ipmi_ssif mgag200 i2c_algo_bit ttm ipmi_devintf drbg ixgbe drm_kms_helper vxlan ansi_cprng ip6_udp_tunnel drm aesni_intel udp_tunnel aes_x86_64 iTCO_wdt syscopyarea ptp xhci_pci lrw iTCO_vendor_support pps_core gf128mul ehci_pci glue_helper sysfillrect mdio pcspkr sb_edac ablk_helper cryptd ehci_hcd sysimgblt xhci_hcd fb_sys_fops edac_core mei_me lpc_ich ses usbcore enclosure dca mfd_core ipmi_si mei i2c_i801 scsi_transport_sas usb_common ipmi_msghandler shpchp fjes wmi processor button acpi_pad btrfs xor raid6_pq sd_mod crc32c_intel megaraid_sas sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod md_mod autofs4
[1072141.444146] Supported: Yes
[1072141.444149] CPU: 21 PID: 1 Comm: systemd Not tainted 4.4.121-92.80-default #1
[1072141.444150] Hardware name: LENOVO Lenovo System x3650 M5 -[5462P4U]- -[5462P4U]-/01GR451, BIOS -[TCE136H-2.70]- 06/13/2018
[1072141.444151] task: ffff880191bd0040 ti: ffff880191bd4000 task.ti: ffff880191bd4000
[1072141.444153] RIP: 0010:[<ffffffff815229f9>]  [<ffffffff815229f9>] update_classid_sock+0x29/0x40
[1072141.444157] RSP: 0018:ffff880191bd7d58  EFLAGS: 00000286
[1072141.444158] RAX: ffff883b177cb7c0 RBX: 0000000000000000 RCX: 0000000000000000
[1072141.444159] RDX: 00000000000009c7 RSI: ffff880191bd7d5c RDI: ffff8822e29bb200
[1072141.444160] RBP: ffff883a72230980 R08: 0000000000000101 R09: 0000000000000000
[1072141.444161] R10: 0000000000000008 R11: f000000000000000 R12: ffffffff815229d0
[1072141.444162] R13: 0000000000000000 R14: ffff881fd0a47ac0 R15: ffff880191bd7f28
[1072141.444163] FS:  00007f3e2f1eb8c0(0000) GS:ffff882000340000(0000) knlGS:0000000000000000
[1072141.444164] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1072141.444165] CR2: 00007f3e2f200000 CR3: 0000001ffea4e000 CR4: 00000000001606f0
[1072141.444166] Stack:
[1072141.444166]  ffffffa800000246 00000000000009c7 ffffffff8121d583 ffff8818312a05c0
[1072141.444168]  ffff8818312a1100 ffff880197c3b280 ffff881861422858 ffffffffffffffea
[1072141.444170]  ffffffff81522b1c ffffffff81d0ca20 ffff8817fa17b950 ffff883fdd8121e0
[1072141.444171] Call Trace:
[1072141.444179]  [<ffffffff8121d583>] iterate_fd+0x53/0x80
[1072141.444182]  [<ffffffff81522b1c>] write_classid+0x4c/0x80
[1072141.444187]  [<ffffffff8111328b>] cgroup_file_write+0x9b/0x100
[1072141.444193]  [<ffffffff81278bcb>] kernfs_fop_write+0x11b/0x150
[1072141.444198]  [<ffffffff81201566>] __vfs_write+0x26/0x100
[1072141.444201]  [<ffffffff81201bed>] vfs_write+0x9d/0x190
[1072141.444203]  [<ffffffff812028c2>] SyS_write+0x42/0xa0
[1072141.444207]  [<ffffffff815f58c3>] entry_SYSCALL_64_fastpath+0x1e/0xca
[1072141.445490] DWARF2 unwinder stuck at entry_SYSCALL_64_fastpath+0x1e/0xca

If a cgroup has many tasks with many open file descriptors then we would
end up in a large loop without any rescheduling point throught the
operation. Add cond_resched once per task.

Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/netclassid_cgroup.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -106,6 +106,7 @@ static int write_classid(struct cgroup_s
 		iterate_fd(p->files, 0, update_classid_sock,
 			   (void *)(unsigned long)cs->classid);
 		task_unlock(p);
+		cond_resched();
 	}
 	css_task_iter_end(&it);
 


