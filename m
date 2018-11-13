Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED25C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADF722419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADF722419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeKND22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:28:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:55262 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbeKND21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:28:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="104051732"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 13 Nov 2018 09:29:21 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gMcV6-0001dc-Ho; Tue, 13 Nov 2018 19:29:20 +0200
Date:   Tue, 13 Nov 2018 19:29:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qian Cai <cai@gmx.us>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: WARNING: CPU: 26 PID: 64391 at lib/vsprintf.c:2193
 set_precision+0x84/0x90
Message-ID: <20181113172920.GI10650@smile.fi.intel.com>
References: <1542128132.12945.19.camel@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542128132.12945.19.camel@gmx.us>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:55:32AM -0500, Qian Cai wrote:

+Cc Rasmus

> Running the trinity fuzzer with a non-root user on an aarch64 server with the
> latest mainline (rc2) generated this. Is it just a false alarm to ignore?
> 
> [  807.847370] precision 65525 too large

It seems like someone uses -EAGAIN as a parameter to printf().

Or rather this line

  if (!fs && (request_module("fs-%.*s", len, name) == 0)) {
	  ...
  }

Care to print the len and name parameters before this line?


> [  807.847449] WARNING: CPU: 26 PID: 64391 at lib/vsprintf.c:2193
> set_precision+0x84/0x90
> [  807.860161] Modules linked in: cast6_generic cast_common lrw bridge 8021q
> garp mrp stp llc dlci tcp_diag inet_diag af_key pptp gre l2tp_ppp l2tp_netlink
> l2tp_core ip6_udp_tunnel udp_tunnel pppoe pppox ppp_generic slhc crypto_user
> ib_core nfnetlink scsi_transport_iscsi atm sctp vfat fat ghash_ce sha2_ce
> sha256_arm64 sha1_ce ses enclosure ipmi_ssif sg ipmi_si ipmi_devintf sbsa_gwdt
> ipmi_msghandler sch_fq_codel xfs libcrc32c marvell mpt3sas mlx5_core raid_class
> hibmc_drm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm
> ixgbe hisi_sas_v2_hw igb hisi_sas_main libsas hns_dsaf mlxfw devlink
> hns_enet_drv mdio i2c_designware_platform i2c_algo_bit i2c_designware_core
> ehci_platform scsi_transport_sas hns_mdio hnae dm_mirror dm_region_hash dm_log
> dm_mod
> [  807.927838] CPU: 26 PID: 64391 Comm: trinity-c90 Kdump: loaded Tainted:
> G        W         4.20.0-rc2+ #16
> [  807.937494] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50
> 06/01/2018
> [  807.944718] pstate: 60000005 (nZCv daif -PAN -UAO)
> [  807.949515] pc : set_precision+0x84/0x90
> [  807.953439] lr : set_precision+0x84/0x90
> [  807.957362] sp : ffff801e6430f6b0
> [  807.960677] x29: ffff801e6430f6b0 x28: ffff801e6430fb10 
> [  807.965992] x27: 0000000000000003 x26: 00000000ffffffd8 
> [  807.971307] x25: ffff801e6430fba0 x24: ffff801e6430fb48 
> [  807.976622] x23: ffff2000093ddfa0 x22: ffff801e6430f770 
> [  807.981937] x21: ffff2000090eb4a6 x20: ffff801e6430f770 
> [  807.987252] x19: 000000000000fff5 x18: 0000000000000000 
> [  807.992569] x17: 0000000000000000 x16: 0000000000000000 
> [  807.997884] x15: 0000000000000000 x14: 3878302031343220 
> [  808.003201] x13: 6265783020303939 x12: ffff04000172b49c 
> [  808.008516] x11: 1fffe4000172b49b x10: ffff04000172b49b 
> [  808.013832] x9 : 0000000000000000 x8 : 203532353536206e 
> [  808.019148] x7 : 6f69736963657270 x6 : 0000000041b58ab3 
> [  808.024463] x5 : dfff200000000000 x4 : dfff200000000000 
> [  808.029779] x3 : dfff200000000000 x2 : 65a2459128144800 
> [  808.035093] x1 : 65a2459128144800 x0 : 0000000000000000 
> [  808.040408] Call trace:
> [  808.042861]  set_precision+0x84/0x90
> [  808.046440]  vsnprintf+0x23c/0x858
> [  808.049845]  __request_module+0x1a0/0x8b8
> [  808.053860]  get_fs_type+0xb0/0x138
> [  808.057351]  do_mount+0x2c4/0x13c0
> [  808.060756]  ksys_mount+0xf4/0x110
> [  808.064160]  __arm64_sys_mount+0x70/0x88
> [  808.068087]  el0_svc_handler+0xd4/0x198
> [  808.071928]  el0_svc+0x8/0xc
> [  808.074810] irq event stamp: 347872
> [  808.078305] hardirqs last  enabled at (347871): [<ffff2000082080e8>]
> vprintk_emit+0x2b0/0x5c0
> [  808.086833] hardirqs last disabled at (347872): [<ffff200008081490>]
> do_debug_exception+0xd8/0x190
> [  808.095795] softirqs last  enabled at (347844): [<ffff200008082210>]
> __do_softirq+0x7c8/0x9c8
> [  808.104325] softirqs last disabled at (347837): [<ffff20000812dbe4>]
> irq_exit+0x25c/0x2f0
> [  808.112502] ---[ end trace 598902d30712b79e ]---

-- 
With Best Regards,
Andy Shevchenko


