Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F744C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED34223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBA0kMPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED34223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbeKPDmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbeKPDmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:42:03 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3736221582;
        Thu, 15 Nov 2018 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542303199;
        bh=nVi4SNh8HC5Z1l4JDFLL6q+TnO7ld25BbfC8+k4aM+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBA0kMPc8BDjvD9mo/Y+0Bu/vrPNxUv1UFmIU0Xnk5uxNavsd4EgQEsk7YLQJkud/
         ph1/5gbQ89xYFNF67MNxPdkLa/WLHHeHlMZ3R8YJ9ceLvp19KGUDwYR7BUHyI5ZEfT
         Q1fWjO+LAXoQ96i/U2wASexLalFsucaQMtaWtktU=
Date:   Thu, 15 Nov 2018 12:33:18 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
Message-ID: <20181115173318.GG95254@sasha-vm>
References: <20181105230820.3562-1-jbrunet@baylibre.com>
 <5BEAFE05.9070905@baylibre.com>
 <5BEAFEA5.6060902@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BEAFEA5.6060902@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 05:41:09PM +0100, Neil Armstrong wrote:
>Le 13/11/2018 17:38, Neil Armstrong a écrit :
>> Hi Stable team,
>>
>> Le 06/11/2018 00:08, Jerome Brunet a écrit :
>>> From: Christian Hewitt <christianshewitt@gmail.com>
>>>
>>> On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
>>> with reboot; e.g. a ~60 second delay between issuing reboot and the
>>> board power cycling (and in some OS configurations reboot will fail
>>> and require manual power cycling).
>>>
>>> Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
>>> meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
>>> Co-Processor seems to depend on FCLK_DIV3 being operational.
>>>
>>> Until commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
>>> meson: add fdiv clock gates"), this clock was modeled and left on by
>>> the bootloader.
>>>
>>> We don't have precise documentation about the SCPI Co-Processor and
>>> its clock requirement so we are learning things the hard way.
>>>
>>> Marking this clock as critical solves the problem but it should not
>>> be viewed as final solution. Ideally, the SCPI driver should claim
>>> these clocks. We also depends on some clock hand-off mechanism
>>> making its way to CCF, to make sure the clock stays on between its
>>> registration and the SCPI driver probe.
>>>
>>> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>
>>
>> Could this patch go into the next 4.18 stable release since it hit linus master with commit id e2576c8bdfd462c34b8a46c0084e7c30b0851bf4 ?
>
>I forgot, but it should also go into the next 4.19 stable release aswell.

Queued up for 4.19 and 4.18, thank you.

--
Thanks,
Sasha
