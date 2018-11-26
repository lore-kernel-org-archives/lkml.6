Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA0BC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06AB20878
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06AB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeKZOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:43:05 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:40696 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726124AbeKZOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:43:04 -0500
X-UUID: 20359b06a6f842ee9a03d7f63e985d43-20181126
X-UUID: 20359b06a6f842ee9a03d7f63e985d43-20181126
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 572013276; Mon, 26 Nov 2018 11:49:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 26 Nov 2018 11:49:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 26 Nov 2018 11:49:36 +0800
Message-ID: <1543204176.26011.4.camel@mtkswgap22>
Subject: Re: [PATCH v1 3/3] arm64: dts: mt7622: Drop the general purpose
 timer node
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 26 Nov 2018 11:49:36 +0800
In-Reply-To: <be2b45e1-f639-e14c-1c40-9cd94b006309@gmail.com>
References: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
         <17fde639c7d37f9cfabab230379913e652cf869a.1541643419.git.ryder.lee@mediatek.com>
         <be2b45e1-f639-e14c-1c40-9cd94b006309@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 18:07 +0100, Matthias Brugger wrote:
> 
> On 12/11/2018 02:28, Ryder Lee wrote:
> > The crash http://termbin.com/zitb is caused by the timer register
> > into system in early pahse during kernel boot, but the clock
> > sources didn't get ready at that time.
> > 
> > A better way is to switch to use CLK_OF_DECLARE() in driver for things
> > that need them early, but this node is actually useless in MT7622.
> > So we drop it.
> 
> I suppose the root cause is, that the driver doesn't check the error
> timer_of_init returned.
> 
> Would you mind to test the following patch to see if this fixes the problem?
> 
> --->8
> From be91e56ed527261137335af340845eb3dd3dd33a Mon Sep 17 00:00:00 2001
> From: Matthias Brugger <matthias.bgg@gmail.com>
> Date: Fri, 23 Nov 2018 17:04:08 +0100
> Subject: [PATCH] clocksource/drivers/timer-mediatek: error out on probe defer
> 
> If the clocks are not yet present, because they are loaded after
> the timer is initialized, we are unable to boot.
> Check if the return value of timer_of_init and return on EPROBE_DEFER.
> 
> Error seen is:
> [    0.008337] Failed to get clock for /timer@10004000
> [    0.013435] WARNING: CPU: 0 PID: 0 at ../drivers/clk/clk.c:3615
> __clk_put+0xf0/0x120
> [    0.021453] Modules linked in:
> [    0.024614] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 4.20.0-rc1-00063-g2859d9abd7e8 #2
> [    0.032902] Hardware name: MediaTek MT7622 RFB1 board (DT)
> [    0.038580] pstate: 20000085 (nzCv daIf -PAN -UAO)
> [    0.043538] pc : __clk_put+0xf0/0x120
> [    0.047328] lr : clk_put+0xc/0x18
> [    0.050753] sp : ffff000009163ed0
> [    0.054178] x29: ffff000009163ed0 x28: 0000000041010018
> [    0.059676] x27: 0000000000000000 x26: 0000000000000000
> [    0.065174] x25: ffff0000090cb008 x24: ffff80001dfd7800
> [    0.070672] x23: ffff000008f934b8 x22: ffff80001dfdeae0
> [    0.076169] x21: ffff80001dfdeae0 x20: fffffffffffffdfb
> [    0.081668] x19: ffff00000929ac40 x18: ffffffffffffffff
> [    0.087166] x17: 0000000000000000 x16: 0000000000000000
> [    0.092664] x15: ffff0000091696c8 x14: ffff0000892cd70f
> [    0.098162] x13: ffff0000092cd71d x12: ffff000009181348
> [    0.103661] x11: ffff000009181000 x10: 0000000005f5e0ff
> [    0.109159] x9 : 0000000000000040 x8 : ffff000009181400
> [    0.114657] x7 : ffff80001c800270 x6 : 0000000000000000
> [    0.120155] x5 : ffff80001c800248 x4 : 0000000000000000
> [    0.125653] x3 : 0000000000000000 x2 : 0000000000000000
> [    0.131151] x1 : 0000000000000000 x0 : fffffffffffffdfb
> [    0.136649] Call trace:
> [    0.139175]  __clk_put+0xf0/0x120
> [    0.142605]  timer_of_cleanup+0x60/0x7c
> [    0.146572]  mtk_gpt_init+0x18c/0x1a0
> [    0.150359]  timer_probe+0x74/0x10c
> [    0.153969]  time_init+0x14/0x44
> [    0.157307]  start_kernel+0x29c/0x414
> [    0.161098] ---[ end trace c3137b005300b618 ]---
> 
> Fixes: a0858f937960 ("clocksource/drivers/timer-mediatek: Convert the driver to
> timer-of")
> Fixes: e3af677607d9 ("clocksource/drivers/timer-mediatek: Add support for system
> timer")
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/clocksource/timer-mediatek.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c
> b/drivers/clocksource/timer-mediatek.c
> index eb10321f8517..d40c77a65b08 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -276,8 +276,12 @@ static int __init mtk_syst_init(struct device_node *node)
>  	to.of_irq.handler = mtk_syst_handler;
> 
>  	ret = timer_of_init(node, &to);
> -	if (ret)
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
>  		goto err;
> +	}
> 
>  	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
>  					TIMER_SYNC_TICKS, 0xffffffff);
> @@ -301,8 +305,12 @@ static int __init mtk_gpt_init(struct device_node *node)
>  	to.of_irq.handler = mtk_gpt_interrupt;
> 
>  	ret = timer_of_init(node, &to);
> -	if (ret)
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
>  		goto err;
> +	}
> 
>  	/* Configure clock source */
>  	mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);

I tried this patch, but it didn't work. I think *_OF_DECLARE() is not
compatible with EPROBE_DEFER.

I also found the similar discussion about this issue:
https://patchwork.kernel.org/patch/10580345/


Ryder


