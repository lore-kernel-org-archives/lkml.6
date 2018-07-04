Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9810EC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DAD21C3B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWaUw2Ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DAD21C3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933978AbeGDH7u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:59:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39988 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933862AbeGDH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:59:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id t6-v6so4315437wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0QGMs7HtXD5lWWSQuELwwhd1MOFAqHkAZ0O0C12tmmM=;
        b=SWaUw2EwjNIZ09st0dA4qeYl3Muf+JZF3ERso/tEHxm/wP1tzgIP1JK/GiBVjSFY81
         Tvi0Y+mRXDENbJGvFCtOGoiMfSSm6LQ8Qa0Xrp5WCsTQopR0DD75BMEIsUG5JbB+X+cn
         WeHBa8gP+FMXQyOzKrNV3Ol0dtrZNadzI7buQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0QGMs7HtXD5lWWSQuELwwhd1MOFAqHkAZ0O0C12tmmM=;
        b=OVggO5JkI80JfWg3ZyB2oOiwV2aLyqXYjz0PsxJhfQ3Q30zaK0I4krYT6DrX9PrLWj
         AQ4xTGGHmw+OGtGOT9VbjHtk27zYpWYCbhHk4h6X3cZ+Ky9iIg/PuKBtp3pUFaturula
         8nkZ1wbqIh+lzS8D5qsQGZWN1JOjVPbK2dAXbx/2bXBIWXpCmqpYivcQqkp9OGr39tuw
         5EOLACkKJ6wonMgzAVZHs3kZ4zLMzfav4n+EeZJcpRYjq4HRRdeqelF8JfHeTcjV000I
         B0wlJZKWYFg1Ecst4ujzw9YIb8P9jF3cCtrgjedNjXk9ntjhMxWofVk2XV6YKOVakfCk
         y7Rw==
X-Gm-Message-State: APt69E1mNJfFXcDzlz1ErU6608juKcPQWP8aa1+nHt8Pj3NgS0jlB9H9
        +LIKw7QIllsmdGAKyq81HO+gtA==
X-Google-Smtp-Source: AAOMgpditkX9j7nurx+oa6w1o+wYeCdhbcE758jdixGLW6dVeQbol9+Z7weuKc2e++v/YG0tSZd3fQ==
X-Received: by 2002:adf:f64c:: with SMTP id x12-v6mr707706wrp.97.1530691186394;
        Wed, 04 Jul 2018 00:59:46 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id z9-v6sm5738580wre.49.2018.07.04.00.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:59:45 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:59:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 12/12] mfd: cros_ec: Add throttler sub-device
Message-ID: <20180704075943.GS20176@dell>
References: <20180703234705.227473-1-mka@chromium.org>
 <20180703234705.227473-13-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703234705.227473-13-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jul 2018, Matthias Kaehlcke wrote:

> Instantiate the CrOS EC throttler if it is enabled in the kernel
> configuration.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v4:
> - register throttler in cros_ec_dev.c instead of cros_ec.c
> 
> Changes in v3:
> - patch added to series
> ---
>  drivers/mfd/cros_ec_dev.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
