Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFD7C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EAA205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="csC9MP8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EAA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeIFRTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:19:34 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43038 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeIFRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:19:33 -0400
Received: by mail-io0-f194.google.com with SMTP id y10-v6so8681464ioa.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyoOiMh8n/n2Swbj7nokhtSH0jWSuvVY1+mh282a2NY=;
        b=csC9MP8g77NsR0mjfueWdBTDFLMsflYEwOSm2xSVdCdTYHlcHO6v47nxB/+CtIWsMJ
         OK90Opr7kJBAty9JeXLqoB6X1svyiGYvzMDsbA4Jg+AvSDCIIfzWkLtkOg98Qap/8U3f
         Yh30QUCoiF7MgTQX2XND7uNwY+1bmcZFwG9eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyoOiMh8n/n2Swbj7nokhtSH0jWSuvVY1+mh282a2NY=;
        b=POJp8lrGXTusViO0K7fQrl9t754rMDdBD8WUzyRrZIN7p6gGjvqrsJ34jIIwSOJ5g8
         /feEsIxIXd8jmWoNrM01EsSkE5/zl84gnOS0JP4xMJHaVOlfjH3xufw5D60p2HQ8h2UV
         dxQDg1zBdxEgfVBIw0VTZj6h4YLECq94cuENaesvjdjU10ze1Q797syPiB8+sOqipw7S
         /Ae35VzRXhn1S3GkK92pbQDq+rqkfGm4v4c541ExJtYyvfWq7RHVeWQI8rWcmfJXGnxj
         HKDfO4+Z6zICuj1GLhdjROCh+n9Qb/gw8diScf+EOUXo3lcs7U3MUOr+hFmBwwyZCNq6
         Sc3g==
X-Gm-Message-State: APzg51Add0/umOUneuwiq2PAAJs7g4TYv0DMpeHqH1SszTix0R3vKzzI
        Veps/D5FkLRPMmkJodKs9ib4Sm4LV0r0txW7NxwXMw==
X-Google-Smtp-Source: ANB0VdbzFxYU7VZZPsg7lA9QlrQPWkUTMtrL/BObyzeeJsObbGh5MOadRZI67TNOw+9mt+vEg1lyG+iyGDqzMHZNj0E=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr1613890iof.304.1536237853846;
 Thu, 06 Sep 2018 05:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180906115830.19386-1-colin.king@canonical.com>
In-Reply-To: <20180906115830.19386-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Sep 2018 14:44:01 +0200
Message-ID: <CACRpkdaHabhD_pW3XtDh+XzQ3d--r=qNRZVnhx44RV82p0boMA@mail.gmail.com>
Subject: Re: [PATCH] gpio: ep93xx: fix incorrect array element size check
To:     Colin King <colin.king@canonical.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 1:58 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the while loop checks for the end of the array using
> the size of egp->gc rather that the number of elements in the array,
> so fix this. Also, perform the array size check first as stylistically
> it is always good to bounds check on an array first before referencing
> the array (in this case, we're just computing the address of an
> element in an array so this is a moot point).
>
> Fixes: fd935fc421e7 ("gpio: ep93xx: Do not pingpong irq numbers")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Oh that was really neat code! Thanks a lot.

Patch applied.

Yours,
Linus Walleij
