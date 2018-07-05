Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E43C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2544324137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0BeVUBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2544324137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbeGENJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:09:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45872 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbeGENJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:09:44 -0400
Received: by mail-lf0-f67.google.com with SMTP id m13-v6so6905326lfb.12;
        Thu, 05 Jul 2018 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IAp/y7an9N015ha2rUh1YWH5FNyZl3fhnzcEdOuAR58=;
        b=B0BeVUBkaaXQF9JeenT58aodxY8hNlKtoU2jrHLwp+Q2nODCRRSfC1Q5lyC+PGwd2k
         Fa0UiaRZ9UsUxB0IsBDzlSJk4CaQeEOjwV5E/YG+St21C2AEIg8KcWekIa6CKdI3+eNG
         +OZGE7z0UUcsSDLmX/Lk7BMizJ2VLL7t0enh44h/qxsRDqogUPeOqOvNYtlFm8X1678n
         994quaB0V8rK7qcmodOMqp/GjYozOwR1dtRKwC2+G8LCGkO9F+2Jm2/EdAKsulbTMatn
         sI9zsH1DPvQHJ3aTHasmpGxGpQ3rz71P4TwYDKbPA6AX1dbRSY+dKneS96ku+W27ZZ6F
         2XCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IAp/y7an9N015ha2rUh1YWH5FNyZl3fhnzcEdOuAR58=;
        b=b+x0y7dmSaRfZvWUEKkZTTXeYCVhcCkZ/l49eIZp498RN51mDSUU76XZ7nj+h7NCj3
         PenDaVWbbADnVGqhKCmBlDxEvwwcMBq5ejQYbZTpuGjjcg+V1mC6rxrUoPT+BAz8GdMu
         GY6K9SfDa8F0Kz8DyMLC5axpnpr8zD93c7FMnT86g0ShuObpmqM1SFYK/7f3NP/mfA0s
         SOCeAv0qi6+5PyNy4pRMXZwsZEG88pXxmMsE6JIFyIufrpjFqquLG4a04U6iyv5LWn5B
         LTpOWMnEMR4kME/dgeLJ1tb8HFMooVNyQJ61WibFq+1X3YZA57477WHeNZb2+GJX91pV
         y8ng==
X-Gm-Message-State: APt69E39Te6eiqnFENraYl6Y+OfY8RNONErgQkervBUjrR1z9AqLq7Zd
        LJMvuTXU0r3DUz+d5Jq3qfdi1Nf7
X-Google-Smtp-Source: AAOMgpeFxOAZRcV1hT1LSUPoo7F3VWkK9kehUntrJkURc6xQ0ZXEV2Nu3dZr0NUtQ32euPGsGwCBMQ==
X-Received: by 2002:a19:f70d:: with SMTP id z13-v6mr4364518lfe.33.1530796182455;
        Thu, 05 Jul 2018 06:09:42 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id t9-v6sm948054ljt.21.2018.07.05.06.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:09:41 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fb40p-0001NU-3l; Thu, 05 Jul 2018 15:09:31 +0200
Date:   Thu, 5 Jul 2018 15:09:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.co.uk>
Cc:     Karoly Pados <pados@pados.hu>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for  CP2102N
Message-ID: <20180705130931.GA9802@localhost>
References: <1529513516.2395.23.camel@collabora.co.uk>
 <20180620082507.GO32411@localhost>
 <20180617182503.23080-1-pados@pados.hu>
 <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
 <20180620105231.GQ32411@localhost>
 <7369694284fcea1a8d7c142f47ab361f@pados.hu>
 <1529680221.2395.26.camel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529680221.2395.26.camel@collabora.co.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:10:21PM +0100, Martyn Welch wrote:
> On Wed, 2018-06-20 at 19:41 +0000, Karoly Pados wrote:

> > Here I argue the following multiple ways. First, I say that claiming
> > that a pin which is used as an input is actually an output is not
> > only confusing, but also much less correct than thinking of it as an
> > input pin with a weak pullup to prevent floating signals. Second,
> > the pullups - while not  explicitly listed in the datasheet - can be
> > calculated from what is there,  and for the cp2105 are typically
> > 132k, for the cp2102n even higher around  165k. These are pretty
> > weak pullups, so weak that they won't matter for the vast majority
> > of applications as people rarely use pull-ups or pull- downs higher
> > than 100k (not never, but rarely). So claiming that it can result in
> > false expectation, while not completely wrong, is favoring the 
> > needs of a few instead of the much more common practice.
> > 
> > Lastly, and maybe most importantly, I argue that calling everything
> > an  "output" pin only in name does not actually avoid any design
> > errors, as the same circuit that would case a false reading in one
> > case would also cause the same false reading in the other, and the
> > circuits are usually developed before the software. So it'll be too
> > late anyway by the time  somebody realizes such a mistake. But on
> > the contrary, it opens up more  opportunities for errors, because
> > now you are open to software bugs that ignore a pin's direction
> > because everything's an output either way even  when it really
> > isn't, and think that they can treat it as as open-drain while for
> > some reason it is in push-pull mode. Worse, even if it is in
> > open-drain mode, it will only work with a specific output values -
> > it must be high, which is not the default. With my proposal, 
> > setting a pin's direction to "input" will make sure it cannot be
> > actively  driven by the chip, avoiding such "misunderstandings" and
> > errors, and  similar measures are also in place for the push-pull
> > pins.
> 
> Yeah, I'll go with that. :-)

Sounds good to me too. Thanks to both of you for spelling this out.

> > The only problem I can see is if there isn't a way for the cp2105 to 
> > query the reset values of the pins (maybe there is, I just haven't 
> > looked into it). Then I don't know how the direction could be 
> > determined for an open-drain pin during initialization. But this is 
> > solved for the cp2102n, and then it is a device-specific issue for 
> > the cp2105, which shouldn't be forced onto other devices if we
> > otherwise decide the approach to be inferior.
> 
> I'm pretty sure there is a way to determine the pin state, though
> unfortunately I no longer have access to the HW to be able to test...

If this isn't (yet) possible, it's never wrong to continue treating the
cp2105 pins as (open-drain) outputs.

Thanks,
Johan
