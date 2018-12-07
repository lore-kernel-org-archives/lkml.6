Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C369C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03CB208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03CB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLGOX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:23:58 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:61723 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbeLGOX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:23:57 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9D18E13F81D;
        Fri,  7 Dec 2018 15:23:40 +0100 (CET)
Subject: Re: [PATCH v2] clk: qcom: smd: Add support for MSM8998 rpm clocks
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1544134310-10227-1-git-send-email-jhugo@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <84c0fd53-98e9-ac41-f1ca-68ad6d676e9a@free.fr>
Date:   Fri, 7 Dec 2018 15:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544134310-10227-1-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 23:11, Jeffrey Hugo wrote:

> Add rpm smd clocks, PMIC and bus clocks which are required on MSM8998
> for clients to vote on.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
> v2
> -fix compatible ordering nits per Stephen
> 
>  .../devicetree/bindings/clock/qcom,rpmcc.txt       |  1 +
>  drivers/clk/qcom/clk-smd-rpm.c                     | 62 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,rpmcc.h             |  6 +++
>  3 files changed, 69 insertions(+)

Hmmm, my board seems to dislike this patch... it locks up for a while,
then reboots.

[    6.957289] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
[    6.961233] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 2
[    6.970782] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: query attribute, opcode 6, idn 1, failed with error -11 after 3 retires
[    6.979576] ufshcd-qcom 1da4000.ufshc: ufshcd_complete_dev_init setting fDeviceInit flag failed with error -11
[   23.432798] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   23.432884] rcu:     7-...0: (1 GPs behind) idle=6a2/1/0x4000000000000000 softirq=92/93 fqs=2626 
[   23.437927] rcu:     (detected by 0, t=5252 jiffies, g=-819, q=112)
[   23.446425] Task dump for CPU 7:
[   23.452567] swapper/0       R  running task        0     1      0 0x0000002a
[   23.455806] Call trace:
[   23.462872]  __switch_to+0x94/0xe0
[   23.465009]  _regmap_write+0x58/0xb0
[   23.468452]  _regmap_update_bits+0xf0/0x110
[   23.472186]  regmap_update_bits_base+0x60/0x90
[   23.476110]  clk_disable_regmap+0x34/0x40
[   23.480614]  clk_branch_toggle+0x108/0x1b0
[   23.484681]  clk_branch2_disable+0x18/0x20
[   23.488692]  clk_disable_unused_subtree+0xc4/0xe0
[   23.492761]  clk_disable_unused+0x3c/0x130
[   23.497535]  do_one_initcall+0x5c/0x180
[   23.501557]  kernel_init_freeable+0x198/0x244
[   23.505276]  kernel_init+0x10/0x110
[   23.509768]  ret_from_fork+0x10/0x20

/*** REBOOT ***/
Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic

I need to check the ufs_reset pin and phy init seq before I can investigate
this issue, but I wanted to send a report ASAP.

Regards.
