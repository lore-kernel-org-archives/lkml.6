Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3842BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D804021716
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M81zTK/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D804021716
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeHHGI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 02:08:28 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35308 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeHHGI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 02:08:28 -0400
Received: by mail-yw1-f66.google.com with SMTP id s68-v6so601441ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 20:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sA0iGr8g1qqk1B4znxVI54L4La5Qk/9XYIdTm9Zmgkw=;
        b=M81zTK/mt3MWlxmRROhydVAxcGa+mXkTJBnvoFXpQPRX2E2+9buBgU9VhcXFo7olUE
         T06InwaY3rgeAnBtGPjRVbBHbCy72Jc6En1rzQtAQdmWUpiJekDiIsOU+JMaD7/OjIMB
         KL38HfeJziY06zS+pj0XvMfSN4K2QOrCkdrXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sA0iGr8g1qqk1B4znxVI54L4La5Qk/9XYIdTm9Zmgkw=;
        b=DaXnX32YP1iSIlE+jP6lOLOdfRVwLPqZUHjV2UqXuwVZQOcHVwttH8N62IVbGnyn3J
         JrSnYghqjWmG98g4Ju6u4DQ/gAJbCo4lJEEA69HWSWgQ+Yq6nCzG3+DPmhegzlbqKjgt
         I34hBiLdm3ImFpFiICMUlyxojZ1f/WTXTYIiB2G3PsHu9+ShqZMJ/sTEsaGHupxLJVnn
         dnuGboS0e3fXGS3uTi/x3C4vQtA/joH5bqex3eyRFRQiauQ2BE/35Y2+BeSPyc8vFRi+
         1mSk9x8NP/28qM7Ex8ZnzMo9DlKsqGTQp8jgbthOoQg/0wQw5jAhntH6SEXFIERbno9V
         1nIw==
X-Gm-Message-State: AOUpUlGCIKGKD2V17ND5xqG5LTYuCN7yOwLnbrhYM6TvpIuNpoSw6c9m
        A84skxnngh5bha1IazR8NBaQznPJi14=
X-Google-Smtp-Source: AA+uWPwKtv5zq4Ddi7OdqNJV/A63x5Ogj4IGIRjzGlE0W0O3LjdYpPYCS55LMVggB1r5J504QqxJeQ==
X-Received: by 2002:a25:31d7:: with SMTP id x206-v6mr554021ybx.440.1533700252319;
        Tue, 07 Aug 2018 20:50:52 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id o204-v6sm1325153ywd.16.2018.08.07.20.50.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 20:50:51 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id y203-v6so586077ywd.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 20:50:50 -0700 (PDT)
X-Received: by 2002:a0d:ddc8:: with SMTP id g191-v6mr597307ywe.145.1533700250360;
 Tue, 07 Aug 2018 20:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.3cb9065dabdf5d455da508fb4109201e626d5ee7.1522168131.git-series.kieran.bingham@ideasonboard.com>
 <cae511f90085701e7093ce39dc8dabf8fc16b844.1522168131.git-series.kieran.bingham@ideasonboard.com>
 <CAAFQd5CQEhmuLbs0dmGfu66x1Xq1V_kOT0bV_DoPitkkOX5Q4A@mail.gmail.com> <15196240.O2E9MK7q6s@avalon>
In-Reply-To: <15196240.O2E9MK7q6s@avalon>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 8 Aug 2018 12:50:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B613JJLK4drTRYT=qP+wZriMt4afAgXKvBgEU4H0vtOA@mail.gmail.com>
Message-ID: <CAAFQd5B613JJLK4drTRYT=qP+wZriMt4afAgXKvBgEU4H0vtOA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] media: uvcvideo: Move decode processing to process context
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        olivier.braun@stereolabs.com, troy.kisky@boundarydevices.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Aug 8, 2018 at 8:12 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Tomasz,
>
> On Tuesday, 7 August 2018 12:54:02 EEST Tomasz Figa wrote:
> > On Wed, Mar 28, 2018 at 1:47 AM Kieran Bingham wrote:
>
> [snip]
>
> > In our testing, this function ends up being called twice
>
> In your testing, has this patch series brought noticeable performance
> improvements ? Is there a particular reason you tested it, beside general
> support of UVC devices in ChromeOS ?

Some of our older ARM devices have external USB ports wired to a low
end dwc2 controller, which puts quite strict timing requirements on
interrupt handling. For some cameras that produce bigger payloads (in
our testing that was Logitech BRIO, running at 1080p), almost half of
every frame would be dropped, due to the memcpy from uncached memory
taking too much time. With this series, it goes down to bottom ~10% of
only a part of the frames. With one more optimization from Keiichi
[1], the problem disappears almost completely.

[1] https://lore.kernel.org/patchwork/patch/956388/

Best regards,
Tomasz
