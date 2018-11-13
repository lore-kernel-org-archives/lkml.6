Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E70223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfvqpWce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E70223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbeKNDbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:31:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42116 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbeKNDbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:31:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so2564780pga.9;
        Tue, 13 Nov 2018 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MOM7uWAAF3djmdgXPorZ83f0KSsDk/UvAAHI4H8h+i8=;
        b=rfvqpWcez/i2SiiW5G0eEMErMAUSxIwQTPQ9/t2r8bh4EuanozY0N0TNm8Jdk/mB0+
         ju6aExQ1sllXsOTOrilmggIj5CAtLQl/kjHAVgNIp8KNk+MqW7j3hvXAnNKKUW/sf9PD
         s+prPV3Z0BZyBPvXkqAzzc1LFnFbgRgn16E/ayDC0U9HuAosOTsPzVfcQhHsOyonfDRI
         rd3ftvFmmsViSYQgRG0bL0TKDFC1q/UIyVWvw3wjRjvKuAYSrm3dmDPZu0HPuR20QK35
         5wPDLORGPnLG8Uc8O89B5ML35UxuNrH0TsYtS5GAENzXEojlpxoSfYdTSqaNeqc22NkI
         3+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MOM7uWAAF3djmdgXPorZ83f0KSsDk/UvAAHI4H8h+i8=;
        b=O6q7zZoCoHkwgD6U1coYq6nvWpnEH+wdsDnd+YoigP/gNEcCs43rH6JLky3S7Ihu/x
         DcEK6Ai81TdHSJeAtMvXy6TMWTDUo0y8r4yOgPz/uPGgBg0HWRvyynQ5y98F1maFnMPh
         1kIj5CWVafdzDbyUSgs6ibsNUa60ml89Q8aAFvN2sOzEPwbuT1uLqB9zwIAZINFkg8SY
         qqK+bKeLm1MhvvJcsUGZV4W+VGir+ZdhQkQhNKkya1NHTLIqnCMW/y+BezJhud/24i5X
         Am2OswRh51+cZnAQ7bcP/ORkmHjb4QEw0JA5RIPOVzV7Sbbi4+8Zld0hs8Qd/FZBMqTq
         lYiA==
X-Gm-Message-State: AGRZ1gK3UkLl1wvtn9DL1oXmSu0BXqj4obXfLDQSowxQKwT9TWbkcCRD
        PcKNphwg+02FeYzIvaarvs7GFKTHm+g=
X-Google-Smtp-Source: AJdET5fkgmH1RRvF4S5mSyS0ofUI+FGj8FZEkGFek3+OoBPsPZ+qVtwzzOZraE59nMEmpnj/sjd4hw==
X-Received: by 2002:a63:5357:: with SMTP id t23-v6mr5660218pgl.40.1542130361102;
        Tue, 13 Nov 2018 09:32:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 74sm23170224pgh.82.2018.11.13.09.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:32:40 -0800 (PST)
Date:   Tue, 13 Nov 2018 09:32:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, jdelvare@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: Re: [PATCH] dt-bindings: hwmon: tmp108: add optional interrupts and
 #thermal-sensor-cells
Message-ID: <20181113173239.GA22310@roeck-us.net>
References: <20181107154708.422-1-heiko@sntech.de>
 <5bea0ecc.1c69fb81.e2af6.29c7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bea0ecc.1c69fb81.e2af6.29c7@mx.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:37:46PM -0600, Rob Herring wrote:
> On Wed,  7 Nov 2018 16:47:08 +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@bq.com>
> > 
> > The tmp108 does have an alert output that can be used as interrupt source
> > and can of course also be used as part of a thermal sensor setup for things
> > like thermal-based cpu frequencies, so document the necessary properties.
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> > ---
> >  Documentation/devicetree/bindings/hwmon/tmp108.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Applied to hwmon-next.

Thanks,
Guenter
