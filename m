Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47A0208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47A0208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbeGKKJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:09:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10319 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726460AbeGKKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:09:54 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42115580"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jul 2018 18:06:19 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 2FA3E4B473E7;
        Wed, 11 Jul 2018 18:06:20 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Wed, 11 Jul 2018 18:06:16 +0800
Date:   Wed, 11 Jul 2018 18:04:45 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <yasu.isimatu@gmail.com>, <keescook@chromium.org>
CC:     <indou.takao@jp.fujitsu.com>, <bhe@redhat.com>,
        <caoj.fnst@cn.fujitsu.com>, <douly.fnst@cn.fujitsu.com>
Subject: Re: Bug report about KASLR and ZONE_MOVABLE
Message-ID: <20180711100445.GA6742@localhost.localdomain>
References: <20180711094244.GA2019@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180711094244.GA2019@localhost.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 2FA3E4B473E7.A9C0B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 05:42:44PM +0800, Chao Fan wrote:
>Hi all,
>
>I found there is a BUG about KASLR and ZONE_MOVABLE.
>
>When users use 'kernelcore=' parameter without 'movable_node',
>movable memory is evenly distributed to all nodes. The size of
>ZONE_MOVABLE depends on the kernel parameter 'kernelcore=' and
>'movablecore='.
>But sometiomes, KASLR may put the uncompressed kernel to the
>tail position of a node, which will cause the kernel memory
>set as ZONE_MOVABLE. This region can not be offlined.
>
>Here is a very simple test in my qemu-kvm machine, there is
>only one node:
>
>The command line:
>[root@localhost ~]# cat /proc/cmdline
>BOOT_IMAGE=/vmlinuz-4.18.0-rc3+ root=/dev/mapper/fedora_localhost--live-root
>ro resume=/dev/mapper/fedora_localhost--live-swap
>rd.lvm.lv=fedora_localhost-live/root rd.lvm.lv=fedora_localhost-live/swap
>console=ttyS0 earlyprintk=ttyS0,115200n8 memblock=debug kernelcore=50%
>
>I use 'kernelcore=50%' here.
>
>Here is my early print result, I print the random_addr after KASLR chooses
>physical memory:
>early console in extract_kernel
>input_data: 0x000000000266b3b1
>input_len: 0x00000000007d8802
>output: 0x0000000001000000
>output_len: 0x0000000001e15698
>kernel_total_size: 0x0000000001a8b000
>trampoline_32bit: 0x000000000009d000
>booted via startup_32()
>Physical KASLR using RDRAND RDTSC...
>random_addr: 0x000000012f000000
>Virtual KASLR using RDRAND RDTSC...
>
>The address for kernel is 0x000000012f000000
>
>Here is the log of ZONE:
>[    0.000000] Zone ranges:
>[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001f57fffff]
>[    0.000000]   Device   empty
>[    0.000000] Movable zone start for each node
>[    0.000000]   Node 0: 0x000000011b000000
>[    0.000000] Early memory node ranges
>[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
>[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffd6fff]
>[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001f57fffff]
>[    0.000000] Initmem setup node 0 [mem
>0x0000000000001000-0x00000001f57fffff]
>
>Only one node in my machine, ZONE_MOVABLE begins from 0x000000011b000000,
>which is lower than 0x000000012f000000.
>So KASLR put the kernel to the ZONE_MOVABLE.
>Try to solve this problem, I think there should be a new tactic in function
>find_zone_movable_pfns_for_nodes() of mm/page_alloc.c. If kernel is uncompressed
>in a tail position, then just set the memory after the kernel as ZONE_MOVABLE,
>at the same time, memory in other nodes will be set as ZONE_MOVABLE.

Sorry, mistake here. It should be:
"more memory in other nodes will be set as ZONE_MOVABLE".

Thanks,
Chao Fan

>
>If there is something wrong, pleas let me know. And any comments will be welcome.
>
>Thanks,
>Chao Fan


