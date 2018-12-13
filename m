Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E73C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD45E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD45E20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeLMRpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:45:55 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:34694 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeLMRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:45:54 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43G1LP32ylz1r9LD;
        Thu, 13 Dec 2018 18:45:49 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43G1LP2529z1qvQt;
        Thu, 13 Dec 2018 18:45:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id tz1bGk9-6xsn; Thu, 13 Dec 2018 18:45:48 +0100 (CET)
X-Auth-Info: rH1x615J8EdNs/cuTp62CN+Re3hMvKNMzSkCPOoUjYsRG9QviAXJ/AnESQ9aj92Q
Received: from igel.home (ppp-188-174-144-171.dynamic.mnet-online.de [188.174.144.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 13 Dec 2018 18:45:48 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 7E48D2C0DD0; Thu, 13 Dec 2018 18:45:47 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     rppt@linux.ibm.com, Michael Schmitz <schmitzmic@gmail.com>,
        Sam Creasey <sammy@sammy.net>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] m68k: Fix memblock-related crashes
References: <20181207165011.31497-1-geert@linux-m68k.org>
        <CAMuHMdXj67QnqeMHGr_TiEaJr6gUw5qzWFvaJvoVkm89Kiuq_Q@mail.gmail.com>
X-Yow:  I OWN six pink HIPPOS!!
Date:   Thu, 13 Dec 2018 18:45:47 +0100
In-Reply-To: <CAMuHMdXj67QnqeMHGr_TiEaJr6gUw5qzWFvaJvoVkm89Kiuq_Q@mail.gmail.com>
        (Geert Uytterhoeven's message of "Wed, 12 Dec 2018 15:58:42 +0100")
Message-ID: <87o99pmib8.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm now getting this Oops:

[   65.390000] Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
[   65.390000] Oops: 00000000
[   65.390000] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat virtio_rng virtio_blk virtio_ring virtio xfs btrfs xor zlib_deflate raid6_pq libcrc32c reiserfs squashfs fuse dm_snapshot dm_bufio dm_mod binfmt_misc loop sg
[   65.390000] PC: [<00211544>] blk_throtl_bio+0x10e/0x592
[   65.390000] SR: 2700  SP: (ptrval)  a2: bf506dc0
[   65.390000] d0: 00000001    d1: 03ce63fb    d2: 00000000    d3: 00000016
[   65.390000] d4: ffffa45b    d5: 00000000    a0: 00000000    a1: 00000000
[   65.390000] Process mkswap (pid: 289, task=(ptrval))
[   65.390000] Frame format=7 eff addr=00000060 ssw=0505 faddr=00000060
[   65.390000] wb 1 stat/addr/data: 0000 00000000 00000000
[   65.390000] wb 2 stat/addr/data: 0000 00000000 00000000
[   65.390000] wb 3 stat/addr/data: 0000 00000060 0001dba1
[   65.390000] push data: 00000000 00000000 00000000 00000000
[   65.390000] Stack from bd1b7bdc:
[   65.390000]         00000008 00080000 ffffffff 00000002 ffffffff 00000006 bd6e0b40 bf596c18
[   65.390000]         00682988 bd1b7c78 006000c0 00000003 00000000 00000080 00000005 001f28e4
[   65.390000]         bf596c18 bf4f1800 bd6e0b40 00000008 00080000 00000000 00001000 000a1848
[   65.390000]         00000001 bd6e0b40 bf596c18 bd1b7e24 00080000 00000008 bf4f1800 bf596c18
[   65.390000]         bd1b7e24 bd1b7cec 00000001 bd1b7d3a 00095c52 0010ce96 000a1848 bd1b7cec
[   65.390000]         001f3ea8 bd6e0b40 00000008 00080000 00000000 bd6e0b40 027616cc bd1b7e24
[   65.390000] Call Trace: [<00080000>] check_ids+0x8/0x64
[   65.390000]  [<001f28e4>] generic_make_request_checks+0x3ca/0x4ee
[   65.390000]  [<00080000>] check_ids+0x8/0x64
[   65.390000]  [<00001000>] kernel_pg_dir+0x0/0x1000
[   65.390000]  [<000a1848>] __put_page+0x0/0x32
[   65.390000]  [<00080000>] check_ids+0x8/0x64
[   65.390000]  [<00095c52>] add_to_page_cache_lru+0x0/0xc4
[   65.390000]  [<0010ce96>] do_mpage_readpage+0x0/0x5cc
[   65.390000]  [<000a1848>] __put_page+0x0/0x32
[   65.390000]  [<001f3ea8>] generic_make_request+0x32/0x23c
[   65.390000]  [<00080000>] check_ids+0x8/0x64
[   65.390000]  [<001f417c>] submit_bio+0xca/0xfc
[   65.390000]  [<00095c52>] add_to_page_cache_lru+0x0/0xc4
[   65.390000]  [<0010ce96>] do_mpage_readpage+0x0/0x5cc
[   65.390000]  [<00095c52>] add_to_page_cache_lru+0x0/0xc4
[   65.390000]  [<0010ce96>] do_mpage_readpage+0x0/0x5cc
[   65.390000]  [<000a1848>] __put_page+0x0/0x32
[   65.390000]  [<0010ce8a>] mpage_bio_submit+0x2e/0x3a
[   65.390000]  [<0010d55a>] mpage_readpages+0xf8/0x108
[   65.390000]  [<00080000>] check_ids+0x8/0x64
[   65.390000]  [<00433256>] radix_tree_lookup+0x0/0x1a
[   65.390000]  [<0000bd6e>] rtc_ioctl+0x10c/0x2ae
[   65.390000]  [<00010100>] sixty_four+0x2/0x10
[   65.390000]  [<00001000>] kernel_pg_dir+0x0/0x1000
[   65.390000]  [<00107370>] blkdev_get_block+0x0/0x30
[   65.390000]  [<000a0eb4>] read_pages+0x3c/0xe6
[   65.390000]  [<00107370>] blkdev_get_block+0x0/0x30
[   65.390000]  [<0003ffff>] _sched_setscheduler+0x47/0x7e
[   65.390000]  [<00433256>] radix_tree_lookup+0x0/0x1a
[   65.390000]  [<0009cd42>] __alloc_pages_nodemask+0x0/0x86a
[   65.390000]  [<000a1188>] __do_page_cache_readahead+0x92/0x13e
[   65.390000]  [<000a10f6>] __do_page_cache_readahead+0x0/0x13e
[   65.390000]  [<000a1558>] force_page_cache_readahead+0x94/0xa2
[   65.390000]  [<000a1848>] __put_page+0x0/0x32
[   65.390000]  [<00096316>] unlock_page+0x0/0x2a
[   65.390000]  [<000970f4>] generic_file_buffered_read+0x11e/0x64a
[   65.390000]  [<000986f4>] generic_file_read_iter+0x100/0x132
[   65.390000]  [<000e0246>] __vfs_read+0x116/0x150
[   65.390000]  [<00020000>] _FP_CALL_TOP+0x9a46/0xd512
[   65.390000]  [<000e02dc>] vfs_read+0x5c/0xe4
[   65.390000]  [<000e0766>] ksys_read+0x42/0x8a
[   65.390000]  [<000e07c0>] sys_read+0x12/0x18
[   65.390000]  [<00002934>] syscall+0x8/0xc
[   65.390000]  [<0000c016>] bvme6000_gettimeoffset+0xaa/0xe2
[   65.390000] Code: 2d20 012a 2839 005f 5124 226b 0014 7001 <b0a9> 0060 6600 0210 4a29 0064 6700 0208 4a8b 6700 0294 2053 2068 0014 2028 002c

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
