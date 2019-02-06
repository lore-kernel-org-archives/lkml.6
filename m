Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79029C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4CE218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BEUvPIY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfBFH1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:27:37 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35118 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:27:37 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so4106850itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 23:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uBYoHozO8PAP4li51yx+Q5uT8p3LsgrZ80SJMlNtt0=;
        b=BEUvPIY6FKX4cUblYV2sd8KUyVcgNXTlhY4AJs0zC8T6GM3T5Py5yTPXAgRrBH423v
         JY7pnGMYxR1c0Ws6S6vkEX/VYdccoGbj3+FwyposD4ki0XPn9URyWYBP3lyHStzny3uZ
         1Dy+yPKqFcCeXLO6glFTiiuQ6LcTwceiwgDJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uBYoHozO8PAP4li51yx+Q5uT8p3LsgrZ80SJMlNtt0=;
        b=XjuiOxoGhbtHajpGBeeL2QxGH5fYoy3rJDPqpUqwIXLNyz8z+4LCvaAKAMMCjmrAv8
         Oi7uvo/RTVg0/sVmaUrmBPCjcxbJrgSs8uIwjetjKHxmvEuLb8bPxK7g3PBdSzrVglrP
         D2RFHo2MQDiu86xpIcwBB5B7EVk5JPYEVugQ5rHkptzI386LMa5j+4wdC5WQDAGjbp4B
         HCNqiuIUtWEI+bfLGp+g8FXpU973ex+P6xTW0sNlcchMGcIQ0EdtNKdZO8VUK0RtCAhh
         bo+1eLuLdmSqFSxbXnIy2hQLh6cDEwacMMnjaQKlYnnIYzWZunT68U0zuPt2rVPMEhBT
         tV7w==
X-Gm-Message-State: AHQUAubA5UAvU523o5ZoC4GqMMc1FyGWSdWbfnETY3STubwm26v5kKh0
        qafklamdWawuW0FxYRunGN6dP9oD9EvswfV6tJg2cCH7/jKjX0Ya
X-Google-Smtp-Source: AHgI3IZdSLqf7KoSgn5TNfmglO30HzroYvvbesi2ABQaC+1XvMqaameTtuHVSL94j86o7cGcaawoo6NzkHFvfFoejTI=
X-Received: by 2002:a02:1c41:: with SMTP id c62mr4516225jac.109.1549438056578;
 Tue, 05 Feb 2019 23:27:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549385784.git.renatogeh@gmail.com> <786543cbd8d60776083bcaca66f83502f23f561b.1549385784.git.renatogeh@gmail.com>
 <alpine.DEB.2.21.1902052054330.1726@vps.pmeerw.net>
In-Reply-To: <alpine.DEB.2.21.1902052054330.1726@vps.pmeerw.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Feb 2019 07:27:25 +0000
Message-ID: <CAADWXX-nxpVxPmwsKKqeNHZY1OWF=a1YB93Y9g3w87zPSa5=CQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] staging: iio: ad7780: add gain & filter gpio support
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

 this email was marked as spam for me (and probably others) because of
this DKIM signature:

   DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pmeerw.net; s=mail;
       ....

where the problem is that when the message goes through the
vger.kernel.org mailing list machinery, the header whitespace will be
modified.

As a result, the DKIM signature no longer matched, and at least gmail
will consider the email to be spam.

That's arguably a bug in the vger mail server setup, but equally
arguably the "c=simple/simple" model of hashing in DKIM is just
broken, and shouldn't be used. Whitespace in SMTP headers is simply
not meaningful, and checking whitespace in them (like simple/simple
does) is misguided.

If you have control over the DKIM setup of pmeerw.net, may I suggest
changing the DKIM setup to use "c=relaxed/relaxed", which doesn't
invalidate the signature just for whitespace changes in the headers,
and which is the proper DKIM model to use. The simple canonicalization
really is too simple-minded for  email.

            Linus

On Tue, Feb 5, 2019 at 7:58 PM Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
>
> On Tue, 5 Feb 2019, Renato Lui Geh wrote:
>
> > Previously, the AD7780 driver only supported gpio for the 'powerdown'
> > pin. This commit adds suppport for the 'gain' and 'filter' pin.
>
> comments below
[...]
