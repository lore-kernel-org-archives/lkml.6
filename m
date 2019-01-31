Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B27C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306C820881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaTIWdLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfAaRTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:19:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43993 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfAaRTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:19:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so1616848pgk.10;
        Thu, 31 Jan 2019 09:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eOaUxd211EH6w7gop+A0WA0d4/YlWxevJ3d+4Lsu3ls=;
        b=MaTIWdLCfEcevThRpTE4YficCHE/0BHutYhkx1qRNwUAJFEMdxOfeA9xgqis9SadMb
         jHnyG9oHkcz8KZKH+TTTjCO5jtyof3wEAlL15F5WC+mTaOCfHTZbuhPx8LUV1NeQcaim
         39CIJL0zyE6YQItfSpHXzgknuCIuIK73i4GI853n2x3nqd4DmcsvGONTY7n7HidjMAhY
         oxxktEaAhVR3fRPDGe7kMHYg7dHxfCzBRwfsguOfzfoc3Vgv4TyMHfddUfI/QZjke2Um
         wTcbgfvT+ERztQT04YnY81ZoOgtW+/ervxoVCoD24jyqNkmmC2dt7pKMZmCyq2McTOBF
         rwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eOaUxd211EH6w7gop+A0WA0d4/YlWxevJ3d+4Lsu3ls=;
        b=Qn0dq3IWGWvj4kcIIZDkpI7RJB+GxVuxCFcjTr68qBD+WibgrrY+hdgOh/LOksHPUO
         RflUrPsK+Wqn1HlP4l5G+dacj0/ZCf3v/aNfg5UD/41D0Bf6tTeMgei0k9Xto0uAnZa3
         0U2ROZQmy3QYOW3iftp9MtKmkg9Dj8fOvBsmjeanMx8WMNLBqKjdvXwHvwGNnfskM0iX
         AFzVHn6GMepT9Od4w9qqJTbvhKXLR5H7JzJXWHPcc5E0JLAMACEX/UhWayw8e3qOqiaR
         oeMOWEsavxO1nxqNjNW2rQxD6w+QFHeMRSLqzf/0HO/fR/z91R8nm5KKhV3DbQ/mo/Qy
         Ir6w==
X-Gm-Message-State: AJcUukfaTJFrRAZyXGwt8edsAa38x7ki8MG55wfUG5izhAGUbKEouKZd
        OyCJYb+aandBJpzArDNWp4w=
X-Google-Smtp-Source: ALg8bN6TxvvzTiag0xUOv1o/d964EICGsrgacAIrnwaCl0+1u2prYG4qA0u5XdRJOIsaz15etOG55w==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr36584656pfc.135.1548955190751;
        Thu, 31 Jan 2019 09:19:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9sm16645598pfd.99.2019.01.31.09.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:19:49 -0800 (PST)
Date:   Thu, 31 Jan 2019 09:19:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] dt-bindings: hwmon: Add tachometer interrupt to
 pwm-fan
Message-ID: <20190131171947.GA14844@roeck-us.net>
References: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
 <1548860827-29796-2-git-send-email-stefan.wahren@i2se.com>
 <20190130172815.GC14781@roeck-us.net>
 <625436113.118199.1548879811777@email.ionos.de>
 <20190130203525.GA23614@roeck-us.net>
 <fbfd2b67-f6d2-4d6e-9351-d1d2165e571b@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbfd2b67-f6d2-4d6e-9351-d1d2165e571b@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 09:02:33AM +0100, Stefan Wahren wrote:
> Hi Guenter,
> 
> Am 30.01.19 um 21:35 schrieb Guenter Roeck:
> > On Wed, Jan 30, 2019 at 09:23:31PM +0100, Stefan Wahren wrote:
> >> Hi Guenter,
> >>
> >>> Guenter Roeck <linux@roeck-us.net> hat am 30. Januar 2019 um 18:28 geschrieben:
> >>>
> >>>
> >>> On Wed, Jan 30, 2019 at 04:07:05PM +0100, Stefan Wahren wrote:
> >>>> This adds the tachometer interrupt to the pwm-fan binding, which is
> >>>> necessary for RPM support.
> >>>>
> >>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 3 +++
> >>>>  1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> >>>> index 49ca5d8..7f69b0b 100644
> >>>> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> >>>> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> >>>> @@ -8,6 +8,9 @@ Required properties:
> >>>>  
> >>>>  Optional properties:
> >>>>  - fan-supply    : phandle to the regulator that provides power to the fan
> >>>> +- interrupts    : contains a single interrupt specifier which describes the
> >>>> +                  tachometer pin output of a 2 pulse-per-revolution fan.
> >>>> +                  See interrupt-controller/interrupts.txt for the format.
> >>> So a hypothetical {1,4} pulse-per-revolution fan would explicitly not be
> >>> supported ? Why ?
> >> i could add an additional property to specify the pulse per revolution and use the 2 as default (according to the Intel spec for 4 pin pwm fan) which should fit in most cases.
> >>
> > That would be a possibility and make sense, but that is not
> > the point here.  The "interrupts" property does not and should
> > not care how many pulses per revolution the fan provides.
> 
> sorry, i'm not sure what's the problem about. Do you want me to use a
> GPIO instead of interrupt?
> 
> Or is it the wording here?
> 

You wording limits the use of interrupts with pwm fans to fans with
2 pulses per revolution. You do not explain why that restriction would
be required or even make sense, or why it should be associated with
the 'interrupts' property.

Logically I assume that is because you expect an interrupt per pulse,
but that is not explained (or what the interrupt is expected to be
used for in the first place - it might, after all, be some kind of
error interrupt).

Guenter
