Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27AEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957E820693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tpn5Zu7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957E820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935570AbeFRUMs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:12:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45392 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933036AbeFRUMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:12:46 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so8016131pgv.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yvdaya7a/2HhJ4PEAF54f+SXcLTnLYrjMaGWgLllqtc=;
        b=Tpn5Zu7oNNrNfVytp1meuBl2b7ikgTOvi9sMiKZ8TTE1NHCGh5Sp1tSY99FK8JY4TO
         tA30g+OL8awOIBx3lzjQSoOQcrHR4GqcBGPSuM2ee3CDzvDbo4uvbXkrCA3R0UZWbzvX
         VOqgSwoPGF5JAU9aOxWSuwPmj+qFWptWyWWoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvdaya7a/2HhJ4PEAF54f+SXcLTnLYrjMaGWgLllqtc=;
        b=BOnP3o9DcO5bQLNrbpG1q8w/qwdwYm9S0TXzS6ytvTnVW5WQR6g8mQsdXqCcNW9z5x
         Gj19PksM0ozx5Ul8kyZJLxOTYZj4T3dcol5UEqZClrumrtDTrljSEtuUXI0cxo3Mmw9T
         uDcfDJlohHpOInnUlQPzasmBtAfTY6CBZ+dtoiXSkj5+BQJ4/6lW2eyu7bVx9i6Ai8Bh
         Wc11yn7InLku+QIjWbL3g0fd3KYWIflpPFdGErh86yW20eQhYKCsZrTot/2/s+y8fWDJ
         Me1ryuMZ6M65R09T6g8iOfsfIMnYSxiRmvOBNKe2k5wYHSxENaBjyWQmJhzRhtTw6v9g
         WhMg==
X-Gm-Message-State: APt69E3nYCkxUFPj0+Wu69rzpO8zIU6V/Y1DyMtPCa5oVpko4t45wKxB
        O+f7Fgef3VWtHjJ16xV2m+oWcw==
X-Google-Smtp-Source: ADUXVKLd9w6Bnq5Cvn0n3Cy6d+vKtnx1W0JTFfeWCxngPQRFiedBN9J2gk2QRj9E55k0YJcpFKv/3w==
X-Received: by 2002:a63:6fce:: with SMTP id k197-v6mr12302624pgc.307.1529352765755;
        Mon, 18 Jun 2018 13:12:45 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id 8-v6sm27310746pfk.132.2018.06.18.13.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 13:12:44 -0700 (PDT)
Date:   Mon, 18 Jun 2018 13:12:41 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 02/12] PM / devfreq: Fix handling of min/max_freq == 0
Message-ID: <20180618201239.GA153862@rodete-desktop-imager.corp.google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-3-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614194712.102134-3-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 14, 2018 at 12:47:02PM -0700, Matthias Kaehlcke wrote:
> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
> devfreq device") initializes df->min/max_freq with the min/max OPP when
> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
> available min/max frequency") adds df->scaling_min/max_freq and the
> following to the frequency adjustment code:
> 
>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> 
> With the current handling of min/max_freq this is incorrect:
> 
> Even though df->max_freq is now initialized to a value != 0 user space
> can still set it to 0, in this case max_freq would be 0 instead of
> df->scaling_max_freq as intended. In consequence the frequency adjustment
> is not performed:
> 
>   if (max_freq && freq > max_freq) {
> 	freq = max_freq;
> 
> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
> when the user passes a value of 0. This also prevents df->max_freq from
> being set below the min OPP when df->min_freq is 0, and similar for
> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
> checks for this case can be removed.
> 
> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

FWIW, I've reviewed patches 1-9 (the core devfreq bugfixes and features,
and a small cpufreq helper fixup), and they seem pretty clear and good
to me, aside from a minor error in the current subject
(s/devfreg/devfreq/). So:

Reviewed-by: Brian Norris <briannorris@chromium.org>
