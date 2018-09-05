Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B36206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7QaZHDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B36206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeIEMu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:50:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32925 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeIEMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:50:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so5494525ljj.0;
        Wed, 05 Sep 2018 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g7Oz8Gyx/qx1G0DRACk6nmbYCIAtPOVOe96rMTwRRoM=;
        b=s7QaZHDScv+bGqPCS5Ytne+LJ12w0JATQfhTTzv8k8WXaLKDuSTEmEvaKSJTgRcTvW
         osV0fBvdpfjLPBkTc9ouk+hSOcCK9kxjgHDrNRzouEDSNnU5IMnX8+zitwXYw0l6nPKX
         GNE5/bNoMcBERtILjzHHjwww5z3eItzLsy5CxoZnm7NBPWOtp8eGqv+cWkh+LVXLc4Nr
         BQblupJCmW+kgqH1Sj/Ce+C2fXBXhJoKGO0eDMl8d9trIYg+2uDbciCAwhRAuFUcUT9r
         OoVflHR7gx6sIjsLs+Iy0pqaft354JhvZ5wLrKnKijApPXdjdtzaEYlb0Yxjpc32HXcA
         ft8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g7Oz8Gyx/qx1G0DRACk6nmbYCIAtPOVOe96rMTwRRoM=;
        b=fq8LLYIdN6NnjpGFHEtgY6vSJ7rg9PgbNe/l/aSMyKW24cGpSE9brVy1inSelMEIb1
         3otGv171gSsQP+RAIvlREHlhGFjewZPGsPJTDZSv/3CCnqVx+8fOzVn8lOkhG40sWDv0
         bz7YvNYUmAP19b0g1lFHEF4j+Slb+8fbeWaHd4GI2rtTBAgdnEKTVPpgi3UrtLxe/eSu
         Wl4JU6OLCvoOT6wWrJiNlKbzZRB6ou4QZlSxBIukuoUEouEkXXSzDCaqNEFoJM1CNC5k
         +X0Ez9c7hpQ+EppAIS+o0uv/GQ6DvTzcHOxLGllkYXEFqDuiSwRnEPzWJc/t1IPWmjb5
         cqmw==
X-Gm-Message-State: APzg51CiUFxpqGfoUhtYWI6WCc3jbWrX1s4kLmCwuqX1Rb5IPtHH1H61
        Y54wbvJQd65jUmN9WR6t8Mo=
X-Google-Smtp-Source: ANB0VdYGoP7eK0U4Dzfb+fOwf8C1sFLGI/tEgvm8Zg3YK/Fq3tYKr276yJM+8be7LE3kgFOwGj1izg==
X-Received: by 2002:a2e:5719:: with SMTP id l25-v6mr22557435ljb.125.1536135681318;
        Wed, 05 Sep 2018 01:21:21 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q5-v6sm193333ljc.2.2018.09.05.01.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 01:21:20 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxT47-0003kG-Ms; Wed, 05 Sep 2018 10:21:31 +0200
Date:   Wed, 5 Sep 2018 10:21:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        andy.shevchenko@gmail.com, ajaykuee@gmail.com,
        daniel.thompson@linaro.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: implement GPIO support for FT230X
Message-ID: <20180905082131.GV28861@localhost>
References: <2d91567c930ae5770cc55f92c37a9c6d@pados.hu>
 <20180904124924.GA7278@localhost>
 <20180825204744.2307-1-pados@pados.hu>
 <680c039b5fb2beafa48ea12e492341db@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680c039b5fb2beafa48ea12e492341db@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 06:07:49PM +0000, Karoly Pados wrote:
> >>> + priv->gc.ngpio = 4;
> >> 
> >> Shouldn't this be handled the other way round? IIRC there are two FTX
> >> device types with four pins, and one type where only one pin is
> >> accessible.
> > 
> > There are 4 devices with 1 GPIO, 1 device with 2 GPIOs, 2 devices with 4 GPIOs,
> > and 1 device with 6 GPIOs. Source: http://www.ftdichip.com/FT-X.htm (2nd table)
> > Do you still want me turn this over?
> > 
> 
> Aaah, but those other devices are not UART bridges. I see what you mean now.
> The point for me when developing th original patch

The last sentence looks incomplete; did you hit send too soon or too
late? ;)

Johan
