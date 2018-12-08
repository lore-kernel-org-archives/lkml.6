Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75749C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355392083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544300944;
	bh=63XzysPyjU/fSz1E4sS6O8QzyYl9dn9rMAsO5kg6ufE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=e5XskhTPd/2BH6hDX9ax6CPiRIbuMubYromXkW+B8yPsftSfZuBEXWLrxsYEEfsfg
	 TuCOcsRRdkR5pnVoJ97EXeGFv2t17m/xk4KUdM8yN7dL9UDdsTdQClPTLsQaOlCiJL
	 gEgQAdrqIdqv5R9F+1CDcHv/WA32EJdNkwTM4zYY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355392083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLHU3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 15:29:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbeLHU3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 15:29:02 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2692081F;
        Sat,  8 Dec 2018 20:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544300942;
        bh=63XzysPyjU/fSz1E4sS6O8QzyYl9dn9rMAsO5kg6ufE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=xVVjqbw9pMydZ/QrQxI2PAJqMcTuqkIfVcZKhsv6e0Jg0ZCFHazujVPxeNNNgBW8P
         eoz3vK11qFlAnO7B6+FE/MoHcFQSZWHe6OMvHY/3hh0uhrs+j/SUnHHd3AcbU103JX
         z68nX156rTGYMiu46hww20V9Gx+IRJEKje9h6LBA=
Subject: Re: [PATCH 2/2] dmaengine: qcom_hidma: assign channel cookie
 correctly
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, vkoul@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
References: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
 <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <88ef21bd-4e4f-8cce-39b3-53da45740f0f@kernel.org>
Date:   Sat, 8 Dec 2018 15:28:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2018 11:29 PM, Shunyong Yang wrote:
> When dma_cookie_complete() is called in hidma_process_completed(),
> dma_cookie_status() will return DMA_COMPLETE in hidma_tx_status(). Then,
> hidma_txn_is_success() will be called to use channel cookie
> mchan->last_success to do additional DMA status check. Current code
> assigns mchan->last_success after dma_cookie_complete(). This causes
> a race condition of dma_cookie_status() returns DMA_COMPLETE before
> mchan->last_success is assigned correctly. The race will cause
> hidma_tx_status() return DMA_ERROR but the transaction is actually a
> success. Moreover, in async_tx case, it will cause a timeout panic
> in async_tx_quiesce().
> 
>   Kernel panic - not syncing: async_tx_quiesce: DMA error waiting for
>   transaction
>   ...
>   Call trace:
>   [<ffff000008089994>] dump_backtrace+0x0/0x1f4
>   [<ffff000008089bac>] show_stack+0x24/0x2c
>   [<ffff00000891e198>] dump_stack+0x84/0xa8
>   [<ffff0000080da544>] panic+0x12c/0x29c
>   [<ffff0000045d0334>] async_tx_quiesce+0xa4/0xc8 [async_tx]
>   [<ffff0000045d03c8>] async_trigger_callback+0x70/0x1c0 [async_tx]
>   [<ffff0000048b7d74>] raid_run_ops+0x86c/0x1540 [raid456]
>   [<ffff0000048bd084>] handle_stripe+0x5e8/0x1c7c [raid456]
>   [<ffff0000048be9ec>] handle_active_stripes.isra.45+0x2d4/0x550 [raid456]
>   [<ffff0000048beff4>] raid5d+0x38c/0x5d0 [raid456]
>   [<ffff000008736538>] md_thread+0x108/0x168
>   [<ffff0000080fb1cc>] kthread+0x10c/0x138
>   [<ffff000008084d34>] ret_from_fork+0x10/0x18
> 
> Cc: Joey Zheng<yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang<shunyong.yang@hxt-semitech.com>


Acked-by: Sinan Kaya <okaya@kernel.org>

to both patches 1/2 and 2/2.

