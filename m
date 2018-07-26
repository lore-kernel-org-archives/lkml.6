Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877AFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402BE20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=contabo.de header.i=@contabo.de header.b="K7k7WVpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402BE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=contabo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeGZLQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:16:53 -0400
Received: from mail.contabo.com ([91.205.175.50]:45350 "EHLO mail.contabo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbeGZLQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=contabo.de;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rELuygaDl6UuGK8p7S3hop2GWxe7PYy2s6oLb9teTYY=; b=K7k7WVpCJ6VkrP6HmvUFzQRmEj
        J8nHRSFvaFpMv1cETOMP7RBg/CxoVmBz6RWaXTOfKz1U/DHSXWCGKLHpkmWaU4ktpfMVmE6StEfpf
        pHaBDIZZNHHBdiX54As+Tn/gPjmQinesk21KmuXWINhFwW+Psa82WiCemJQDT9Fx7ZaUynrQZhAN+
        M4J0MIxIokl4wFXNDkKCjTawSFP35/BVdWLi5b87PWjJIP8RFowgayisafFXrFUy+EUeTJ06FcOUH
        HPzUwTlVviZyWbfVwTc+CKxTx3OZNm2sOjj7lMquoU0RCt0oKLTGZqX8u6WxgMomph5ADmA7K7L5n
        59KhcspQ==;
Received: from [178.238.239.246] (port=43652 helo=[192.168.178.123])
        by mail.contabo.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <tino.lehnig@contabo.de>)
        id 1fid4e-00086g-H5; Thu, 26 Jul 2018 12:00:44 +0200
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
From:   Tino Lehnig <tino.lehnig@contabo.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725132126.GA2893@rodete-laptop-imager.corp.google.com>
 <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
 <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
 <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
Message-ID: <15e3a0af-7e02-83fb-4b72-b05f6d7ded71@contabo.de>
Date:   Thu, 26 Jul 2018 12:00:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.contabo.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - contabo.de
X-Get-Message-Sender-Via: mail.contabo.com: authenticated_id: tino.lehnig@contabo.de
X-Authenticated-Sender: mail.contabo.com: tino.lehnig@contabo.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 08:10 AM, Tino Lehnig wrote:
>> A thing I could imagine is
>> [0bcac06f27d75, skip swapcache for swapin of synchronous device]
>> It was merged into v4.15. Could you check it by bisecting?
> 
> Thanks, I will check that.

So I get the same behavior as in v4.15-rc1 after this commit. All prior 
builds are fine.

I have also tested all other 4.15 rc builds now and the symptoms are the 
same through rc8. KVM processes become unresponsive and I see kernel 
messages like the one below. This happens with and without the writeback 
feature being used. The bad page state bug appears very rarely in these 
versions and only when writeback is active.

Starting with rc9, I only get the same bad page state bug as in all 
newer kernels.

--

[  363.494793] INFO: task kworker/4:2:498 blocked for more than 120 seconds.
[  363.494872]       Not tainted 4.14.0-zram-pre-rc1 #17
[  363.494943] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  363.495021] kworker/4:2     D    0   498      2 0x80000000
[  363.495029] Workqueue: events async_pf_execute
[  363.495030] Call Trace:
[  363.495037]  ? __schedule+0x3bc/0x830
[  363.495039]  schedule+0x32/0x80
[  363.495042]  io_schedule+0x12/0x40
[  363.495045]  __lock_page_or_retry+0x302/0x320
[  363.495047]  ? page_cache_tree_insert+0xa0/0xa0
[  363.495051]  do_swap_page+0x4ab/0x860
[  363.495054]  __handle_mm_fault+0x77b/0x10c0
[  363.495056]  handle_mm_fault+0xc6/0x1b0
[  363.495059]  __get_user_pages+0xf9/0x620
[  363.495061]  ? update_load_avg+0x5d6/0x6d0
[  363.495064]  get_user_pages_remote+0x137/0x1f0
[  363.495067]  async_pf_execute+0x62/0x180
[  363.495071]  process_one_work+0x184/0x380
[  363.495073]  worker_thread+0x4d/0x3c0
[  363.495076]  kthread+0xf5/0x130
[  363.495078]  ? process_one_work+0x380/0x380
[  363.495080]  ? kthread_create_worker_on_cpu+0x50/0x50
[  363.495083]  ? do_group_exit+0x3a/0xa0
[  363.495086]  ret_from_fork+0x1f/0x30

-- 
Kind regards,

Tino Lehnig
