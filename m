Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C652ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EAE2082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwWtc7Zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EAE2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJ2Dnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 23:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeJ2Dnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 23:43:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 908D720843;
        Sun, 28 Oct 2018 18:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540753089;
        bh=VxHGpKTmt+3YiecjO4HIGrE86L25Lq5qFyt+1fyfUFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EwWtc7ZfFiKKJzWwfB3hAtrrldBO6gH9MwkTUJXrMJNJKKB2aET+jv66QC3E9bBod
         ieToTyfRKWi+COYOLG1HR1RiFDFxeX5Twd72+29A5fNaH4fCvID0GPk7i8h255gQ7A
         KeFQwf/Dn9rdP/+yrPtm774buAAPWS8BPb5SiQIk=
Date:   Sun, 28 Oct 2018 18:58:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <20181028185803.6dc8bb57@archlinux>
In-Reply-To: <20181028165231.2det3cq3u7r6qoxj@renatolg>
References: <cover.1540506298.git.renatogeh@gmail.com>
        <1f7b2c6ee0e18b1c43a8b27f482b08313c52d4e9.1540506298.git.renatogeh@gmail.com>
        <20181028155611.67abeafb@archlinux>
        <20181028165231.2det3cq3u7r6qoxj@renatolg>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018 13:52:32 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for the review.
> 
> >> +		voltage_uv = regulator_get_voltage(st->reg);
> >> +		if (voltage_uv)
> >> +			st->int_vref_mv = voltage_uv/1000;
> >>  		*val = st->int_vref_mv * st->gain;  
> >Is there actually a reason (now) to have the stashed value
> >of int_vref_mv in the state structure?  
> 
> From probe:
> 
> if (voltage_uv)
> 	st->int_vref_mv = voltage_uv / 1000;
> else
> 	dev_warn(&spi->dev, "Reference voltage unspecified\n");
> 
> So the idea was to, when voltage_uv = 0, return the previous voltage.
> Should I instead handle this as an error the same way as in probe?
> 
I would return it as an error.  I can't really see how we would get
this to occur if the bindings are all correct and appropriate driver
support is there for the regulator to actually let us use it.

If we wanted to handle the case of no regulator having been provided
cleanly then we should it using an optional regulator get, and
not provide the scale attribute at all if we can't know what it will
read.  This is a weird enough corner case though that I just wouldn't 
bother handling it as anything other than an error.

> Thanks,
> Renato
Thanks,

Jonathan
