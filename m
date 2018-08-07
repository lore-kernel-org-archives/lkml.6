Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E25208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gIn0OGKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E25208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeHGWjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:39:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39973 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGWjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:39:14 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so7577114plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kyb9bhMnPzFXUk8EMucKpoHNA5UclAq4bT2jpPG6ldg=;
        b=gIn0OGKhyCLGAJtTGBnxbg82uTESRamX06WpOzhM0pxWYkwzxL1g9qqfJRg/OqMCAe
         JMGku3TYKqvqS07sczv16LZpkq+/kEbg0xyNIpZM+ePcZmsJSuMB8/c3mKrIz90ZeHa1
         13l4XJDm5GgyW35JoNdWq/1/9NB9LSA1NRnKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kyb9bhMnPzFXUk8EMucKpoHNA5UclAq4bT2jpPG6ldg=;
        b=ACk5vi79W6PWtFSKnWqXiqlsUNJAAi1xEqQuoMmSTvZrM8kSpYK5ULDp/HPqT3qaxk
         5NYooT8ZWQJNxZcuMazcmNJOmSmQT6d2QAimlq2jOdt+ixla1Wvn6d3U99YY3DPE/ywp
         AFshNDhdpmJXrPQztdPAHbaKZciXk6tiA0Wu1ml6+kXq4RlX/tCrQq+ONyJq5FDuzzXq
         p1SYXQpXabn8mY7ULkR6LsJLh+zAKEBosUYQk1CGSXw409SggeqqIL3zKmx9mZxcJfIb
         VWq7mGW8cu9+S68p9vO6JlkeB7N2labQKltgebhct6L+4ur0on7gMRDRV4Bv4m08w6I0
         9clQ==
X-Gm-Message-State: AOUpUlHHhqjRFT/EDtkKCkOeZipB3dE5n6UaPo3PHOaXRSQJdiTFzHur
        FdTz22ocpSmlnad2UjZCAkfW6w==
X-Google-Smtp-Source: AAOMgpcGCJdQw+HsQDVwB3wHaOpYrjSWbCfM9oA1X23O1xMxI4qB9/CX0YZnihY4PVJemf9rAuKdog==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61-v6mr18783148plb.172.1533673387401;
        Tue, 07 Aug 2018 13:23:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id i25-v6sm7435446pfi.150.2018.08.07.13.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 13:23:06 -0700 (PDT)
Date:   Tue, 7 Aug 2018 13:23:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v2] ASoC: rt5677: Fix initialization of
 rt5677_of_match.data
Message-ID: <20180807202306.GE160295@google.com>
References: <20180807171940.150507-1-mka@chromium.org>
 <87753f10135e5f0791a6bfecb37ddecf7fd5b977.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87753f10135e5f0791a6bfecb37ddecf7fd5b977.camel@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:13:47PM +0300, Andy Shevchenko wrote:
> On Tue, 2018-08-07 at 10:19 -0700, Matthias Kaehlcke wrote:
> > The driver expects to find the device id in rt5677_of_match.data,
> > however
> > it is currently assigned to rt5677_of_match.type. Fix this.
> > 
> > The problem was found with the help of clang:
> >   sound/soc/codecs/rt5677.c:5010:36: warning: expression which
> > evaluates to
> >   zero treated as a null pointer constant of type 'const void *'
> >   [-Wnon-literal-null-conversion]
> >     { .compatible = "realtek,rt5677", RT5677 },
> >                                       ^~~~~~
> > 
> > Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module
> > sources")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> While this is correct fix, it seems it was never used.

Or it was used but no problem was noticed because .data was already
0, which happens to be the value of RT5677.

> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks

Matthias
