Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3AE218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vE10Ib9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbfA3Ufb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:35:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40736 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387609AbfA3Uf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:35:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so348926plq.7;
        Wed, 30 Jan 2019 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GmctxZS15y5z2V85O1PU0CkJgxCRKgIbZyDbKcO3Mk4=;
        b=vE10Ib9j33MNS8aeBLU3oTRIYMUczk7bWwdZ8xzpTtLOmD8IoWlK9IaPZFkT5imD50
         FAQbxastdeP+5TMqtCHqLGba+9Iuqf9Rm79lpHt2KSt1OwZFT0RRH3nw7qwmR8H2kB6P
         cdEKXHTs1UO9fSniiytt9s3SIc+l4FR5rAwRk52J0/sv95gya4cHVguCmtfV8W9YLMdF
         GjakZfeyCRYjhSiTlnMr67chMEspOnTAxGg+Wou2p1+MOSpTfVw7g1B3DTfCLoryh6uH
         1TnkOg2bT6Hh2ryFVfgJrGDlxSfcTagzEwIG+u9STjfTI7+PVmX4D8shJFZSCwkNHMtp
         Tz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GmctxZS15y5z2V85O1PU0CkJgxCRKgIbZyDbKcO3Mk4=;
        b=a9G5+6d3GEyQJrz89cfKJC12+49pYVrX+sjPwZ4B7LRDQEDuVV/MNn10TZADOsxEjb
         f1kP5VtyQxwLzTwqkkXzyFjY5jYADD70x0m6R9F9KuZpYERheAroe1Y9d4ok3LC0MLmm
         RsGh9TriIbKyPUrQFzDBMhCj8Sh97hK9kOK8ti6iBVmZS6A7yJeR6rdfXA/6YmIkBj5Y
         mY172uDG9Mb5MJqDVUQ/z/uL1DN+QMTN5rzE+V291fZoG80BLSqjrY1aMmD86lWRBSvt
         hzE2k3e0oPuAh9Xx2C5KFMPNcjFFxIqXg3Q3SMiRH3OS7zQbR3me7lYKV89YaDmuP5bp
         Kdyw==
X-Gm-Message-State: AJcUukd34c4rq9CAlQxknayKnQnQqrcb4mGPj7pML54DJNszxEFvrP46
        Jcku2v0OAGratniFyJ96Vyv1qW+F
X-Google-Smtp-Source: ALg8bN5iGhvp3GNJ9Ecjt5mQ6fhf1lHT8zqiIyfAQXw6CRg/SxunR0dFOF2QJcAgOKh1tRC2N97zQg==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr32224925plm.212.1548880527936;
        Wed, 30 Jan 2019 12:35:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m19sm6404798pgn.35.2019.01.30.12.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:35:26 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:35:25 -0800
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
Message-ID: <20190130203525.GA23614@roeck-us.net>
References: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
 <1548860827-29796-2-git-send-email-stefan.wahren@i2se.com>
 <20190130172815.GC14781@roeck-us.net>
 <625436113.118199.1548879811777@email.ionos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625436113.118199.1548879811777@email.ionos.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 09:23:31PM +0100, Stefan Wahren wrote:
> Hi Guenter,
> 
> > Guenter Roeck <linux@roeck-us.net> hat am 30. Januar 2019 um 18:28 geschrieben:
> > 
> > 
> > On Wed, Jan 30, 2019 at 04:07:05PM +0100, Stefan Wahren wrote:
> > > This adds the tachometer interrupt to the pwm-fan binding, which is
> > > necessary for RPM support.
> > > 
> > > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > ---
> > >  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> > > index 49ca5d8..7f69b0b 100644
> > > --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> > > +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> > > @@ -8,6 +8,9 @@ Required properties:
> > >  
> > >  Optional properties:
> > >  - fan-supply    : phandle to the regulator that provides power to the fan
> > > +- interrupts    : contains a single interrupt specifier which describes the
> > > +                  tachometer pin output of a 2 pulse-per-revolution fan.
> > > +                  See interrupt-controller/interrupts.txt for the format.
> > 
> > So a hypothetical {1,4} pulse-per-revolution fan would explicitly not be
> > supported ? Why ?
> 
> i could add an additional property to specify the pulse per revolution and use the 2 as default (according to the Intel spec for 4 pin pwm fan) which should fit in most cases.
> 
That would be a possibility and make sense, but that is not
the point here.  The "interrupts" property does not and should
not care how many pulses per revolution the fan provides.

Guenter
