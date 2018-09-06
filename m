Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840462075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oo1siWCk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oo1siWCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840462075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIFVNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:13:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeIFVNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:13:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DFEE9607C6; Thu,  6 Sep 2018 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536251808;
        bh=o6KKQR4Rkb9G+dzQw9TfuGDpjxlRpUPJ2k5JOZwq/0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oo1siWCkvaJBA6PPYUUBcqeAGHQunq3qG1Mdnyn+H6GCUXm3afjEjiRTgqnBIkno1
         XHe4j20vw6M1axNmI3gFrCwcxMUQ6YwUBfiNoLs78Bi7q/4zsROBpQ6xx73hHeEIM5
         MjdhV/mcZ3fyuI7gEJlHh23BoSB0WdGMFFdgGaGQ=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28E5A606FA;
        Thu,  6 Sep 2018 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536251808;
        bh=o6KKQR4Rkb9G+dzQw9TfuGDpjxlRpUPJ2k5JOZwq/0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oo1siWCkvaJBA6PPYUUBcqeAGHQunq3qG1Mdnyn+H6GCUXm3afjEjiRTgqnBIkno1
         XHe4j20vw6M1axNmI3gFrCwcxMUQ6YwUBfiNoLs78Bi7q/4zsROBpQ6xx73hHeEIM5
         MjdhV/mcZ3fyuI7gEJlHh23BoSB0WdGMFFdgGaGQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28E5A606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 6 Sep 2018 10:36:47 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: Re: [PATCH RESEND v1 2/5] drivers: pinctrl: msm: enable PDC
 interrupt only during suspend
Message-ID: <20180906163647.GE28215@codeaurora.org>
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-3-ilina@codeaurora.org>
 <153509896098.28926.3622217918056498792@swboyd.mtv.corp.google.com>
 <20180824171432.GM5081@codeaurora.org>
 <153540005334.129321.18196967002233663397@swboyd.mtv.corp.google.com>
 <20180904210934.GA23990@codeaurora.org>
 <153609843656.119890.7258329648640765778@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <153609843656.119890.7258329648640765778@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04 2018 at 16:00 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-09-04 14:09:34)
>> On Mon, Aug 27 2018 at 14:01 -0600, Stephen Boyd wrote:
>> >
>> >Can't we just configure a different chained IRQ handler with
>> >irq_set_chained_handler_and_data() for each of the GPIO IRQs that are
>> >handled by PDC to be the interrupts provide by the PDC irq controller
>> >that match the GPIOs? And then set their parent irq with
>> >irq_set_parent() for completeness? And also move those GPIOs from the
>> >existing msm_gpio irqchip to a different PDC gpio irqchip that does
>> >nothing besides push irqchip calls up to the PDC irqchip? Then we don't
>> >even have to think about resending anything and we can rely on PDC to do
>> >all the interrupt sensing all the time but still provide the irqs from
>> >the GPIO controller.
>> >
>> Seems like the irqchips need to be in hierarchy for this to work, which
>> is not the case with TLMM and the PDC, currently.
>>
>
>Why? Does something mandate that the chained irq is also the
>hierarchical parent irqchip?
>
All the _parent() functions like irq_set_wake_parent() etc need
parent_data to be set, which is only set during hierarchy.

-- Lina

