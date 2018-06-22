Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F53224758
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="VCvqxGrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F53224758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934239AbeFVSmu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:42:50 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:44707 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934123AbeFVSms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:
        To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bh2/jXyOAqJc3ydMAiwgwSl3KvOPgwsmFXm5jEywT5c=; b=VCvqxGrRwpCCuSZ4aKdi0HxygL
        FMrDJknWpECEjheN8TVNC/wqsjzGFHqHS7fqG3hTdE6+D+F33G+MIMdwqWzHt1A/hq8Txhvk2fC0Q
        NAH5P9AJH3oexpUQ1gtTFUMc6fduVFDx9VvhXMfAX1/l0zW5Jl5CIdsYunqHmwSHbAchu1ccIQPee
        2ucKdKei3gR3dEz6x4+KjDOznqSMbAQhIHUdEXKQOQm+8IKbxC16wucZw0Ndio0gOgY/Ssuzgx4Qm
        SkBw5BNku/s/1bE6bYxWLADLfXr9nrGAUCPixo4DobYT+zleR6D9A+SHMokzj4NviikFbdNf54O0a
        kG5s5K7w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43910 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fWR1D-009eCa-2y; Fri, 22 Jun 2018 18:42:47 +0000
Date:   Fri, 22 Jun 2018 11:42:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: m68k boot failure in -next bisected to 'xarray: Replace exceptional
 entries'
Message-ID: <20180622184246.GA21226@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a few days ago, m68k boot tests in linux-next started to crash.
I bisected the problem to commit 'xarray: Replace exceptional entries'.
Bisect and crash logs are attached below.

My apologies for the noise if this has already been reported and/or
addressed.

Guenter

---
# bad: [2e6381681ec48ed6dd455473a657d8a393518aa6] Add linux-next specific files for 20180622
# good: [ce397d215ccd07b8ae3f71db689aedb85d56ab40] Linux 4.18-rc1
git bisect start 'HEAD' 'v4.18-rc1'
# good: [07b762f7baf30aaa93d35f36ff367d4b36632059] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect good 07b762f7baf30aaa93d35f36ff367d4b36632059
# good: [c61d3dfe9381fc4b72541fd7698951b290d2a776] Merge remote-tracking branch 'tip/auto-latest'
git bisect good c61d3dfe9381fc4b72541fd7698951b290d2a776
# good: [a92ae111eb9e0f6f05f1173cf91c20fccda1a833] Merge remote-tracking branch 'scsi-mkp/for-next'
git bisect good a92ae111eb9e0f6f05f1173cf91c20fccda1a833
# bad: [1aa90eab1a14860f0d128ad67edf7b0381fa44e8] Merge remote-tracking branch 'xarray/xarray'
git bisect bad 1aa90eab1a14860f0d128ad67edf7b0381fa44e8
# good: [22ca6bc3dfd805a53f303fa5362fcc19e9c52565] Merge remote-tracking branch 'nvdimm/libnvdimm-for-next'
git bisect good 22ca6bc3dfd805a53f303fa5362fcc19e9c52565
# bad: [932116ce98f3d2ddf3e9eb243eebd62ebddebee9] mm: Convert page migration to XArray
git bisect bad 932116ce98f3d2ddf3e9eb243eebd62ebddebee9
# bad: [68fd9dcd423f49c4c916c0f222f12193f0c1655d] page cache: Rearrange address_space
git bisect bad 68fd9dcd423f49c4c916c0f222f12193f0c1655d
# bad: [8c0feb14b49670ea363ccef3f42165df64a5852e] xarray: Add XArray tags
git bisect bad 8c0feb14b49670ea363ccef3f42165df64a5852e
# bad: [88f2e731264b03319b9d0475ceadd0cc1d1dcefb] xarray: Change definition of sibling entries
git bisect bad 88f2e731264b03319b9d0475ceadd0cc1d1dcefb
# good: [0826cef09f48e767ad7416d1047fe4726addc49d] radix tree test suite: Enable ubsan
git bisect good 0826cef09f48e767ad7416d1047fe4726addc49d
# bad: [087ba81049d32c762831ae58de0b00fd6467ee8e] xarray: Replace exceptional entries
git bisect bad 087ba81049d32c762831ae58de0b00fd6467ee8e
# good: [8255ddef2101b02a1dc63461121903e25ed82873] dax: Fix use of zero page
git bisect good 8255ddef2101b02a1dc63461121903e25ed82873
# first bad commit: [087ba81049d32c762831ae58de0b00fd6467ee8e] xarray: Replace exceptional entries

---
...
SCSI subsystem initialized
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at lib/idr.c:42 idr_alloc_u32+0x44/0xe8
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc1-next-20180622-mac #1
Stack from 0781fe3c:
        0781fe3c 0036d51c 000180d6 ffffffea 00000000 0036dfe6 00000020 000020e8
        003abf1c 0036dfe6 0001816a 0036d51f 0000002a 002b50e4 00000009 00000000
        00000000 00340ae9 002b50e4 0036d51f 0000002a 00000010 0036dfee 00000000
        00000010 0036dfe6 003f7518 0781feb8 00000000 00000078 002f7f6a 002b51e4
        003abf1c 0036dfe6 0781fed4 00000010 006000c0 07800100 00000010 0781ff8c
        00247160 003abf1c 0036dfe6 00000010 00000011 006000c0 00000078 00000005
Call Trace: [<000180d6>] __warn+0xc0/0xc2
 [<000020e8>] do_one_initcall+0x0/0x140
 [<0001816a>] warn_slowpath_null+0x26/0x2c
 [<002b50e4>] idr_alloc_u32+0x44/0xe8
 [<002b50e4>] idr_alloc_u32+0x44/0xe8
 [<002b51e4>] idr_alloc+0x5c/0x76
 [<00247160>] genl_register_family+0x14c/0x54c
 [<000020e8>] do_one_initcall+0x0/0x140
 [<003f0f02>] genl_init+0x0/0x34
 [<003f0ce6>] bpf_lwt_init+0x10/0x14
 [<003f0f0e>] genl_init+0xc/0x34
 [<00002142>] do_one_initcall+0x5a/0x140
 [<00029828>] parse_args+0x0/0x202
 [<000020e8>] do_one_initcall+0x0/0x140
 [<002bf6c4>] strcpy+0x0/0x1c
 [<00040004>] timekeeping_resume+0x280/0x2cc
 [<003df1e6>] kernel_init_freeable+0x176/0x190
 [<002bf6c4>] strcpy+0x0/0x1c
 [<003df1fc>] kernel_init_freeable+0x18c/0x190
 [<003f0f02>] genl_init+0x0/0x34
 [<002c4b66>] kernel_init+0x0/0xd2
 [<002c4b6e>] kernel_init+0x8/0xd2
 [<002c4b66>] kernel_init+0x0/0xd2
 [<000028e0>] ret_from_kernel_thread+0xc/0x14
---[ end trace 62c263e59debfdfe ]---
Kernel panic - not syncing: GENL: Cannot register controller: -22

CPU: 0 PID: 1 Comm: swapper Tainted: G        W         4.18.0-rc1-next-20180622-mac #1
Stack from 0781fef0:
        0781fef0 0036d51c 00018216 00000078 00000005 0055a040 00000000 003f0f02
        003ff868 003f7518 0781ff8c 003f0f34 0036849f ffffffea 00002142 00000078
        00000005 0055a040 00029828 000020e8 00000000 003f7538 003ff868 00000000
        003f7534 00000004 003f7518 002bf6c4 00040004 0055a052 0055a05a 003df1e6
        0033e814 0055a040 0038fd64 00000078 00000004 00000004 00000000 002bf6c4
        003df1fc 003f0f02 00000000 0781774c 0000000f 00000000 00000000 002c4b66
Call Trace: [<00018216>] panic+0xa6/0x230
 [<003f0f02>] genl_init+0x0/0x34
 [<003f0f34>] genl_init+0x32/0x34
 [<00002142>] do_one_initcall+0x5a/0x140
 [<00029828>] parse_args+0x0/0x202
 [<000020e8>] do_one_initcall+0x0/0x140
 [<002bf6c4>] strcpy+0x0/0x1c
 [<00040004>] timekeeping_resume+0x280/0x2cc
 [<003df1e6>] kernel_init_freeable+0x176/0x190
 [<002bf6c4>] strcpy+0x0/0x1c
 [<003df1fc>] kernel_init_freeable+0x18c/0x190
 [<003f0f02>] genl_init+0x0/0x34
 [<002c4b66>] kernel_init+0x0/0xd2
 [<002c4b6e>] kernel_init+0x8/0xd2
 [<002c4b66>] kernel_init+0x0/0xd2
 [<000028e0>] ret_from_kernel_thread+0xc/0x14
---[ end Kernel panic - not syncing: GENL: Cannot register controller: -22
