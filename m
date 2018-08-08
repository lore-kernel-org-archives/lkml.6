Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354F5C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A9621A33
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTycoUZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A9621A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeHHTPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:15:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39175 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeHHTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:15:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so2258907lji.6;
        Wed, 08 Aug 2018 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sf4IL54k2KISelwdAKwtJAFLxQY1+92W3mD8o009Yo=;
        b=iTycoUZ1emUQFNsTGZgpUQ1FH+HAnpe7NtMf0DidbkF+FAE8Gq57OH8DZjW6jCyy+S
         EylQylHb+7UOINUHDbWCuxmrYYjeylu9IoL2SgRVFiCu6usP7hdCFAAf1SWWnJbY+sEO
         2Nk/nvCudIIk8OQHVQnuU/VB0l7KUS1KY9nqNTjGwCg9cPk1v1FYErH2PShPMNtpUlZi
         HQL+U+3r1ZyjoYImmOwoMOknO9ollfVDZuMXMozxZDo7osIrVtiJrCzRo91zBTGnhU12
         2Sc83Xz5/1G13OOlrE6PMYLJXn4ZEtEomBmjyjKItS6de/vyIpnafJanz6gN0WtAKOlL
         3V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sf4IL54k2KISelwdAKwtJAFLxQY1+92W3mD8o009Yo=;
        b=WWxT0WH9t7NLbHiLwW+TZc7aq12O3jxoKrTX4UAAX5vqZJbJNVUSW8tN0GdDe9vGyi
         dB7rCvgh/9WPVZG7luvI7BaojJKFoO59f2Ck+YMOkpTo0IoR9Gv6ATorLMYngNBr1SA+
         pmG6R9a/tdXa9i+e//lcsLLdXdhTUsHWBxAfnUZ+kTERNOsPss6uN3sCAZGgTOsXEc0u
         Bs5bpNplPdWkgMXdH7INtIJm+50Sy+c4VDrXfItw2hD7j6z1cxHKoWo4OeoyxI3ZDIwD
         6VM9ST8yhk91R9fgw4WIklu2G12KmcN8p+tIbar1xIBZk8ZUmo0IivsOVML+YYnKccSz
         vG6A==
X-Gm-Message-State: AOUpUlG05d/8STRkw7BdIJD9C6IY9wT9Db+oIiSDWXcwxT8tR0QYk/uO
        eYjbqBFczlDgD6i8zwgP82c=
X-Google-Smtp-Source: AA+uWPxWmAKr2j5LFLcriuHZq5EeP+dfWxj3ibOXWeRQ83HApzZtnqGWqtj/uXcHnFztzn9wOSFQkw==
X-Received: by 2002:a2e:2ac3:: with SMTP id q186-v6mr2489272ljq.123.1533747275321;
        Wed, 08 Aug 2018 09:54:35 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id g3-v6sm896029lfk.72.2018.08.08.09.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 09:54:34 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        linux-gpio@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port direction once per transfer
Date:   Wed, 08 Aug 2018 18:55:35 +0200
Message-ID: <3260564.acbQT1CZaz@z50>
In-Reply-To: <20180807205752.32cd3e53@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-8-jmkrzyszt@gmail.com> <20180807205752.32cd3e53@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tuesday, August 7, 2018 8:57:52 PM CEST Boris Brezillon wrote:
> On Tue,  7 Aug 2018 00:29:13 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > In its current shape, the driver sets data port direction before each
> > byte read/write operation, even during multi-byte transfers.  Since
> > performance of the driver is completely not acceptable on Amstrad Delta
> > after it has been converted to GPIO bitbang, try to improve things a
> > bit by setting the port direction only on first byte of each transfer.
> ...
> I'd suggest a slightly different approach where the data pins
> direction state is stored in the the priv struct and only changed when
> required. This way you just have to add a test in
> ams_delta_read/write_byte().

Good idea, I'm going to use it, thanks.

Once done, may I also move that one earlier in the series so that it can be 
applied while our discussion on GPIO bitmap changes still continues?

Thanks,
Janusz




