Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877DEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DED2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ah+aku9p";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ah+aku9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DED2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeHPX6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:58:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeHPX6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:58:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6F0EF61C34; Thu, 16 Aug 2018 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534453092;
        bh=ubBp/smHnMBbWbzpZeKIy1gr2qo8ktuVXznjB8re7vE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ah+aku9pVyIBh7RvQjuZYNosrXBB0KB6WboIrHhpgmDsy6pkOGTaeSaSZ+waMn6nB
         K+MQpIrSMX4/ZLXGpIjgnKO5egRhMTiF3juPPMFuQY0HOQya3Bdz9sWneW/80cWZUH
         FZGbZ2mQUitMi/7mK3Yp4XCuZSal3Kwe1R45DlVA=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C24761C34;
        Thu, 16 Aug 2018 20:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534453092;
        bh=ubBp/smHnMBbWbzpZeKIy1gr2qo8ktuVXznjB8re7vE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ah+aku9pVyIBh7RvQjuZYNosrXBB0KB6WboIrHhpgmDsy6pkOGTaeSaSZ+waMn6nB
         K+MQpIrSMX4/ZLXGpIjgnKO5egRhMTiF3juPPMFuQY0HOQya3Bdz9sWneW/80cWZUH
         FZGbZ2mQUitMi/7mK3Yp4XCuZSal3Kwe1R45DlVA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C24761C34
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
To:     Doug Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org>
 <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
 <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
 <aa2bd1f6-74b4-a63b-d115-88d6e16ed95d@codeaurora.org>
 <CAD=FV=WBw2SKgPq8Atb+SkziUku8p7N4GWemHYZZvoMSE0bK9g@mail.gmail.com>
 <20180815111318.GY2414@sirena.org.uk>
 <CAD=FV=VT6b1SmboyuBSGCnm17HTxxvAL8Hec23Dmc6Yfk5jYOg@mail.gmail.com>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <037cd5e2-0d3b-c20f-a444-99087b86706b@codeaurora.org>
Date:   Thu, 16 Aug 2018 13:58:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VT6b1SmboyuBSGCnm17HTxxvAL8Hec23Dmc6Yfk5jYOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

On 08/16/2018 01:07 PM, Doug Anderson wrote:
> I'll work on either adding more regulator_set_load() calls to clients
> or perhaps disabling the "regulator-allow-set-load" for a bunch of
> rails.  David: presumably if we have a rail that we never need to be
> on-and-in-low-power-mode can just be left in high power mode all the
> time?  There should be no advantage of being in low power mode for a
> regulator that is off, right?

Generally speaking, yes, that is true on both points.  The only caveat is
that there could be a minor power penalty if APPS votes for OFF+HPM and a
non-HLOS processor votes for ON+LPM for the same regulator.  This would
lead to an aggregated state of ON+HPM when only ON+LPM is really needed.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
