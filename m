Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1BCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2649320652
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2649320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbeI1Lcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:32:53 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:42608 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1Lcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:32:52 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g5l3J-0000B3-Aa; Fri, 28 Sep 2018 13:10:57 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g5l2l-00062f-Qp; Fri, 28 Sep 2018 13:10:23 +0800
Date:   Fri, 28 Sep 2018 13:10:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Waiman Long <longman@redhat.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        "David S. Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor McLoughlin <conor.mcloughlin@intel.com>
Subject: Re: [PATCH] crypto: qat - Fix KASAN stack-out-of-bounds bug in
 adf_probe()
Message-ID: <20180928051023.3hcs7hctgplnh4go@gondor.apana.org.au>
References: <1537663315-4168-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537663315-4168-1-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 08:41:55PM -0400, Waiman Long wrote:
> The following KASAN warning was printed when booting a 64-bit kernel
> on some systems with Intel CPUs:
> 
> [   44.512826] ==================================================================
> [   44.520165] BUG: KASAN: stack-out-of-bounds in find_first_bit+0xb0/0xc0
> [   44.526786] Read of size 8 at addr ffff88041e02fc50 by task kworker/0:2/124
> 
> [   44.535253] CPU: 0 PID: 124 Comm: kworker/0:2 Tainted: G               X --------- ---  4.18.0-12.el8.x86_64+debug #1
> [   44.545858] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS BKVDTRL1.86B.0005.D08.1712070559 12/07/2017
> [   44.555682] Workqueue: events work_for_cpu_fn
> [   44.560043] Call Trace:
> [   44.562502]  dump_stack+0x9a/0xe9
> [   44.565832]  print_address_description+0x65/0x22e
> [   44.570683]  ? find_first_bit+0xb0/0xc0
> [   44.570689]  kasan_report.cold.6+0x92/0x19f
> [   44.578726]  find_first_bit+0xb0/0xc0
> [   44.578737]  adf_probe+0x9eb/0x19a0 [qat_c62x]
> [   44.578751]  ? adf_remove+0x110/0x110 [qat_c62x]
> [   44.591490]  ? mark_held_locks+0xc8/0x140
> [   44.591498]  ? _raw_spin_unlock+0x30/0x30
> [   44.591505]  ? trace_hardirqs_on_caller+0x381/0x570
> [   44.604418]  ? adf_remove+0x110/0x110 [qat_c62x]
> [   44.604427]  local_pci_probe+0xd4/0x180
> [   44.604432]  ? pci_device_shutdown+0x110/0x110
> [   44.617386]  work_for_cpu_fn+0x51/0xa0
> [   44.621145]  process_one_work+0x8fe/0x16e0
> [   44.625263]  ? pwq_dec_nr_in_flight+0x2d0/0x2d0
> [   44.629799]  ? lock_acquire+0x14c/0x400
> [   44.633645]  ? move_linked_works+0x12e/0x2a0
> [   44.637928]  worker_thread+0x536/0xb50
> [   44.641690]  ? __kthread_parkme+0xb6/0x180
> [   44.645796]  ? process_one_work+0x16e0/0x16e0
> [   44.650160]  kthread+0x30c/0x3d0
> [   44.653400]  ? kthread_create_worker_on_cpu+0xc0/0xc0
> [   44.658457]  ret_from_fork+0x3a/0x50
> 
> [   44.663557] The buggy address belongs to the page:
> [   44.668350] page:ffffea0010780bc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> [   44.676356] flags: 0x17ffffc0000000()
> [   44.680023] raw: 0017ffffc0000000 ffffea0010780bc8 ffffea0010780bc8 0000000000000000
> [   44.687769] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> [   44.695510] page dumped because: kasan: bad access detected
> 
> [   44.702578] Memory state around the buggy address:
> [   44.707372]  ffff88041e02fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   44.714593]  ffff88041e02fb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   44.721810] >ffff88041e02fc00: 00 00 00 00 00 00 f1 f1 f1 f1 04 f2 f2 f2 f2 f2
> [   44.729028]                                                  ^
> [   44.734864]  ffff88041e02fc80: f2 f2 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00
> [   44.742082]  ffff88041e02fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   44.749299] ==================================================================
> 
> Looking into the code:
> 
>   int ret, bar_mask;
>     :
>   for_each_set_bit(bar_nr, (const unsigned long *)&bar_mask,
> 
> It is casting a 32-bit integer pointer to a 64-bit unsigned long
> pointer. There are two problems here. First, the 32-bit pointer address
> may not be 64-bit aligned. Secondly, it is accessing an extra 4 bytes.
> 
> This is fixed by changing the bar_mask type to unsigned long.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
