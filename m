Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308BAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA95F2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7Av88g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA95F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeLJJ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:57:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44788 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:57:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so4998289pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 01:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aSomdyy3EaiujdjdjsH4y6F6EHOmtCoGU51caHsh8d4=;
        b=N7Av88g1UvjcPjim8avN81M3OjXNaLJ0Fm1sxgdz8Eq2ngWZs03oDbbCo5PfdQOuM1
         N5krfWb0w3XswkGmbz8whbg3mIVJOHP7F5+yrejxk9KbX/zR0+EJdW9Xqt0KFeA0qMoA
         btF+ZZI3CI0IOr+26iGEKtVLbuR8/JrKqTqGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aSomdyy3EaiujdjdjsH4y6F6EHOmtCoGU51caHsh8d4=;
        b=PsJxzbVfKAoiq1dNJbEdKDERB+sB72gmClMyCe/3ZoefZvn2jBdLUx0kDCW4nJKDMn
         MHAZJVFOZcteoy0zCqY5Lp0VQSSMPeSY6jYoxmXbXCK1UMGf9a0cPtozHA267yhtz1P2
         HNAnCfh7ABekXrv58Xy1BmsdYFNGg9ARyPaOLnybTHbPdQy9ZWpRQ/LkYfkn7s9THIWH
         C9ooXqHZU5YVE3Kd18C/rjkm6CFM1TReGK0SZTaC8Z8QPhytWam/dYaABkJJjY27Mp6y
         uXIvjXatcWnMolAwtnmOhe/Ki2izomdTa1Pe/HOVrXLmUj8jeijctsh9DBIyqKzakqAU
         MX3w==
X-Gm-Message-State: AA+aEWZCkwctnqUatz7VG3iW47A3KeUQxZ1ncZ1pm4XHoGkAS04AqS9U
        1GJVx85o8OLuM8fC3Q6YVlUR
X-Google-Smtp-Source: AFSGD/X/T5V1y6iWHcpu64JIzsF7hljVycLkNOjZ1OkL1i4+ZYIL4AzPPYkLsfXETBRrk2ym/Vq8Qg==
X-Received: by 2002:a17:902:d911:: with SMTP id c17mr7354836plz.151.1544435821756;
        Mon, 10 Dec 2018 01:57:01 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id p7sm26710697pfj.72.2018.12.10.01.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 01:57:01 -0800 (PST)
Date:   Mon, 10 Dec 2018 15:26:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net, overseas.sales@unisoc.com
Subject: Re: [PATCH v3 08/15] irqchip: Add RDA8810PL interrupt driver
Message-ID: <20181210095650.GA12397@Mani-XPS-13-9360>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-9-manivannan.sadhasivam@linaro.org>
 <9debdd34-0c4a-a0a3-a284-b6372c2f7fd5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9debdd34-0c4a-a0a3-a284-b6372c2f7fd5@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Dec 10, 2018 at 09:39:13AM +0000, Marc Zyngier wrote:
> On 28/11/2018 13:50, Manivannan Sadhasivam wrote:
> > Add interrupt driver for RDA Micro RDA8810PL SoC.
> > 
> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Given the dependency on the platform Kconfig entry, how do you want this
> to be merged?
> 

Hmmm, I think I can just move the platform Kconfig change to SoC changes
in next revision so that you can apply the driver independently.

Regards,
Mani

> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
