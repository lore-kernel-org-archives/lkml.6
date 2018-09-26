Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D26C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214E32089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyCW38m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214E32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeIZMZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:25:49 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:46063 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeIZMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:25:49 -0400
Received: by mail-pg1-f174.google.com with SMTP id t70-v6so8540805pgd.12;
        Tue, 25 Sep 2018 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSzlvBMQumDskGG6DeB3QO1VWt2EZsQefxT+1LJ+xiA=;
        b=FyCW38m6SnOFHikAwus1sKTutdhifDbrtsRMktZcpJVnoEBdWF51sBeU3vVzOf9uD3
         nQcNIhFRJuZNwnC7z5qK1Db1haBhbjz88fAkP9zFShZW7WFLUw9eWF+GDwVhrLCE6+u3
         ESHG4pvathoNG6StDiJScJgBZ65+nXCmE4wlRAXimpDiwxQqf6lEerEf8J+YnSbL/ln+
         aQfQ/2MCYc7b4irUU222EtsE7cuOqrfmoESaiwBHzM2NBUHSxCEg/LEGL2MUqHCoFYC0
         aSLsDkJUE8i8UnQQIvoqcccY1aME2zJ4QUgDzz3/2hQ+zKRIQBPG3ktSaCKNdEqVdy3N
         Zl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSzlvBMQumDskGG6DeB3QO1VWt2EZsQefxT+1LJ+xiA=;
        b=hY5rvBq24l7Du1zZ9mW74lkFF1mmSx8uTmvIZbp/YGy0yKwGc4OT0dFAmyHIEpd/ON
         Ery+h4AqMaV1vQZ4rP/DIYy1hAfSbhYMqpAT4rTV34X1zjzM59gIVwdfDXipxPD2HSeV
         vMPf497oSPSvageCpsSt6+EAvmQvGMmZHOkAEeYkF30D3QGsk6wij6yCHA29iITb6NWG
         lXZRQD8N/leexq44y4oV58fFdKgwHSCcToCKfJP78JFMUVToobHRhY483y93Mp5pEivL
         MNi6XpMZTOmOU+LhFdXQMBcT6aPzOISs6COCHo77QILRrCjwlslsGd2Uj5VYLdNJ4B3b
         llUQ==
X-Gm-Message-State: ABuFfoimuF/i23uP3jeSONqq1vcY70MNMdtD/SLn479FrQLQyupnBxMT
        DpI6sxiCxPjHTZWnPM+BATE=
X-Google-Smtp-Source: ACcGV62NkwEovGoClohyUCaSIqg9fbcXAMrv0A9FdkoLvw2zThZQJWjOKQB9nkzoTJkD9WvobRZGoQ==
X-Received: by 2002:a17:902:bc8b:: with SMTP id bb11-v6mr4395150plb.112.1537942471119;
        Tue, 25 Sep 2018 23:14:31 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id g12-v6sm856942pfo.50.2018.09.25.23.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 23:14:30 -0700 (PDT)
Date:   Tue, 25 Sep 2018 23:14:19 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180926061418.GA900@Asurada>
References: <20180925225930.31886-1-nicoleotsuka@gmail.com>
 <20180925225930.31886-2-nicoleotsuka@gmail.com>
 <4f16baf7-b1bc-c7d2-3dd9-ed10b78d59b6@roeck-us.net>
 <20180926030857.GA458@Asurada-Nvidia.nvidia.com>
 <7896d6d6-c7c0-b462-3150-5ceff906bae0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7896d6d6-c7c0-b462-3150-5ceff906bae0@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 08:40:59PM -0700, Guenter Roeck wrote:
> >>>+2) child nodes
> >>>+  Required properties:
> >>>+  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221

> >>>+  input@0 {
> >>>+          reg = <0x0>;
> >>>+          status = "disabled";

> >>saying at the same time that I would like to see this work for other chips
> >>as well.

> >>Other chips have different kinds of sensors. Voltage, current, power, temperature,
> >>and others. Whatever we come up with should support that.
> >>
> >>I see two possibilities right now. We can stick with reg and add a "type" property,
> >>or we can make the index something like
> >>	{voltage,current,power,temperature,humidity}-{id,index}
> >
> >One small concern is a case of being multi-type. For example, I saw
> >ina2xx driver having voltage, current and power at the same time...
> >
> Yes, with that we would have something like
> 
> 	voltage@0 {
> 		type = "voltage";
> 		reg = <0>;
> 	};
> 	current@0 {
> 		type = "current";
> 		reg = <0>;
> or
> 	voltage@0 {
> 		voltage-id = <0>;
> 	};
> 	current@0 {
> 		current-id = <0>;

I see the point now. So this could be a good binding for different
types of sensor input sources. Then the hwmon device driver side'd
also get a hint from DT, or potentially have further common helper
functions or structures being defined in the core driver.

Yet I feel that we could still have something more obvious to tell
which exact port that the input source links to. From my point of
view, neither "type-id" nor "type + reg" nor "reg" only perfectly
tells the port connection information. It somehow feels like that
we are assigning an ID or even an address to an input source; Yes,
we describe them in the doc, but by reading the device node itself
without knowing the famous "reg", it's a bit hard to tell. And not
to justify for my way, but both the "input-id" in the v2 and the
"pwm-port" in the aspeed patch sound relatively straightforward.

If we could make something similar to regulator bindings, probably
it would make more sense. I know the standalone voltage node might
be odd though, just trying to express my concern.
	source0: voltage0 {
		type = "voltage";
		lable = "VDD_5V";
		shunt-resistor-micro-ohm = <5000>;
		/* status = "disabled"; */
	};
	ina3221@40 {
		port1 = <&source0>;
		/* port2 = <&source1>; */
	};

> With "type", we would still need two properties.
> 
> 	reg = <0>;
> 	type = "voltage";
> 
> and type could be optional or not required for a chip only supporting
> a single sensor type (like the ina3221).
> 
> This would be equivalent to, say,
> 	voltage-index = <0>;
> when using a single property.
> 
> With the "reg" approach, we would be ok for now - however, I would like
> to get feedback from Rob if introducing a "type" property will be
> acceptable when the time comes to do so.

OK. Let's see how Rob replies. If he strongly feels "reg" is still
essential, at least this patch can be Acked first -- reduces turn
around time :)

> >By the way, I have two ina3221 hwmon patches that rebase upon this
> >binding series. And I'd like to send them out to go through review
> >first, but I am not sure if you'd be okay for it -- I don't really
> >like to change their rebase order as it might mess up something.
> >
> Are those bug fixes or further enhancements ? For enhancements,
> it is your call when to send them; I am fine either way. If they are
> bug fixes, they should come first so we can apply them to -stable.

Understood. They are adding new sysfs nodes, like in[123]_enable
as you suggested during the previous review. I'll send them soon.

Thanks
Nicolin
