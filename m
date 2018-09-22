Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB81AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5554421522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5554421522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbeIVSux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:50:53 -0400
Received: from mail1.windriver.com ([147.11.146.13]:39548 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeIVSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:50:53 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8MCv26D016779
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 22 Sep 2018 05:57:02 -0700 (PDT)
Received: from [128.224.162.216] (128.224.162.216) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 22 Sep
 2018 05:57:01 -0700
Subject: Re: [PATCH] kernel/dma: Fix panic caused by passing swiotlb to
 command line
To:     <konrad.wilk@oracle.com>, <hch@lst.de>, <m.szyprowski@samsung.com>,
        <robin.murphy@arm.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <1537154831-447363-1-git-send-email-zhe.he@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <c3536f4f-9bde-4f7f-a180-aa569d4e786d@windriver.com>
Date:   Sat, 22 Sep 2018 20:56:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537154831-447363-1-git-send-email-zhe.he@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.216]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I have your input?

Thanks,
Zhe

On 2018年09月17日 11:27, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
>
> setup_io_tlb_npages does not check input argument before passing it
> to isdigit. The argument would be a NULL pointer if "swiotlb", without
> its value, is set in command line and thus causes the following panic.
>
> PANIC: early exception 0xe3 IP 10:ffffffffbb9b8e9f error 0 cr2 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #9
> [    0.000000] RIP: 0010:setup_io_tlb_npages+0xf/0x95
> ...
> [    0.000000] Call Trace:
> [    0.000000]  do_early_param+0x57/0x8e
> [    0.000000]  parse_args+0x208/0x320
> [    0.000000]  ? rdinit_setup+0x30/0x30
> [    0.000000]  parse_early_options+0x29/0x2d
> [    0.000000]  ? rdinit_setup+0x30/0x30
> [    0.000000]  parse_early_param+0x36/0x4d
> [    0.000000]  setup_arch+0x336/0x99e
> [    0.000000]  start_kernel+0x6f/0x4e6
> [    0.000000]  x86_64_start_reservations+0x24/0x26
> [    0.000000]  x86_64_start_kernel+0x6f/0x72
> [    0.000000]  secondary_startup_64+0xa4/0xb0
>
> This patch adds a check to prevent the panic.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Cc: stable@vger.kernel.org
> Cc: konrad.wilk@oracle.com
> Cc: hch@lst.de
> Cc: m.szyprowski@samsung.com
> Cc: robin.murphy@arm.com
> ---
>  kernel/dma/swiotlb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4f8a6db..46fc34e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -109,6 +109,11 @@ static int late_alloc;
>  static int __init
>  setup_io_tlb_npages(char *str)
>  {
> +	if (!str) {
> +		pr_err("Config string not provided\n");
> +		return -EINVAL;
> +	}
> +
>  	if (isdigit(*str)) {
>  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
>  		/* avoid tail segment of size < IO_TLB_SEGSIZE */

