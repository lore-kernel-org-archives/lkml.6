Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC40ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728E621477
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mC/UzfL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728E621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390816AbeIUWUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:20:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43722 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390405AbeIUWUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:20:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so6200502pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kLM+vWPHAhqDe9y2RTTQdqYtUW59IZ6Qpv9Pxy6TIuI=;
        b=mC/UzfL9yiOlA4dYfYcA53BWCz0U+5rK/9xD+gxrDuVHoK7aS8ziHqGCyw3quXhTRR
         GBcVBxqAI0RQyRwu+vTopERX7tOkTNNwmFFq4iEv0+G2OLo4DMG0ZZxIvVXMHmEyOfJW
         9ePYt5s6ipGxG+iTGeMxIHAPxxnbm6rgsLIo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kLM+vWPHAhqDe9y2RTTQdqYtUW59IZ6Qpv9Pxy6TIuI=;
        b=mmzHErpH4DmL2nNIEKMpVmUKR2/hXgrTGXdkJCa2VuM+bKYz6KtMijGQ7/1Pq2v/FQ
         w5MkfMymH+vyMMDiKVJYIq39e5a/fry3jnJ8Nzl4QY2obkNXAEMiaZA5lCdco4cvnPEU
         703yjkPBQaFVcYaBVuiSWQESyv/KT1ReFq1XU4pl2jBE2qW7N5ZmoURDtoUSt1nxBnSn
         o3Sl3I1sOvMWiXripNdHa8LVbw2FbnlTQiwgzGqGGK8+mbe0MRjHH158oq/pQFZW5mX0
         /EwwsQqZaiRU36FBRQlL3FV12pNQ2jtsSq/ZzNC0j+HhEYrVcYqtrBHoLwibb2eEbABG
         4aCg==
X-Gm-Message-State: APzg51CxWpaw7Qs/nkD97cTI8xXCwj2ystV3H1JguNpa0jGckQx2T/X6
        BYa1Ieu8Itmi8hpnQm27XMs6lg==
X-Google-Smtp-Source: ANB0VdaO6TYasCB7uMp3rOVTYbI9rBC37N+4g3+64SoC6WCNg9DyD38rN6eAeosrFBTnjDVzTDA7+g==
X-Received: by 2002:a63:f206:: with SMTP id v6-v6mr38602136pgh.319.1537547457975;
        Fri, 21 Sep 2018 09:30:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id a2-v6sm27052756pgc.68.2018.09.21.09.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:30:57 -0700 (PDT)
Date:   Fri, 21 Sep 2018 09:30:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] device property: Add device_get_bd_address() and
 fwnode_get_bd_address()
Message-ID: <20180921163056.GV22824@google.com>
References: <20180920223436.202454-1-mka@chromium.org>
 <20180920223436.202454-2-mka@chromium.org>
 <20180921042640.GA9222@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180921042640.GA9222@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 06:26:40AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 20, 2018 at 03:34:35PM -0700, Matthias Kaehlcke wrote:
> > +EXPORT_SYMBOL(fwnode_get_bd_address);
> 
> EXPORT_SYMBOL_GPL()?  That matches the majority in this file.

Sounds good

Thanks for the review!

m.
