Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA43C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331592082A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLK+C4DC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331592082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeKRB53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:57:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44483 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeKRB53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 20:57:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so22811955lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z5YgbpJlOGlsCs/Qszrw3AKYAxTimHtgBBVeHcgnDTM=;
        b=oLK+C4DCmWTlR6seVeJc1k52Rv9gIwuEQ7PVmvhfpxrDyVghKas4JnjBM/30zB8J56
         t/Yt2L5/sT9fLmkAel4OU1oXUUWqdHGFa+anWaEkUfn0p5ByssjJTsj3l8fU82AJ7eLb
         IHF4BvJ2vWZ1gpoIwo30f6iyKFK2cCWXL95wrofcG0MQDE8SlYoAaYJNwC/tsVsvPS+L
         WHEGH9s5qzNNVCAIl10GaEi5qE1wLdAMXQ158prDxnC8rf7qV6wZrI94O+BD3CdjGOir
         P3lA0011jBJpz5JVnI2kG5yMVcF2f0HTYf928U5581fUoJ4iZTPCyl+YDwOHVxNS1AiQ
         jwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z5YgbpJlOGlsCs/Qszrw3AKYAxTimHtgBBVeHcgnDTM=;
        b=D8p0dZimtZWrtzRL+UhseOZ2ojhV40Mt4zmN5pCT51fGxHM5GbV6+vAaPhcbLQv93A
         bYpQRtFhmXUqPgr0epD5NdkATrz5M1K8PICwjr2B3zZt0Iy04+3hn8UDLRdnCZSQmBTL
         tYTorSn6xtOSKwerexxIDm+JeFB12gQkSVN82s2VjjwpmcdGs79VRpHzLkPBiFlHfoCQ
         xXk7UuxC+cibiteCZsvx02Bvahrldp2drZdrJppAW7FXoW/Hs/vjPVxlV2MpHGpfuXVx
         E7e8CpJTHjbt8QIbMSlgt5H9cs7SQyWf0CUSGnm3DMZ/tx+G9pEEJqzHzO58nC6nYJ5o
         vUVg==
X-Gm-Message-State: AGRZ1gL9Bb+1JQXbTaBVkIuM39eJ5la/NyDJvyyq2Lwx0CWWABtM9gXu
        63IUA5tRtNZ1NpTJsIMAuuKP5KAJ
X-Google-Smtp-Source: AJdET5eOigZ3PqZc9w3tFrsZo2QbCkLSAmHGuviDuSqhQPCmv2OcfvWm5l4Dl7aBQCiv/fJGjX6wwg==
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr8105559lja.46.1542469225770;
        Sat, 17 Nov 2018 07:40:25 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l3-v6sm5209455ljg.21.2018.11.17.07.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 07:40:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gO2hv-0001Xl-50; Sat, 17 Nov 2018 16:40:27 +0100
Date:   Sat, 17 Nov 2018 16:40:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: arche-platform: Switch to the gpio
 descriptor interface
Message-ID: <20181117154027.GV19900@localhost>
References: <20181116151740.GA12250@nishad>
 <20181116160622.GQ19900@localhost>
 <20181117071109.GA14187@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117071109.GA14187@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 12:41:11PM +0530, Nishad Kamdar wrote:
> On Fri, Nov 16, 2018 at 05:06:22PM +0100, Johan Hovold wrote:
> > On Fri, Nov 16, 2018 at 08:47:44PM +0530, Nishad Kamdar wrote:
> > > Use the gpiod interface instead of the deprecated
> > > old non-descriptor interface.
> > > 
> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > ---
> > 
> > Always include a change log here after the cut-off line so we know what
> > changed since previous versions.
> > 
> > Also include the patch revision in the Subject (e.g. "[PATCH v3]
> > staging: greybus: ...").
> > 
> 
> Ok, but this is the first patch version that I submitted
> for greybus: arche-platform.

Ah, sorry. I thought this was an update of the arche-apb-ctrl patch.

Johan
