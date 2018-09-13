Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D27C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F81E20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVX6O5Jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F81E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeIMO0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:26:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36184 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeIMO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:26:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id v26-v6so4013993ljj.3;
        Thu, 13 Sep 2018 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9n8a+xz+Oz2i5BEr3vB5jMf6qCXGeM6zAfVFMP1APJg=;
        b=pVX6O5Jkqa9Yjmm9POcJglHOgs2fYLSBnpz14Dpx/MLJNQNQ9XSnN2XQC4qkVwLgrw
         6q08ayb6OflqcemjVEnSzEAyFSZ7W6Atqdrsz/68tgG0yl++BIyzv41vONmm308P5Yte
         +ETj3A82LIFaPWB2CC19W4g15LO/9r2gNy6TaV+DWaaT7ACDlsSnwfKJyQbcrgrWgVq+
         TtayA2XjF9cSwq8W4KCpH81OeKcAsznFXMBgMiq8wFxwKtR5O6LMjForbhQ30+qzKUFs
         HhRZPLD8g13n6a0ZnN9WziTu6m/ZwuSFsIkVeCsgdgXkJz9wyabTzAFREPuAOFDaX8I4
         2ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9n8a+xz+Oz2i5BEr3vB5jMf6qCXGeM6zAfVFMP1APJg=;
        b=FjIsfeYpgphi9uyW7rJQBrofH8CGTrkHj67E1bhAgeENGa9VGQJhf5aWWmUuPZ50cI
         byDRET+XkXdCkxPgVwb2NDbsmjmRws96cVhWPrLzWtZo+WbRX9saSM6ezu4ZBqHDIcy2
         7mHg9JlgbgPKqjQhh6Zwz2kFWDFQMsQBdwqq1fkpgqr3s75ob2e2FK5zPkJmmSjyktzr
         CbM7nuIDE0OWOohLIhE2RAgLVCjDDBZzXozOVG3foWt18nZvvx7ZO9DA5QE/idWwcb6P
         SFE+BmsafBFDTJOt47VtYFE1ttiKQ8vWKP06CuoW8nYduck1EOPSdkRjAPdUYdajOsuM
         X85g==
X-Gm-Message-State: APzg51AsQq8BlcGbHla+Qebk9Dq3dWV91fF4GIgladSssqGgoKGK5jgj
        TqYdTJkPBpA1CaVou2ttYi4=
X-Google-Smtp-Source: ANB0VdZe633SqSAxPkumTA6G3QayD6VBt/qJAImIkdmMPprnS4nG21mMQBfjNFKkLVNwt8EPWT+ZNw==
X-Received: by 2002:a2e:2f19:: with SMTP id v25-v6mr3829634ljv.113.1536830274306;
        Thu, 13 Sep 2018 02:17:54 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g30-v6sm618576lfi.84.2018.09.13.02.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 02:17:53 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0Nl3-0008WU-Hn; Thu, 13 Sep 2018 11:17:54 +0200
Date:   Thu, 13 Sep 2018 11:17:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     Dan Williams <dcbw@redhat.com>, Lars Melin <larsm17@gmail.com>,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
Message-ID: <20180913091753.GA3443@localhost>
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
 <20180910103022.GR1089@localhost>
 <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
 <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com>
 <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
 <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com>
 <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
 <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com>
 <f3c647ec7c50ae390fb92861d492e7aa4bef8c6f.camel@redhat.com>
 <87y3c6a1zw.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3c6a1zw.fsf@miraculix.mork.no>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:34:43PM +0200, Bjørn Mork wrote:
> Dan Williams <dcbw@redhat.com> writes:
> 
> > The fact that the firmware implementation has the ability to change the
> > endpoints is unrelated to Kristian's case, and that alone is
> > justification for this to be quirked in the driver.  People other than
> > Kristian will undoubtedly use the functionality, on platforms less
> > limited.
> 
> FWIW, I agree with Dan and Kristian on this. It's a documented feature,
> and it will be used. The reasons are irrelevant. The firmware
> implementation is inconvenient, but we should still strive to make it
> Just Work in Linux.  Kristian's solution does that.
>
> > Also most Huawei modems have the ability to change their layout and
> > configuration just like the EP06 via the U2DIAG and SETPORT commands.
> 
> Yes, but they are nice enough to use unique class/subclass/protocol
> triplets for their functions so it's easy to support the changing
> layout.  At least as long as they use their own VID and not some laptop
> vendor's..
> 
> The Sierra Wireless strategy, using fixed interface numbers leaving
> "holes" is another fine solution to the problem.  Or they could have
> allocated unique VIDs per function combination, as long as the number of
> valid combinations are low.  But they didn't.  It's not like it's the
> first bad firmware design we've had to deal with.  Let's just work
> around it, like we always do.  No need to make life difficult for end
> users just because Quectel makes life difficult for us.

Ok, thanks for everyone for your input. As Lars I was sceptical about
this, but if this is contained to Quectel and we have a solutions which
hopefully covers all permutations for their other devices, let's go
along with this.

I'd prefer seeing this contained in the device-id table as far as
possible rather than maintaining a second table of product ids in
probe() so I've cooked up a patch (on top of this one) adding a new
device-id match flag.

Kristian would you mind giving it a try? 

Oh, also note that I dropped the RSVD(5) for the ADB interface in your
patch since it uses a different subclass anyway. I'll submit both
patches in a series.

Thanks,
Johan
