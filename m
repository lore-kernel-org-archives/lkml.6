Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C25BC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BEE20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cRpmvh42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BEE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964889AbeFRTdO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:33:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39282 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936203AbeFRTdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:33:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so17698887wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MdEU2rgNWfYrvv05t7K9ORmQbfLGnYSIECE3MsxNbIM=;
        b=cRpmvh42gWODrmHx5r9DCUzJzYkIehUVEuw1n8Ww/koT6NW+GpzW11iS45XjGpVrjT
         c32vOQX41ovhG3XsbuRDJ3eENdyjFGCiFBuVYzuihH6+PbgHTavUxI662jTcFA/f9AJv
         rj8rc60IX35K/y2fKcW4YkbaUvu+wBRO7Dd/f1x4Rr3njjiNie+lW/nUTBErLxPWzz4P
         7K3vztMI7c6hbtdBj6m5DyFS7c5gMgTP85EpHa1dDRRll5GIiZbOEqhRbkHCSE5dx4Q6
         n4cfrI5tVW7QqZj5GNH9qA9iog/cDO2Sv1D/SYXrot4BkpkNKPPrFwErC37U5hToOeZ/
         5FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MdEU2rgNWfYrvv05t7K9ORmQbfLGnYSIECE3MsxNbIM=;
        b=OOPdUjNOjCK4Ztaua7+4yUR2PHgvgL9bCrgTQ5gbpEl+k/pQ+XQskIKJ2vQxafpL+8
         Iu8rdVxYv3fM9b2C2CacCSApdYCrhPsDHk8auU6F4cPYoFZN3loQfrzDDmJTXdjMYAg4
         0By4iCRpNdf9d9eSI6raBwMNZdOPZoO4IdN6DrI+AuJmYUSI74BfItiqqZuQ2l/W4k21
         i2S9TW8ZI1jW1NM63JXyuU+kf41Ymtdjv/jUu4KT4BG0choDPS+yL+AaiXhfXQ90cC4x
         RgDltgYh+o7MwjCPOiT219EO1oWmpeUq9upkVWGhlTqeR24m47GJWfcrAuqMpSD7Tste
         kcCQ==
X-Gm-Message-State: APt69E2N62Z4sY4OlM2XfmoQmcJxuuoC/OHVQsPOxoWT+CMI6y0JN1gc
        IdvXDXYeuX4DSz/q7n3yVh71Ew==
X-Google-Smtp-Source: ADUXVKJ5QRXAYoKUond5gorbQtc9mYb/16glUOLai+USXMNMrS2yZAj+Re+YvdUlCdjlJhm1Yxm/Dg==
X-Received: by 2002:a1c:d905:: with SMTP id q5-v6mr10249295wmg.78.1529350390772;
        Mon, 18 Jun 2018 12:33:10 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id h12-v6sm8050786wmb.3.2018.06.18.12.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 12:33:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fUzti-0002wZ-Or; Mon, 18 Jun 2018 13:33:06 -0600
Date:   Mon, 18 Jun 2018 13:33:06 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Louis Collard <louiscollard@chromium.org>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
Message-ID: <20180618193306.GF6805@ziepe.ca>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618180712.GB20697@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 09:07:12PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 08, 2018 at 02:54:38PM +0800, Louis Collard wrote:
> > It is now possible for drivers to easily specify a hwrng quality, however
> > most do not currently do this, and in cases where they do, it may be
> > desirable to override the driver-specified value with a user-specified
> > one. This patch adds a parameter to set or override the hwrng quality.
> > 
> > Signed-off-by: Louis Collard <louiscollard@chromium.org>
> >  drivers/char/tpm/tpm-chip.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 0a62c19937b6..4def49cfc634 100644
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -33,6 +33,11 @@
> >  DEFINE_IDR(dev_nums_idr);
> >  static DEFINE_MUTEX(idr_lock);
> >  
> > +static short override_rng_quality = -1;
> > +module_param(override_rng_quality, short, 0644);
> 
> Should this be 600 i.e. not to leak this information?

There is a real push these days against adding module parameters, and
apparently, IMA can't function with TPM as a module.

Are you sure this shouldn't be done in some other way?

Jason
