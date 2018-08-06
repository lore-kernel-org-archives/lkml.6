Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDCFC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD8821A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lRHJ67w3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD8821A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbeHFUkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:40:05 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41787 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeHFUkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:40:05 -0400
Received: by mail-ua0-f193.google.com with SMTP id h1-v6so13257682uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SD6ubV8kdzgVl0QplwbfcwYl/70D4sRohSHI4b0vbO8=;
        b=lRHJ67w3d9Lk+XAF3xQUKpWrgZUA+5roo8bATWL3ZNxzckZZqOxGBh+Lc5G4os6VOZ
         9KLFXGS4/McH6TOrPsMNjUnOxHy0Ep24rI6eJ+sZcpovRRtSAQYKoH5VyY0/qk11BtSM
         pHCaI9tSgHxFsPC27NTnBkkRy/yC/Hu9vcUJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SD6ubV8kdzgVl0QplwbfcwYl/70D4sRohSHI4b0vbO8=;
        b=FA7ZqV92KFDgHcftVzYRHFBHwYy9HecK+g0/pqLxxvfTEV+2m2jYcLRfQ1NNPjqorN
         VCn8p4eF8hVw42XRi6hCaDp/hRWDVuZ9ZM/doJQ2Q/YPbLh61TIOahIWFpzH+t4d+Te9
         PygvyY6LPX/QPZB1B7wBLtJmYTXcmZjAZBfrvZY566dDor812mf2XBQzgxHdyh0+zJdr
         UxmqztNns0dKQBcRYEizNB/ooC+euSegvwvEOZbS+9JaYUp2zZBWQDYpidxLRSbhL+Do
         V9WTQQokeEcmkMsihkSvTrzVFbXams+ddC8qtUHE7Etb6mZRPdb9mDN9CMCGL3vxtflq
         vdqg==
X-Gm-Message-State: AOUpUlFMhXwVAs9QzQi/SgFBadkd1VGyEkA2rCXliB7R/4SyMP6Q8oGH
        d3HXiEFMT/eFHMPovA9v9nizMcZ4o2WqZ5DIwk4nhQ==
X-Google-Smtp-Source: AAOMgpeeyTN6A4i4z9SuzD5KDB+vKNL7/BDwFKmrUh1WwyIbzZwXBF1KeGkEY/37DoYgypG5r2wCcVJeLv3+DqbGmEg=
X-Received: by 2002:a1f:b449:: with SMTP id d70-v6mr10052513vkf.160.1533580185602;
 Mon, 06 Aug 2018 11:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180806171047.227835-1-swboyd@chromium.org> <20180806173806.GA26374@ban.mtv.corp.google.com>
 <153357873656.220756.13862913888448347196@swboyd.mtv.corp.google.com>
In-Reply-To: <153357873656.220756.13862913888448347196@swboyd.mtv.corp.google.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 6 Aug 2018 11:29:33 -0700
Message-ID: <CAODwPW8GiP+qnQstu1ZaK0MUygopY8V3N+6T6WHZaHAk8xtJ7w@mail.gmail.com>
Subject: Re: [PATCH] firmware: coreboot: Let OF core populate platform device
To:     swboyd@chromium.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, wnhuang@chromium.org,
        Julius Werner <jwerner@chromium.org>, samuel@sholland.org,
        Thierry Escande <thierry.escande@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick fix!

Reviewed-by: Julius Werner <jwerner@chromium.org>
