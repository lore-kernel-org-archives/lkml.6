Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D8CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7962086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+/k5P7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7962086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeH2Lvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:51:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42085 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2Lvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:51:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id z11-v6so3506909lff.9;
        Wed, 29 Aug 2018 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7DFRHkOVAJqscSxBCu8CwOa6nzGeJ/pA4/ra0+pOyH8=;
        b=o+/k5P7UpdRWC1vycfgaVwa94Bt0tBV+hYTs/NLURxR+bH65EuvE0Rxf2LL5i1m6/j
         XvaUZW4fB2GG9dUD1Ep2pfUbmGAzj/dBXGzWKQQGOSLKs1yQC66Ce0Co3So5kXBlXudJ
         PW9aUSgvLgsi2yfxcyROoj0Kf85RwmoeLU4shBcLqGDMGhtxLSUdGlv7msiKh/fi1GVv
         DHm/33U2kMnudcEbLmjEzXxheC0pizz6xUzZHJ3ncB5O8aVdjyiv+tft4N6AF/iKwwSQ
         PzQUqnOsDwRbnfTTO6FRYhWkoJVlazRcPGikdfclOvEMegzdZXb5/0iBmy5szcUH+hdL
         tvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7DFRHkOVAJqscSxBCu8CwOa6nzGeJ/pA4/ra0+pOyH8=;
        b=hMWa0lTMsSgVL2jUHL2SBqp2o6/cH7MCbhlJ45Mn/kzPtsfY/2KdXNshO1EuN0aXW7
         ZeTd/pemuaf4GAHk/CJ9L/p7gn1AQ3HEI+nTkdI6uvJoIKAPgZjHKUtL5yuuYz9T0rB/
         0kK3FjfKUxlIMg+p0589MEqUtnCaKLorYsSq6raWjLWAXLYLysWprbeRMQSqKd5sLSD9
         9MtESYFN2MBovEdL+p+UYKTV84Jnd7gNDFD4CjagAuUPIy9MFpkJwLS3bMaPcJYWnRM/
         W73IIMvBjX2zqaPzx4E+FtzMj5yf9rBNIFOCmllhJCNKVGxUmnQq+CGhfrvteI6OXzR7
         I+Hg==
X-Gm-Message-State: APzg51CyhR8bohsQ0jXXsF3SlPqbhvR8ojDO4nFNpIWRJYuO/sAsSnBn
        CDXhjNeT1WauQilDsaS+EW4=
X-Google-Smtp-Source: ANB0VdYcK3UIxVxldo5haH5Jhxbwckzc2vPM50VqLJ8LwiEOuIuY8SS/brmO/Jj3lJHYyMGu4X+/Vg==
X-Received: by 2002:a19:aa52:: with SMTP id t79-v6mr3553544lfe.85.1535529371324;
        Wed, 29 Aug 2018 00:56:11 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l141-v6sm607731lfg.55.2018.08.29.00.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 00:56:10 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fuvKk-0007aR-Kp; Wed, 29 Aug 2018 09:56:10 +0200
Date:   Wed, 29 Aug 2018 09:56:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     Johan Hovold <johan@kernel.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Lars Melin <larsm17@gmail.com>
Subject: Re: [PATCH] option: Do not try to bind to ADB interfaces
Message-ID: <20180829075610.GE28861@localhost>
References: <20180723140220.7166-1-romain.izard.pro@gmail.com>
 <20180723140801.GA4835@kroah.com>
 <CAGkQfmPbuK7-f=9GcvQPH6mkHXwsaGpjqv40DLgFUJmbOCpbgQ@mail.gmail.com>
 <20180827132815.GD14967@localhost>
 <87r2ijdbuv.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r2ijdbuv.fsf@miraculix.mork.no>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 06:15:52PM +0200, Bjørn Mork wrote:
> Johan Hovold <johan@kernel.org> writes:
> 
> > It would allow for simpler device-id entries, at least when ADB is the
> > only blacklisted interface, and may enable ADB for some older entries.
> >
> > On the other hand, interface class 0xff is indeed supposed to be vendor
> > specific as Lars and Greg pointed out, and with status quo we don't
> > cause any regressions. If ADB isn't currently available for some device
> > due to option binding to that interface, we'll just blacklist it as soon
> > we get a report.
> >
> > So personally I'm not sure it's worth it, but I don't have a strong
> > opinion on the matter either.
> 
> +1
> 
> The adb userspace application is also free to unbind any conflicting
> driver, so I don't think blacklisting is strictly necessary.  Except to
> prevent any confusion caused by bogus ttyUSBx devices.

Right. Let's leave things as they are then.

Thanks,
Johan
