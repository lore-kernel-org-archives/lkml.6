Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15948C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C355C21655
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XInUn69E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C355C21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeFZP3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:29:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10596 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbeFZP3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530026974; x=1561562974;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lOKmCM77Hd/NqRG7yjJZ4zCFpC+Q1NnnCZ/45CTdueI=;
  b=XInUn69EZdMZZ8j7Ic4xnnoBCoBLEbUxNi6Wm11Ib8FK72OSUsUrq2IC
   G1HTRxuef4th1DWOfTy3Jb6HgN1IO19lWNiNhnLU/BbvvU5vkVvsHCPDv
   ihmJMx1G63ClDAMMzQw5NnB8GZtv/DV6NUdFd8WOJU97ezFDBh9lAC/iL
   fgLEkgIvty8Fb8a30ITjI2XnHLR4KCvaojjKkPLHqCya/UAUzgrC0zAuH
   WiHaqi4efWJ/nUf2akdo3oXrQT6KlEY4oztoeYxGJVi9Ucsi6k/WQduPx
   9FOcop1gcRPwXCejwcwwtzAaMq9ih5ey19K6v8AxUbkSNwhAHDW3dAz05
   g==;
X-IronPort-AV: E=Sophos;i="5.51,274,1526313600"; 
   d="scan'208";a="81935108"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2018 23:29:34 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 26 Jun 2018 08:18:53 -0700
Received: from thinkpad-bart.sdcorp.global.sandisk.com (HELO [10.111.67.248]) ([10.111.67.248])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2018 08:29:34 -0700
Subject: Re: [PATCH] blk-mq-fs: invoke queue_for_each_hw_ctx under sysfs_lock
To:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1529907699-2054-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <d7b196bf-be18-a8f0-29ce-4f705689babe@wdc.com>
Date:   Tue, 26 Jun 2018 08:29:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529907699-2054-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/18 23:20, Jianchao Wang wrote:
> blk_mq_run_hw_queues and blk_mq_start_stopped_hw_queues in
> queue_state_write will invoke queue_for_each_hw_ctx. It will race
> with blk_mq_realloc_hw_ctxs and incur NULL pointer reference. Put
> them under sysfs_lock to serialize the accessing to queue_hw_ctx
> and nr_hw_queues.

The above looks wrong to me. blk_mq_realloc_hw_ctxs() starts with 
calling blk_mq_unregister_hctx(). That last function uses kobject_del() 
and kobject_del() waits until all pending sysfs callback functions for 
the deleted objects have finished.

Bart.

