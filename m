Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2CCC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D377206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1QradOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D377206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbeKUDjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:39:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46626 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUDjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:39:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so2275550ljh.13;
        Tue, 20 Nov 2018 09:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6pTolY5fBaArEwysL7aNl8s8rq9lJuVGpA3jmobaelg=;
        b=L1QradOmxRCJrYHyaDm76U1qi08YKvXhoOCqz7dJs8S8GpYPAuJpI/KXHPqJKV0BCF
         g9sZkPl+yzOhO7+Dfn4WC4EMCB/26lh9bug1/wp5hHCAN7V06QjogudMMsrhuCjyAsom
         QVFjgU475ty81TOfDD7k7RgP5ZecOTCvdyJeBSSwLy+0pZb7RjIL2lEdAMluCSyJoizG
         QIyrpZyczFrdp+vOzprRGLb74hgWQTluzefKQmGlT+zfSSUqu9S8MmPOomMmbetLHiUh
         gKBLbixGnBdurnqQUOHmOm1vke/gPhQfCnwibvR7BOIvgGSHfklQIPiyhpe7GfJjwgpx
         SSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pTolY5fBaArEwysL7aNl8s8rq9lJuVGpA3jmobaelg=;
        b=t756VryuvVMB2BdE7x9DFBJTtZ5LhgXwbGLcv8srIxlST3Awe7EoIzWuuhzhH5H7+6
         UnLOIOCZ1JyMGOZfDqDqxeTrjwjfKFBh/9Sr3sp9nnzbCS/IaP/GuGAjYkR/HJfrQ9CV
         S8tiE8OM+dB/gCRlcVmZ3GFZSe3OeQG+qceLLpSv8INDpVno8Z70pks9IU1DYo8nMw/e
         kZXkIfSb+dCFpmuEdTiLnB2o37VrQpWFbZiSS0ew+7dfxzo1puDlRBY4xw72CzjDVXFV
         f8H773uokRzoyjAywAf2dfluvtXvNJUWqpGu7R8xilONeA262Bhkz8Qfnx+iM+SlxiR5
         92hg==
X-Gm-Message-State: AA+aEWYAO5Sozp7ucVb2BPYe2fpdAOjbfV7PO3Jb930PSK02QBWwjlhz
        6vgCLNJ2V5gyTj3YYgFnscw=
X-Google-Smtp-Source: AFSGD/UUbvdN4K8sjoh2xbxu2dXTZ3ENWI0nBht23mfP9lKDw3lGxKFsslMR923qg7dS2qxcf6rj3g==
X-Received: by 2002:a2e:8156:: with SMTP id t22-v6mr1027230ljg.32.1542733758766;
        Tue, 20 Nov 2018 09:09:18 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2522211ljk.53.2018.11.20.09.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:09:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gP9WY-0003mB-6o; Tue, 20 Nov 2018 18:09:18 +0100
Date:   Tue, 20 Nov 2018 18:09:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] serdev: make synchronous write return bytes written
Message-ID: <20181120170918.GH19900@localhost>
References: <20181114150904.19653-1-johan@kernel.org>
 <20181114150904.19653-3-johan@kernel.org>
 <CAL_JsqLuF-t_Rf5Hh400=aeiLT_ahTfE0a_czZ6XRG-mD9xmig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLuF-t_Rf5Hh400=aeiLT_ahTfE0a_czZ6XRG-mD9xmig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:15:37AM -0600, Rob Herring wrote:
> On Wed, Nov 14, 2018 at 9:10 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > Make the synchronous serdev_device_write() helper behave analogous to
> > the asynchronous serdev_device_write_buf() by returning the number of
> > bytes written (or rather buffered) also on timeout.
> >
> > This will allow drivers to distinguish the case where data was partially
> > written from the case where no data was written.
> >
> > Also update the only two users that checked the return value.
> >
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/gnss/serial.c     |  2 +-
> >  drivers/gnss/sirf.c       |  2 +-
> >  drivers/tty/serdev/core.c | 12 ++++++++++--
> >  3 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> > index 31e891f00175..def64b36d994 100644
> > --- a/drivers/gnss/serial.c
> > +++ b/drivers/gnss/serial.c
> > @@ -65,7 +65,7 @@ static int gnss_serial_write_raw(struct gnss_device *gdev,
> >
> >         /* write is only buffered synchronously */
> >         ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
> > -       if (ret < 0)
> > +       if (ret < 0 || ret < count)
> 
> The 2nd condition covers the 1st condition.

Actually it does not; ret is signed and count is unsigned, so this is
needed to catch negative errnos which would otherwise become larger than
count due to integer promotion.

> Though I guess this will all change anyways when you address the FIXME
> below.

Not sure about that yet. If wait_until_sent is interrupted the data has
already been buffered and we need to return that count. So I think I'll
just drop the FIXME.

> >                 return ret;
> >
> >         /* FIXME: determine if interrupted? */

Thanks,
Johan
