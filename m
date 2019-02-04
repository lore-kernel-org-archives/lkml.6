Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD7FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA5220821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqFs5bR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfBDWpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:45:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35451 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBDWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:45:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so619758plo.2;
        Mon, 04 Feb 2019 14:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJuYUJnOGWCJiAV08E4cVuBASW9ES+HHjXeqXLduS/s=;
        b=LqFs5bR0Mnlv9ll0+SvKEeo1OaTvHOrQvnQbCbEOEvsNxDkIS/FAKPLUfUbuXNWGJA
         MbLWaB2ysCKyPHCbc0EnKq4Ko2PE8kTeitPVoa0kq2kYyRzVOYfkYnGXTwaKbGtqmNCZ
         aV1y5i+J6OmWFa1zVhoMANzq0GEVitVcsTosfe5riZji0tafeymXzW9Pdk88U+soRmHw
         y53DyDJ2MnL8K1fpycZTL4Q9LBFZv+oirsSOdPaobh1iOuX+GJOuNFnN4tve4kRisgCC
         rttAxCUpie+OYLfvuTDjpUCgMNf50FmMJp51GPf/ZTTdiHnYY+lnO1sLyfauA4+p6vC7
         fG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJuYUJnOGWCJiAV08E4cVuBASW9ES+HHjXeqXLduS/s=;
        b=nkvJDvhOsT6JC0y8POPu6ItOL8rWOLhAdNIH82jaCppsfhLBxITNCWz7N6+r3/O0hp
         c50gKWmv7zSv2Ws6SotxUSePeCOLDNBBsMHFP+HXIfSxfuTqogBEyqYITCvT29jBmGbi
         85PEHmCGzBXoKL3p/NR83bT4EM38xzd21G7Xt6Rxkm/WZO467AzjbM9Cz/vyGr0/nocu
         gTO+9zyTI0Vsma89gQzf7uRddNJogwxvapyCZ27gzLAnQ4ccqMuA3G+YdwGKrzTzHPXQ
         IblNKoSq/8dtj2JNi1u8yKO8uo18oY01w0MUfiUZpIZyVNzEn4FMFD/pE9iqdcRChz2T
         2oFg==
X-Gm-Message-State: AHQUAubru8TYZnHKABsflMdCI3LkpwDSG+RHzzixIkvJTSBb5/j+z2aA
        ndo2PKnT3ZtmmXZ3KIqjqZo=
X-Google-Smtp-Source: AHgI3IaoElp3W9QkGMMx6ZtA9iqNRopV/v/ALYdZYg6C8s1ePNCpsnjSjWzR07OULd9RQmsBey4Kow==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr1811977pll.305.1549320306690;
        Mon, 04 Feb 2019 14:45:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2sm1231707pfa.167.2019.02.04.14.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 14:45:05 -0800 (PST)
Date:   Mon, 4 Feb 2019 14:45:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jeremy Gebben <jgebben@sweptlaser.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] hwmon: (lm85) add LM96000 high freqency pwm
 support
Message-ID: <20190204224504.GA11792@roeck-us.net>
References: <20190204201906.8859-1-jgebben@sweptlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204201906.8859-1-jgebben@sweptlaser.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 01:19:02PM -0700, Jeremy Gebben wrote:
> Hi,
> 
> This patch set adds support for the PWM frequencies from 22.5 to 30 kHz
> available on the LM96000.
> 
> It looks like this chip has been supported for a long time, but wasn't
> mentioned in the docs (which I have updated).
> 
> I stumbled on to a 10 year old thread discussing a patch which looks
> like an early attempt to add support for this chip, which may be of
> interest:
> https://lm-sensors.lm-sensors.narkive.com/1SIwaMDT/patch-hwmon-lm96000-support
> 

Series applied to hwmon-next.

Thanks,
Guenter
