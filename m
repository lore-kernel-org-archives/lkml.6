Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EC7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8002A2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfAHDYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:24:05 -0500
Received: from regular1.263xmail.com ([211.150.99.140]:38962 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfAHDYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:24:04 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 22:24:02 EST
Received: from jeffy.chen?rock-chips.com (unknown [192.168.167.207])
        by regular1.263xmail.com (Postfix) with ESMTP id 7A4F8220;
        Tue,  8 Jan 2019 11:17:02 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.22.144] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P1323T140230924408576S1546917419923208_;
        Tue, 08 Jan 2019 11:17:02 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8b74f9e3314eb687daffe07f41349aca>
X-RL-SENDER: jeffy.chen@rock-chips.com
X-SENDER: cjf@rock-chips.com
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-FST-TO: tony@atomide.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5C34162B.200@rock-chips.com>
Date:   Tue, 08 Jan 2019 11:16:59 +0800
From:   JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
CC:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] mfd: syscon: Fix syscon name for device tree
References: <20190108000558.54914-1-tony@atomide.com> <20190108001543.GJ5544@atomide.com>
In-Reply-To: <20190108001543.GJ5544@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 01/08/2019 08:15 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [190108 00:06]:
>> I'm now seeing the following error on omap5 during boot:
>>
>> (NULL device *): Failed to create dummy-scm_conf@0 debugfs directory
This log means failed to init regmap debugfs with device(NULL) and 
name("scm_conf@0"), which likely to be called from of_syscon_register() 
with np fullname("scm_conf@0").

So my guess would be there're more than one syscon dts nodes named 
"scm_conf@0".


For omap5 and scm_conf@0, should be these 2:
https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/omap5.dtsi#L167
				scm_conf: scm_conf@0 {
					compatible = "syscon";

https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/omap5.dtsi#L313
				scm_wkup_pad_conf: scm_conf@0 {
					compatible = "syscon", "simple-bus";

Maybe try to rename one of them(for example, rename the second one to 
"scm_wkup_pad_conf@0").


