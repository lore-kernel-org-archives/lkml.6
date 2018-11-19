Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC3FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213BF2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVRfEis+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213BF2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeKTHxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:53:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42615 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKTHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:53:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so10941797pga.9;
        Mon, 19 Nov 2018 13:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FY1K5PbJJVD33BVLhztstoLTyP+iNXc1IVneug35lgM=;
        b=LVRfEis+V2VLl5Xa/PGKVlQb9PGODFBYR02JEIkbs8vE+WaAQFeR2ZqvO7dXbuIqji
         kfPvEEqORqsrTlRgKNY82fvauKwzIylBU6sFc2PD79M4oq7WlLqpo2KD/coMFKsryCzJ
         APUva1Rwr+xoPCk6BeltkSes3YzQcz42GB8lQkswQhjUD3sjcscLeasj/kURlyM6GmcG
         FZgJdPkFOk/XO903L+83Za5GZ8AV0du7E71HoZYItrM2yUCYdZ8G0psTjyae0GzUT8Uh
         zAlvUUbO5yLRg9LpyFBsyZL8fRTDbaLSgl2TQQFdvEZlRYKzTVThGwM6zfF4+H9wUffA
         jjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FY1K5PbJJVD33BVLhztstoLTyP+iNXc1IVneug35lgM=;
        b=BrSwRRQnuIj24UvIv8StSfAkEVo71Sg1d9+dQjnqVWnCk27EbUdllUY7buEuYhDgmN
         ZXbqyqlD0+4mvfwXQSU7PKCAjMV6jh5lOEIJhhkjAvWHuyp3ZFxOynolo0F8CrPBlkNf
         N2DrL0auveZObi9bup1cwA/t6mgeWFrKvFSt+NWjhVE59uORjfIxEPzO6bp1GQDZVwcv
         cOs8IjU72gb2+ZjTT5UrcOQKWH5IfCZUFNNPPmm/iBuM20PW0lsU/MJarIx1gkQNE/OI
         whUYqQmpzXKgihRKtDTLuSfJoE/PUquzXnml9mhhm4i0W8c+daq/3DcoS1y9WzmvV3NS
         gtxQ==
X-Gm-Message-State: AGRZ1gLSl46j7aHL3ka0R7ATUjwqJfcqSSjc2xiNkPxxzvsG0yqk8iK/
        e3DS/c4sil7GkR1ZciQTmMZ502gn
X-Google-Smtp-Source: AJdET5enb392zL0fZoFFkWeNO+YQMm77gxUoMdkK3mvy1oBNKvkQI74U1LSnEDEC/wvenOb/UjpaBw==
X-Received: by 2002:a65:4904:: with SMTP id p4mr21782844pgs.384.1542662887772;
        Mon, 19 Nov 2018 13:28:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e64-v6sm25341437pfc.122.2018.11.19.13.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:28:07 -0800 (PST)
Date:   Mon, 19 Nov 2018 13:28:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (ntc_thermistor): add support for B57891S0103
 from Epcos
Message-ID: <20181119212806.GC5795@roeck-us.net>
References: <20181117121248.32143-1-peda@axentia.se>
 <20181117121248.32143-2-peda@axentia.se>
 <20181119170732.GA27435@roeck-us.net>
 <f1235661-f8f2-9885-1e7f-491f5c234078@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1235661-f8f2-9885-1e7f-491f5c234078@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:16:12PM +0000, Peter Rosin wrote:
> > 
> > Guess I deserve the non-alphabetic order as penalty for not enforcing it 
> > earlier. I'll accept the patch after DT approval and submit another one
> > myself afterwards to restore alphabetic order.
> 
> Right, I'm thinking another good change would be to introduce an enum
> into the ntc_thermistor_id array, because the hard-coded numbering in

Yes, sounds like a good idea.

> the ntc_match variable is a bit fragile in my taste, and that list would
> also benefit from being alphabetic. Currently there's simply no way to
> add things in the middle without causing mayhem. I thought about doing
> that, but didn't want to waste energy doing it up front without knowing
> if it would be well received (the driver might have been superseded or

It would.

Guenter

> something). I'm glad that you have volunteered to clean things up.
> Ha! :-)
> 
> Cheers,
> Peter
> 
> > Guenter
> > 
> >>  };
> >>  
> >>  struct ntc_thermistor_platform_data {
> >> -- 
> >> 2.11.0
> >>
> 
