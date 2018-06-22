Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C01C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DFD23BFF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HFnPOHii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DFD23BFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934209AbeFVBWL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:22:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41509 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934114AbeFVBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:22:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so2201943pgl.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 18:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=nfC6TwPQVsRQsz8Xy3Tl2RBz6ARKXkeR9VJnNIMrfro=;
        b=HFnPOHiiskyDh9yyn3MYhoP6pxV9oqRJGiURzQqlEu49ACCp3MRb+DB0L+PMUDSXN9
         r12NgGFpx1n0+hC2hg4olJj+XftpqFq06hkWFlm89xsEWJ1QsUsOg4UAVwv2BhblT2Td
         W5L+pI8tDxpam4aycvax3W+RtIt3fCtNK9leM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=nfC6TwPQVsRQsz8Xy3Tl2RBz6ARKXkeR9VJnNIMrfro=;
        b=bjiF0z8y3OD6ZAdaIiKfit96+7+QhXG2rVzSEZ6J+HGXlM+W5Br4oXgWgsypglvNyc
         +RLXTFoufFSoKcfErCBEP1jyP9A2igoiTTCOO/M0BKkNysLFdGyOGc2GwehCjCDjFC0l
         O5QZpXfOPguAWIy8s+p4eJjB9Sg/BAX+RiStLJWmaeB8S1AAoKRFh/4q6l4h9LIzfc5X
         PMds0bEwUVaPlOIYGnm1P7AG+b1hgZMJYxqGqZlDu0dKd/0WR/AQtFxixxYks8XSsjcm
         tzaQC2Dj3P49qKI5GOC70a9MHWGsKWc+1S+KYWtJMx2ZaTKLIRZuKs0iZ5QGW+2p/lp5
         egjw==
X-Gm-Message-State: APt69E1Of3wXDqwpGanHEew2FED7X2Ojf2ROwHAfFC+Cq0mlQFs2aSUQ
        IBZlUQPmtnPJNhIoe47ccpxN3g==
X-Google-Smtp-Source: ADUXVKIpz9vd0XqlOPelYCFciI6l4cy8Vldvh8guTsBoMqNKlkhVhMqN2cr7nm7/WcoKIgqFePoD1Q==
X-Received: by 2002:a62:1855:: with SMTP id 82-v6mr29745801pfy.132.1529630527756;
        Thu, 21 Jun 2018 18:22:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id 67-v6sm10988078pfm.171.2018.06.21.18.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 18:22:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vinod <vkoul@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180620133725.GB27187@vkoul-mobl>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
References: <20180619095430.26358-1-vkoul@kernel.org>
 <20180619095430.26358-3-vkoul@kernel.org>
 <152947431955.16708.15247307054260887941@swboyd.mtv.corp.google.com>
 <20180620133725.GB27187@vkoul-mobl>
Message-ID: <152963052624.16708.17133633012075809772@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] hwrng: msm - Add support for prng v2
Date:   Thu, 21 Jun 2018 18:22:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod (2018-06-20 06:37:25)
> On 19-06-18, 22:58, Stephen Boyd wrote:
> > Quoting Vinod Koul (2018-06-19 02:54:30)
> > > Qcom 8996 and later chips support prng v2 which requires to
> > > implement only .read callback for hwrng.
> > > =

> > > This version of chip has multiple Execution Environments (EE) and
> > > secure world is typically responsible for configuring the prng.
> > =

> > Sometimes secure world is not configuring the rng though. I prefer we
> > have a DT flag for this to indicate if secure world has configured it or
> > not and then skip the init logic when the bool property is present in
> > DT. Then the DT property can be set on firmwares that are making things
> > blow up when we try to read the 'configured' register. I'd also file a
> > bug to qcom to tell them to unlock that config register for reads so
> > that things can work simpler, but who knows how that will work out.
> =

> I dont feel that would be required. See below..
> =

> > It really sounds like the hardware isn't actually different, just the
> > firmware has decided to be more strict about making reads fail now.
> =

> So in this case base hw block seems similar but consists of multiple
> Execution Environment (EEs) and all of these contain only data
> registers. Only secure environment has configuration. Each one has its
> own register space.
> =

> In a case where we dont have secure world, we can point to secure
> environment with v1 ops, so driver shall configure and run.

Are you saying that there are multiple "frames" that each EE can read
from? And then only one of those frames is the "real" one that can also
configure the hardware to actually give us random data?

That sounds like it would work, but then the compatible string should
probably be more like qcom,prng-ee-frame or something like that to
indicate that this is a window into the real hardware, instead of
tacking on a -v2 and making everyone think it's new hardware.

