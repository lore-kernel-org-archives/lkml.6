Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA116214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA116214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbeKVGr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:47:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38070 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389024AbeKVGrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:47:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so5237426qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3RMZ9Tqg5MU+iTt+DglkqSPPJ9lbOgnYuS4GLTL234=;
        b=PqDNJk7zZcwD+bJ6BG2+XL4fWLaFtafc7pqyeCJ0uI43SkV8D4dlPk5LdWJBY+DQvd
         ELqxhRs3dobXcgegUqI4WjrARH/q4ewnbIau9fCnUK5jlDiE/qXVs/bW1mq2OT5/9fao
         TlCOPqH3NcjvJHYoVfXL9v+x/mOkxmLxQQqFrX8aBdrlF1/Sfff3toZYdVwrx2K7Rkaf
         fqXqq5WR+o+Z9TP4//kmS1mDhlZrSl9E/d2vJhuCEPrxnvuRbH8c4O33nkZzwNbRGBSW
         Ja7JzU6h6ahun4z0WNuxdUwPB9WB8/eJi5k0prW91hZNf1h5Q9RogWar2c518Liq0Tgp
         JcDA==
X-Gm-Message-State: AA+aEWbG7YUlRwrQEBBW6OAzqr44xl70amw4qMZCdLi7HzaO4wBDm9xB
        gcH8EohGnMMWnhKIp3HVJ/Tox9BD2LlLCP1ay2M=
X-Google-Smtp-Source: AFSGD/V3ZvD9qKMArKmBw6QfRbKFhZfMamTjmGRsFrE4vBBF48KR81oyWyTTTg589fjLcbOFQp2060ZOu/uACwUerwQ=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr4187549qtr.319.1542831128830;
 Wed, 21 Nov 2018 12:12:08 -0800 (PST)
MIME-Version: 1.0
References: <13D59CF9CEBAF94592A12E8AE55501350113CD10@DE02WEMBXB.internal.synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0B4CD5@US01WEMBX2.internal.synopsys.com>
 <9ffd1270-ad92-88b7-eb53-85c65fe971dd@synopsys.com> <f8c469e7-9e1d-18d6-4e56-ba4338462048@synopsys.com>
 <ebe7f165-2901-2885-0583-c7be53329372@synopsys.com> <4881796E12491D4BB15146FE0209CE6468198AC6@DE02WEMBXB.internal.synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA230750146415496@US01WEMBX2.internal.synopsys.com>
 <661a4323-5768-4977-5434-ab644c5418aa@synopsys.com> <C2D7FE5348E1B147BCA15975FBA23075014641580A@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014641580A@US01WEMBX2.internal.synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 21 Nov 2018 21:11:52 +0100
Message-ID: <CAK8P3a1Gszsg7Wky+7Z8TuOtAtZR2ia-QjYm01-wWKRmYfdm7Q@mail.gmail.com>
Subject: Re: Misaligned Access
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Vitor Soares <vitor.soares@synopsys.com>,
        alexey.brodkin@synopsys.com, Joao Pinto <joao.pinto@synopsys.com>,
        jose.abreu@synopsys.com,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 8:42 PM Vineet Gupta <vineet.gupta1@synopsys.com> wrote:
>
> +CC lkml, Arnd : subject matter expert
>
> On 11/21/18 10:06 AM, Vitor Soares wrote:
> > I use the follow function to get data from a RX Fifo.
> >
> >
> > static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
> >                         u8 *bytes, int nbytes)
> > {
> >      readsl(master->regs + RX_TX_DATA_PORT, bytes, nbytes / 4);
>
> So the semantics are reading the same fifo register N times, to get the N words,
> hence read*s*l is appropriate. That however expects the buffer to be 4 bytes
> aligned, hence your issue. You can't possibly use the reads*b* as we want the
>
> The obvious but crude hack is to use a temp array for readsl and then copy over
> using memcpy, but I'm sure there are better ways, @Arnd ? To summarize is issue is
> a driver triggering unaligned access due to the misinteraction of API (driver get
> an unaligned u8 *) which goes against expectations of io accessor readl  (needed
> since the register contents are 4 bytes)

Is this again on ARC or some other architecture that cannot do unaligned
access to normal RAM? On ARMv7 or x86, you should never see a problem
because the CPU handles misaligned writes. On ARMv4/v5, the readsl()
implementation internally aligns the access to the output buffer so it
will work correctly.

      Arnd
