Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8E5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE8320833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLclH1DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE8320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeKCE5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:57:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46557 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeKCE5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:57:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id w7so1395345pgp.13;
        Fri, 02 Nov 2018 12:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+RIxz7GH9E0gjEQfRLnqCSuZJhthIl/bMQ1xO9xRMxQ=;
        b=GLclH1DVFVErvmKNfLX1vwOJmkPEUpoF3IKaUp7k3yjysixsiqIkm1j5fYDbdYF5fc
         sBxgwM4EsetDLo8oUBB14bEhNOUkPUiGmkxICasZh6hd8CbrEKQYeLmMotnPooTnPdU+
         d6C7Zsdivvbq9g35d+rebHVwtcBnU4iRYF8lAiN3AcD8PfofjuthVsvMXHJFF4n//61n
         jT1N/rKZ2F+PbSZJOC1AkPUOF4VnowBsjS53gSwWUggFRBgumESuJGDLi7yQEx5HtUwu
         TfhsHBCLfjeJjMrPkhwWLwWR1MsUrRbJG3eJYqtmoaB/f3czRxrhledzsmH2pkP+n8c5
         8x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+RIxz7GH9E0gjEQfRLnqCSuZJhthIl/bMQ1xO9xRMxQ=;
        b=Mnx3qCY3pcg4MGbJsbh6He3hmlQ6PlqUWl0xWJFyvKDf/by48uR9W0X+DiQ/I/MoGK
         bYrg1V/dhDDb8srpnWeuj/fK5N2/p1Tday0vEi/n87XJppLpk7jaEgIal/NSiKFHmKI7
         gGCpQspjezG00tWbn6vDmEplhaktmmhq4ZXQRlp+QopYNu/lk5JB3dtngPvu+FozClYq
         ZxDsX6xrCEc3ujCiIy2ndf8at9B0RmTC8ZCIl0933NPKjjoyXQyqlX8Djk6Gls9h5qAr
         3wUSMWzPtHPXdJLzaqKG7VL5zVh5RihP1axp0FTBORZm1RHV1HTc48zXcnXLBc4+qiJu
         IAng==
X-Gm-Message-State: AGRZ1gKB/X2H1w9FlvLKHEwrhitvcMibrQcIpCYLP6hQUkllp5326zOa
        +cyILKlw8uuHgPa48W8RU6k=
X-Google-Smtp-Source: AJdET5d8tFpok5pNavc2KR3igJXHyBogy6x2iQ7Tz88IdPt2VmJvxZfT4oqJxXdOH8qu2gu5kSHHbg==
X-Received: by 2002:a62:c184:: with SMTP id i126-v6mr13040010pfg.53.1541188141456;
        Fri, 02 Nov 2018 12:49:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u79-v6sm46874912pfd.117.2018.11.02.12.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 12:49:01 -0700 (PDT)
Date:   Fri, 2 Nov 2018 12:48:54 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] hwmon: (core) Add pm ops to hwmon class
Message-ID: <20181102194854.GA26329@Asurada-Nvidia.nvidia.com>
References: <20181025235122.3240-1-nicoleotsuka@gmail.com>
 <20181025235122.3240-2-nicoleotsuka@gmail.com>
 <20181102175435.GA4749@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102175435.GA4749@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:54:35AM -0700, Guenter Roeck wrote:

> > Actually, pm_runtime core also scans a class-level pm pointer:
> >          else if (dev->class && dev->class->pm)
> >                   ops = dev->class->pm;
> > 
> > This means that hwmon class in the hwmon core could actually
> > have its own generic pm callbacks so that a registered driver
> > would have the capability to link their own callbacks to the
> > hwmon core's.
> > 
> > So this patch adds a pm pointer to the hwmon class with some
> > generic pm callbacks of system suspend/resume and pm_runtime
> > suspend/resume, and also allows hwmon drivers to pass valid
> > pm pointers through _with_info API when registering devices.
> > 
> 
> Just to give an update: I am not happy with having to add hwmon
> specific pm callbacks. That doesn't look right to me. I'll have
> to spend time figuring out how other virtual devices handle this
> situation. Unfortunately, time is always scarce, so this will likely
> take a while.

That's okay. Would it be possible then for me to add PM runtime
functions just in ina3221, without touching hwmon core? It will
belong to the I2C device, not hwmon device any more.

> Also, please note that I won't accept function macros. I understand
> that are used a lot, especially in older hwmon drivers, but they just
> make the code more difficult to read and often add unnecessary code.

Okay. Will be careful to use them in future hwmon patches.

Thanks
Nicolin
