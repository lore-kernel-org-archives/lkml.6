Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58363C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B242147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfAGLEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:04:54 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33326 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726535AbfAGLEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:04:53 -0500
X-UUID: 68f841e6e90842c499d7f0efa05144bb-20190107
X-UUID: 68f841e6e90842c499d7f0efa05144bb-20190107
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 35773300; Mon, 07 Jan 2019 19:04:47 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:04:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 19:04:40 +0800
Message-ID: <1546859080.6818.128.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support
 for active state of scpsys on mt8183
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Stephen Boyd <swboyd@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
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
Date:   Mon, 7 Jan 2019 19:04:40 +0800
In-Reply-To: <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 14:53 -0800, Stephen Boyd wrote:
> Quoting Henry Chen (2019-01-02 06:09:51)
> > The patchsets add support for MediaTek hardware module named DVFSRC
> > (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> > a HW module which is used to collect all the requests from both software
> > and hardware and turn into the decision of minimum operating voltage and
> > minimum DRAM frequency to fulfill those requests.
> > 
> > So, This series is to implement the dvfsrc driver to collect all the
> > requests of operating voltage or DRAM bandwidth from other device drivers
> > likes GPU/Camera through 2 frameworks basically:
> > 
> > 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
> >    requirements from different clients
> 
> Have you looked at using the interconnect framework for this instead of
> using PM_QOS_MEMORY_BANDWIDTH? Qcom is pushing an interconnect framework
> to do DRAM bandwidth requirement aggregation.

Sorry, I haven't heard that before. Do you mean is following series
patch?
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=53775


> > 2. Active state management of power domains[1]: to handle the operating
> >    voltage opp requirement from different power domains
> 
> Do you have any devices that aren't "OPP-ish" in how they use
> frequencies and voltages? What I mean is devices such as i2c, SPI, UART
> controllers that don't use the OPP library to set a frequency but want
> to affect some voltage of their power domain when clk frequencies
> change. The existing code works well for devices that naturally use the
> OPP rate changing API, typically multimedia devices that churn through
> data like a CPU and don't care about the frequency of their main clk
> because it doesn't match physical link bit rates, etc. I haven't seen
> any good solution for devices that don't fit well with the OPP API
> though so I'm curious if Mediatek needs to solve that problem. 

As I know, we don't have such device that need change clk and voltage
together without used OPP API.We suppose that user driver will call opp
library and performance state of power domain is combined into opp
table.

Thanks.
Henry

