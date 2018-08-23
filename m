Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2809C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A792152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZFdCtFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A792152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeHWOxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:53:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeHWOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:53:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so4308438wrb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8Zd2sBxVc4NBfk+NgnGMMX54fOPw1VQOmTIyj01kPTI=;
        b=iZFdCtFR9Nd76Hkz5vajpKcUcEYr7LjiEzCWbo/eOCKGfqHjmvjvmSitx181bK9GFP
         IxdPCVyRyjdEdp3asZj4S6ExnHdXIIyO7pTglANbxgHK1ZrkgtP2bWgrw2SYLcghS4+d
         i+WFYxqe4VQLMeL3qaT2pMZpLGG9ksAuxceew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8Zd2sBxVc4NBfk+NgnGMMX54fOPw1VQOmTIyj01kPTI=;
        b=U4IrngYx/XbqIYvBMDyYFgb5mrge7jktCGMUayxzVfMHw2HIMf7VYWLhRNEOzEiM2j
         uBypZW+PYpm5Hz+l1xzQK/D+Du4IMEhE6SQkVQwv9rPc2CvUM5iJgQZju1UvXN6EqcK+
         nBTKTqitw1FW9/qxqlvq/aFFkmxTnP0GU/hJe7SQeSG8MvgOrz/fFaAQ5wUAiT/qMNUz
         nFiGYHurhQh1poBNpQAeP/uFb5LjCaG7I7ZsnIy/B2dT4UAfGbYCA4xHGoAdIJHys3t8
         ITOFN18ChPZfxZ6zBmggC4/cbjICAdRQm14LvLc46/mmMGH7BLdQBh4mL3NOnJBDWtbh
         XzcA==
X-Gm-Message-State: APzg51AaWsLNCy+n6EClVq64MwAhMWR3I6JUOTK5TVaj//jAaRxoP5lM
        NAIdm1VFlvX64NJHQnw5FKFjqA==
X-Google-Smtp-Source: ANB0VdaT32bxoYAEnkSy26O5PZSVTqc/pkrXmNVswOkaXEiJTLkQJlG3lsGi3aHx5+9Jd6f0tDfJ2w==
X-Received: by 2002:a5d:4152:: with SMTP id c18-v6mr13161234wrq.61.1535023432345;
        Thu, 23 Aug 2018 04:23:52 -0700 (PDT)
Received: from dell ([2.27.167.102])
        by smtp.gmail.com with ESMTPSA id h7-v6sm3985267wrs.3.2018.08.23.04.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 04:23:51 -0700 (PDT)
Date:   Thu, 23 Aug 2018 12:23:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "richard.genoud@gmail.com" <richard.genoud@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v11 0/6] Driver for at91 usart in spi mode
Message-ID: <20180823112349.GB28860@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <ba108fbe-d3c4-a60e-a1c0-441fe3082212@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba108fbe-d3c4-a60e-a1c0-441fe3082212@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018, Radu Pirea wrote:
> I saw that the patches were not applied to your tree for this kernel
> version. After the discussion with Nicolas, I remember that you said that
> you will take the patches in your tree. I addressed Mark comments related to
> the last version of patches. Is there something that must be reworked in
> order to take the patches?

I don't remember back this far, so can't provide you with any good
reasons as to why the set wasn't applied.  There doesn't appear to be
anything wrong or wanting from the set, although it was submitted late
in the release cycle.

Just to let you and other readers know; since email is almost
exclusively used for submitting, reviewing and tracking patches, and
my setup (mbsync/mutt) can be a little temperamental at times, there
are instances, albeit rare ones when patches/sets fall by the
wayside.  In these instances, my suggestion is always for the
submitter to resubmit with a RESEND in order to regain attention to
the set.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
