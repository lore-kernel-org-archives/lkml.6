Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D9A20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfAIDI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:08:56 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57738 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727857AbfAIDI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:08:56 -0500
X-UUID: e915041112bc40c484045dcd45fdf23c-20190109
X-UUID: e915041112bc40c484045dcd45fdf23c-20190109
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 55859722; Wed, 09 Jan 2019 11:08:50 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 11:08:48 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Jan 2019 11:08:48 +0800
Message-ID: <1547003324.6818.156.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support
 for active state of scpsys on mt8183
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 9 Jan 2019 11:08:44 +0800
In-Reply-To: <08d15fa8-7e53-518c-54bb-8050b0e4aabd@linaro.org>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
         <1546859080.6818.128.camel@mtksdaap41>
         <08d15fa8-7e53-518c-54bb-8050b0e4aabd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 18:34 +0200, Georgi Djakov wrote:
> Hi Henry,
> 
> On 1/7/19 13:04, Henry Chen wrote:
> > On Thu, 2019-01-03 at 14:53 -0800, Stephen Boyd wrote:
> >> Quoting Henry Chen (2019-01-02 06:09:51)
> >>> The patchsets add support for MediaTek hardware module named DVFSRC
> >>> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> >>> a HW module which is used to collect all the requests from both software
> >>> and hardware and turn into the decision of minimum operating voltage and
> >>> minimum DRAM frequency to fulfill those requests.
> >>>
> >>> So, This series is to implement the dvfsrc driver to collect all the
> >>> requests of operating voltage or DRAM bandwidth from other device drivers
> >>> likes GPU/Camera through 2 frameworks basically:
> >>>
> >>> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
> >>>    requirements from different clients
> >>
> >> Have you looked at using the interconnect framework for this instead of
> >> using PM_QOS_MEMORY_BANDWIDTH? Qcom is pushing an interconnect framework
> >> to do DRAM bandwidth requirement aggregation.
> > 
> > Sorry, I haven't heard that before. Do you mean is following series
> > patch?
> > https://patchwork.kernel.org/project/linux-arm-msm/list/?series=53775
> > 
> 
> Yes, this one. The idea is that consumer drivers like GPU, camera, video
> encoder etc. report their bandwidth needs by using the interconnect API.
> The framework does the aggregation and configures the hardware. In order
> to use it you need to implement a platform-specific dvfsrc interconnect
> provider driver that understands the SoC topology and knows how to
> configure the hardware. I am not familiar with DVFSRC, but it seems to
> me that it can fit as interconnect provider.
> Does this HW module support any QoS priority/latency configuration or is
> it only bandwidth and voltage?
> 
> Thanks,
> Georgi

Hi Georgi,

Yes, the design is only to support bandwidth and voltage. The one of the
function is to collect the memory bandwidth requirement from consumer
and select the minimum DRAM frequency to fulfill system performance.It
just get the total bandwidth then set it to HW, not involves complex SoC
topology. So we choose to use PM QOS to model that DVFSRC driver can
receive the bandwidth information from consumer driver via
PM_QOS_MEMORY_BANDWIDTH.

Do you have a patch that show how consumer driver used interconnect to
update their requirement.

Thanks,
Henry


