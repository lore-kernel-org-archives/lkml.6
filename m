Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163B5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7F121508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbxg+EYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7F121508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390162AbeKLIV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390135AbeKLIV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:57 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8EE21508;
        Sun, 11 Nov 2018 22:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975520;
        bh=StGgLnDWE4qwzi75+4+MAykune2hoY9/tl1zY1ahMD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bbxg+EYDW9Pjx3okrdrA0kPDtyGeVwH9toodYnHKd/3g0L+MXG46zce/ZfbX5giAq
         ubKmMQLxdRVVza2X+h9W9AU0RrsETRXccsqB2MjzmLrEoucOsH2QoTa69oc1Xm+JQz
         f7snZYfO5lbEl3g4nEVahjJcnqxg4320koydcXOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Glauber <jglauber@cavium.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.14 010/222] ipmi: Fix timer race with module unload
Date:   Sun, 11 Nov 2018 14:21:47 -0800
Message-Id: <20181111221648.884675656@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Glauber <jglauber@cavium.com>

commit 0711e8c1b4572d076264e71b0002d223f2666ed7 upstream.

Please note that below oops is from an older kernel, but the same
race seems to be present in the upstream kernel too.

---8<---

The following panic was encountered during removing the ipmi_ssif
module:

[ 526.352555] Unable to handle kernel paging request at virtual address ffff000006923090
[ 526.360464] Mem abort info:
[ 526.363257] ESR = 0x86000007
[ 526.366304] Exception class = IABT (current EL), IL = 32 bits
[ 526.372221] SET = 0, FnV = 0
[ 526.375269] EA = 0, S1PTW = 0
[ 526.378405] swapper pgtable: 4k pages, 48-bit VAs, pgd = 000000008ae60416
[ 526.385185] [ffff000006923090] *pgd=000000bffcffe803, *pud=000000bffcffd803, *pmd=0000009f4731a003, *pte=0000000000000000
[ 526.396141] Internal error: Oops: 86000007 [#1] SMP
[ 526.401008] Modules linked in: nls_iso8859_1 ipmi_devintf joydev input_leds ipmi_msghandler shpchp sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear i2c_smbus hid_generic usbhid uas hid usb_storage ast aes_ce_blk i2c_algo_bit aes_ce_cipher qede ttm crc32_ce ptp crct10dif_ce drm_kms_helper ghash_ce syscopyarea sha2_ce sysfillrect sysimgblt pps_core fb_sys_fops sha256_arm64 sha1_ce mpt3sas qed drm raid_class ahci scsi_transport_sas libahci gpio_xlp i2c_xlp9xx aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64 [last unloaded: ipmi_ssif]
[ 526.468085] CPU: 125 PID: 0 Comm: swapper/125 Not tainted 4.15.0-35-generic #38~lp1775396+build.1
[ 526.476942] Hardware name: To be filled by O.E.M. Saber/Saber, BIOS 0ACKL022 08/14/2018
[ 526.484932] pstate: 00400009 (nzcv daif +PAN -UAO)
[ 526.489713] pc : 0xffff000006923090
[ 526.493198] lr : call_timer_fn+0x34/0x178
[ 526.497194] sp : ffff000009b0bdd0
[ 526.500496] x29: ffff000009b0bdd0 x28: 0000000000000082
[ 526.505796] x27: 0000000000000002 x26: ffff000009515188
[ 526.511096] x25: ffff000009515180 x24: ffff0000090f1018
[ 526.516396] x23: ffff000009519660 x22: dead000000000200
[ 526.521696] x21: ffff000006923090 x20: 0000000000000100
[ 526.526995] x19: ffff809eeb466a40 x18: 0000000000000000
[ 526.532295] x17: 000000000000000e x16: 0000000000000007
[ 526.537594] x15: 0000000000000000 x14: 071c71c71c71c71c
[ 526.542894] x13: 0000000000000000 x12: 0000000000000000
[ 526.548193] x11: 0000000000000001 x10: ffff000009b0be88
[ 526.553493] x9 : 0000000000000000 x8 : 0000000000000005
[ 526.558793] x7 : ffff80befc1f8528 x6 : 0000000000000020
[ 526.564092] x5 : 0000000000000040 x4 : 0000000020001b20
[ 526.569392] x3 : 0000000000000000 x2 : ffff809eeb466a40
[ 526.574692] x1 : ffff000006923090 x0 : ffff809eeb466a40
[ 526.579992] Process swapper/125 (pid: 0, stack limit = 0x000000002eb50acc)
[ 526.586854] Call trace:
[ 526.589289] 0xffff000006923090
[ 526.592419] expire_timers+0xc8/0x130
[ 526.596070] run_timer_softirq+0xec/0x1b0
[ 526.600070] __do_softirq+0x134/0x328
[ 526.603726] irq_exit+0xc8/0xe0
[ 526.606857] __handle_domain_irq+0x6c/0xc0
[ 526.610941] gic_handle_irq+0x84/0x188
[ 526.614679] el1_irq+0xe8/0x180
[ 526.617822] cpuidle_enter_state+0xa0/0x328
[ 526.621993] cpuidle_enter+0x34/0x48
[ 526.625564] call_cpuidle+0x44/0x70
[ 526.629040] do_idle+0x1b8/0x1f0
[ 526.632256] cpu_startup_entry+0x2c/0x30
[ 526.636174] secondary_start_kernel+0x11c/0x130
[ 526.640694] Code: bad PC value
[ 526.643800] ---[ end trace d020b0b8417c2498 ]---
[ 526.648404] Kernel panic - not syncing: Fatal exception in interrupt
[ 526.654778] SMP: stopping secondary CPUs
[ 526.658734] Kernel Offset: disabled
[ 526.662211] CPU features: 0x5800c38
[ 526.665688] Memory Limit: none
[ 526.668768] ---[ end Kernel panic - not syncing: Fatal exception in interrupt

Prevent mod_timer from arming a timer that was already removed by
del_timer during module unload.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Cc: <stable@vger.kernel.org> # 3.19
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_ssif.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -621,8 +621,9 @@ static void msg_done_handler(struct ssif
 			flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
 			ssif_info->waiting_alert = true;
 			ssif_info->rtc_us_timer = SSIF_MSG_USEC;
-			mod_timer(&ssif_info->retry_timer,
-				  jiffies + SSIF_MSG_JIFFIES);
+			if (!ssif_info->stopping)
+				mod_timer(&ssif_info->retry_timer,
+					  jiffies + SSIF_MSG_JIFFIES);
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			return;
 		}
@@ -954,8 +955,9 @@ static void msg_written_handler(struct s
 			ssif_info->waiting_alert = true;
 			ssif_info->retries_left = SSIF_RECV_RETRIES;
 			ssif_info->rtc_us_timer = SSIF_MSG_PART_USEC;
-			mod_timer(&ssif_info->retry_timer,
-				  jiffies + SSIF_MSG_PART_JIFFIES);
+			if (!ssif_info->stopping)
+				mod_timer(&ssif_info->retry_timer,
+					  jiffies + SSIF_MSG_PART_JIFFIES);
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 		}
 	}


