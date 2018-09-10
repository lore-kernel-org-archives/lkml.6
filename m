Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E643CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4A820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kojpR3Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4A820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeIJURd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:17:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39773 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeIJURc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:17:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so21945113wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=o2+6QuFuPYVtss4qrBBfKdnO1uXNmUiRA+YR/yuOEgE=;
        b=kojpR3QytqWQjwgNCHmFjpsH89WV3yLqc1EaGMoYw6EgeIyjw8lY4XZ+kyMblEqgBv
         dEFQsvQDpO9ABnLu8tcC9oRm3sp+PpMiP705qQD4taaGJU7VAx7C0TfzqxuQzKDym8/c
         9GNTId2TcxKC+wrGYILL/45EptDA3WfifBZZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o2+6QuFuPYVtss4qrBBfKdnO1uXNmUiRA+YR/yuOEgE=;
        b=SR1KN19ruGWHXjVP6bMPLGGup86bCTZDi7r+gkyXVeTrRCy6eP9i89Z+0TpylYqgVd
         X6e5mrhZEu1EcF+RlLRVLMBjC+HrAdQBjAzOWdjPulAnTc2ExGZm/aC7798RPeLlO0ox
         reE6Bo4Ks1jIEv7ASDJS3stViQ0icPdH94Y+6iYWphzS4jvGAsgUhH5Xfctfk6CQAMuB
         3N3FF28CIsAlHo6syceaNYFw7f4Tly130MVfw1DDHADDtxEwYYuAot5G4JS3Nr03U9Mg
         0pq8bVPDWkVTrp/0weGKITm1qbJhyyY9cJlopl0d7dTlbL7z3JGgCf66EZVG7uJW0I7Z
         SpUg==
X-Gm-Message-State: APzg51AC2p+HEZ1bEIIMDJ4RVCdtjBmQz3ArauA7sjN9qwl3rYc6WmxH
        CALXLq74LzHP6Ug6RG0bjIU8c0qp/96qBw==
X-Google-Smtp-Source: ANB0VdbUMy+UG2M+BULziV3ga/iewzU5di3kN31ZYkPpKcDVpIgS+vim/uwEltGqu52a20zET454NQ==
X-Received: by 2002:a1c:cecf:: with SMTP id e198-v6mr1001086wmg.83.1536592975834;
        Mon, 10 Sep 2018 08:22:55 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id 60-v6sm18300191wre.82.2018.09.10.08.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:22:55 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:22:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: madera: Don't use regmap_read_poll_timeout to
 poll for BOOT_DONE
Message-ID: <20180910152253.GY28860@dell>
References: <20180827135115.24231-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180827135115.24231-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018, Richard Fitzgerald wrote:

> While polling for BOOT_DONE the chip could NAK a read because it is
> still booting, which would terminate the regmap_read_poll_timeout()
> with an error.
> 
> Instead implement a polling loop that ignores read errors so we
> always poll until the chip signals boot or the loop times out.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
