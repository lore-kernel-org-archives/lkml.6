Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E454AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7364206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CUusFWFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7364206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeK2Deu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:34:50 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:35332 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2Deu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:34:50 -0500
Received: by mail-pl1-f172.google.com with SMTP id p8so7345465plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=RkGRvaP7pt2XjblG8B+TkNrAtFvT4aT+DbdycSXiqRY=;
        b=CUusFWFn10L4e8zfHw1SFyw+HriDiirTehBNME3tq+7ZDq7wAsTXoxKI9b1xycH5w6
         LeNoPkC4cLX0vRXgei2i7+7Eo93mGY/5qilACkjCpCqGfGfovI+0pGmVid1/W9GsHYib
         b52fqWYAQk9OVDkZ9zUtnCqTt+gltKQejhFpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=RkGRvaP7pt2XjblG8B+TkNrAtFvT4aT+DbdycSXiqRY=;
        b=Syno9Xzt73S3ORy06itVA3EiHb3VmqTpG5J++NGMZskIevIyzU36Ixy8IzTLtGXCl5
         mu6Ju/V0CVm49dVJ5kjkIsUo/1Q6S5bYuiDAsi/fFY1TQjxGHM8mq1on701qCw21CvSE
         MqdBQiyEpDFxaIiIftIfth2rHUczCoscn2heWRYODqOP79UnuJniTXWvE12Imnt+kKHs
         OBKmqxHw+ed9Lyh+iRW6qsSj+iX1KKsL93nwX3PGGsZOcP5ECbp9G7eODoFdPRuAvmS7
         QQRaSE0zPUIYTPv+PpvYSXKg/fvS4hnfHNz+D32TxwZzbBCRXr1xwCdHfdsRSiAvMYwb
         QF3g==
X-Gm-Message-State: AA+aEWZ2JaherwZ/LG2K3r/ceb1t7z8LR4pyDjstfINVe3pQXP4yS/QW
        dYd5+e0x9g4OWsmJ2FxePe02+g==
X-Google-Smtp-Source: AFSGD/X9rjb+ImJD68vkCniDDSd7cbfZsU1ZhbZlOAYedDO6btRz9e51ER2nyzHqyOBuiv7oGb/FLQ==
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr38432898pln.229.1543422756542;
        Wed, 28 Nov 2018 08:32:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id b2sm12517289pfm.3.2018.11.28.08.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 08:32:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CACjz--nbtoHA3ejeF+es4q5qsyYeoLRbUsd+a0r2RYfkuVVwPg@mail.gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20181127022536.104663-1-ryandcase@chromium.org>
 <154336440880.88331.11610393939844825622@swboyd.mtv.corp.google.com>
 <CACjz--n6eXtT6-CDhVEStSD_59yJ-fdmfHzo9SH_da5ZzL_mDw@mail.gmail.com>
 <154337068886.88331.5708018437286125025@swboyd.mtv.corp.google.com>
 <CACjz--nbtoHA3ejeF+es4q5qsyYeoLRbUsd+a0r2RYfkuVVwPg@mail.gmail.com>
Message-ID: <154342275484.88331.11625853632580952641@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix softlock
Date:   Wed, 28 Nov 2018 08:32:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-11-27 18:37:15)
> On Tue, Nov 27, 2018 at 6:04 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Ryan Case (2018-11-27 17:24:44)
> >
> > > I hope underflow is impossible as well. However, if the hardware did
> > > wind up in a strange state I wanted to err on the side of not throwing
> > > away data and being able to resume later if things recovered. I can
> > > remove the defensive checks if that's the custom, otherwise I'll
> > > update the comparison logic accordingly.
> >
> > Well it looks like impossible code because an unsigned value can't be
> > less than zero. So it's not about customs, more about dead code removal.
> =

> Agreed on the current dead code aspect which is why I offered the
> option of updating the comparison logic, but I can just delete it if
> you want.

Ok, got it.

