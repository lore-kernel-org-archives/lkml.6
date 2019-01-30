Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13401C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D268B21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="obLhhUb7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G6w7ce3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfA3RDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:03:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731582AbfA3RDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:03:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C58B06178F; Wed, 30 Jan 2019 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548867798;
        bh=chv1ZsyefievX4IQ6lKo/jLYLZ/FqFCJNXRdqkAqn24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obLhhUb70Bd9m3ubt+PdNYaSaPJHCpsYLhkU/E3+OUEfBu0K0zwOF813T0f/6tFOq
         Tx+Q4CuVsqG/fQ4DnXBytgBa1QMRBKwH4GDYfh95GgPvf0mMuMgc8TsWjR0KC+0XJl
         pUVya2d/20SX110UYNrB03ZAZMqx0HCQQr9IbI3U=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F94D60B0D;
        Wed, 30 Jan 2019 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548867795;
        bh=chv1ZsyefievX4IQ6lKo/jLYLZ/FqFCJNXRdqkAqn24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6w7ce3tyUz94r2PK+Yu5TcwJRt+4WkW8Q/KuEAFbDbzrej9s+u8YFcoCtNzRkhyv
         JUhlvkU4GhcdWsVppTttFjRvRD+pol6AWkvFmPKjECMwOJrJtscX/8dFs86g7tCjqG
         6nIUh7yJmwdrynpar8zi05axB6SFQY3TPGFd/AnE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F94D60B0D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 30 Jan 2019 10:03:13 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 0/8] qcom: support wakeup capable GPIOs
Message-ID: <20190130170313.GA6069@codeaurora.org>
References: <20190124202205.7940-1-ilina@codeaurora.org>
 <CACRpkdZVrwviuXo_3epzDTacrYRnyTAWOLKSpNG7j_0Fv8CkEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACRpkdZVrwviuXo_3epzDTacrYRnyTAWOLKSpNG7j_0Fv8CkEg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28 2019 at 07:19 -0700, Linus Walleij wrote:
>On Thu, Jan 24, 2019 at 9:22 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
>> This is a bug fix submission of the v1 posted here [1]. The discussion on how
>> to represent the wakeup-parent interrupt controller is on-going [2] here. The
>> reiew comments in [1], from Doug and Stephen are addressed in this patch.
>>
>> The series attempts to add GPIO chip in hierarchy with PDC interrupt controller
>> that can detect and wakeup the GPIOs routed to it, when the system is
>> suspend/deep sleep mode.
>
>I kind of start to get the hang of this now. This is starting to
>look finished. Some words on the hierarchical GPIO IRQs:
>
>I have started to look into hierarchical GPIO+irqchip since
>the usage of such is spreading.
>
>I have been on to Thierry patches trying to make him implement
>more generic helpers in the gpiolib irqchip library functions.
>
>In short I see the following:
>
>- Hierarchical gpiochips all have .alloc() and .translate() functions
>  that look more or less the same.
>
Yes.

>- They all fall down to remapping either tuples or entire ranges
>  of IRQs from parent to child with a linear look-up table on
>  allocation.
>
I would think this would be the generic case, unless its QCOM, where we
would want to push the tuples up hierarchy :(

>So my idea would be to add support for this into the gpiolib
>hierarchical irqchip helper: by supplying a parent irqdomain
>and a list of translation tuples, we should be able to handle
>pretty much any hierarchical GPIO irqdomain (famous last
>words).
>
We would read the tuples from DT? Also please consider Rob's idea of
specifying hierarchy from [2].

>Right now I am converting the IXP4xx platform to hierarchical
>IRQ from the ground up (it is not even using device tree
>so it is a bit of a challenge) but it seems to be working.
>
>So I will try to post this in some hopefully working form, and
>on top of those changes or before them introduce some
>helpers in the core for hierarchical irqs. Or I fail.
>
Thanks, please copy me on the thread. I would not want to miss this.

>Anyways, I do not think my ambitions for refactoring the
>helpers can stand in the way of support for these use cases
>and new hardware, so maybe we need to merge a few
>more hierarchical drivers just bypassing the gpiolib
>helpers. I don't want to block development, and I suspect
>Thierry might be getting annoyed at me at this point, so
>we should maybe just pile up a few more hierarchical
>chips so I can refactor them later.
>
>What do you think?
>
I attempted refactoring the .alloc and .translate and for a generic case
and it seemed like it would fit the bill very well. Will await your
patches.

Thanks,
Lina

