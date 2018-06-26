Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A980BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568D026D2D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dp1Kd2wQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568D026D2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeFZQlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:41:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32768 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeFZQla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:41:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so8352284pfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eZfKG2ygq0qh2IyanG5PkerECIcLihBK8mnw+GB70mA=;
        b=Dp1Kd2wQXmNhCLo/qjpmn2Gvrnjwn76BzobaLEr0wXpadWuQ1g7G6oim4LpVIsrg0Z
         NDwWF/pFGlldQqJsdMXzWi0ddlYSMqRhCSH1D1e+nUcOB7KGcKmzkJ3qugPErYPPPrId
         0fX/3uaVIQcyubuJOf1l6Wf2Wp3aMDtNjxpRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eZfKG2ygq0qh2IyanG5PkerECIcLihBK8mnw+GB70mA=;
        b=izzNfu7kJacvMEYE/Mtz5PLutwkbG2q/I5nXQoz8eugdo6XhoxJF1uo2vwDc6vcHBF
         FMj4V1AwWiWWkqoEMcVy3C+WU721t4sJjkV6QGSSU8oaem4twGCg2HBlqx44TCju+icA
         zMAF5p+4VSD/irEjGyx0O3pqj9/CJauKO4eqX6lMON1aNiFWbextjJaK+lnNkATqgHo6
         KtYjmguK9LEmr4JppImzrzeVhMnXf4KwhCeDUl2Yqgmcw9F5vkZKda7bgLas3fAaPSEX
         w20WRVQrRYYr7AIGcf/g+VLW0zMVA4dmTQv3H3aqzGClLhhtcbiwHRyOdZakCU8ymqcv
         QbRA==
X-Gm-Message-State: APt69E00Ut+1A7jnlrrbayBMJZQPBCWODomkW8o/Nm8MY0uddJSSfZzt
        JeB+e83ACfvL+CnXYW+jnxcH
X-Google-Smtp-Source: ADUXVKKap4PGJBa88lESdWZWPkmhqZRAFwfcg9DQwtyvOzXs2crqXkqn4QtHgHmvfWZ8yhEDJ8iSQg==
X-Received: by 2002:a63:6092:: with SMTP id u140-v6mr2014501pgb.433.1530031289371;
        Tue, 26 Jun 2018 09:41:29 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:7404:c4e7:e0f7:6d43:b5dd:dab0])
        by smtp.gmail.com with ESMTPSA id r90-v6sm3542737pfl.162.2018.06.26.09.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 09:41:28 -0700 (PDT)
Date:   Tue, 26 Jun 2018 22:11:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     robh+dt@kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        manivannanece23@gmail.com, Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>
Subject: Re: [PATCH 1/4] dt-bindings: power: Add Actions Semi S900 SPS
Message-ID: <20180626164117.GA5241@Mani-XPS-13-9360>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
 <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
 <a261bae6-d2fa-a550-7232-7647ce0ac0e2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a261bae6-d2fa-a550-7232-7647ce0ac0e2@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Sun, Jun 24, 2018 at 03:04:21PM +0200, Andreas Färber wrote:
> Hi Mani,
> 
> Am 11.04.2018 um 18:40 schrieb Manivannan Sadhasivam:
> > Define power domains for Actions Semi S900 SoC Smart Power System (SPS).
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/power/actions,owl-sps.txt  |  2 ++
> >  include/dt-bindings/power/owl-s900-powergate.h     | 23 ++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >  create mode 100644 include/dt-bindings/power/owl-s900-powergate.h
> > 
> > diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> > index 78edd63641e8..a3571937b019 100644
> > --- a/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> > +++ b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> > @@ -3,11 +3,13 @@ Actions Semi Owl Smart Power System (SPS)
> >  Required properties:
> >  - compatible          :  "actions,s500-sps" for S500
> >                           "actions,s700-sps" for S700
> > +                         "actions,s900-sps" for S900
> >  - reg                 :  Offset and length of the register set for the device.
> >  - #power-domain-cells :  Must be 1.
> >                           See macros in:
> >                            include/dt-bindings/power/owl-s500-powergate.h for S500
> >                            include/dt-bindings/power/owl-s700-powergate.h for S700
> > +                          include/dt-bindings/power/owl-s900-powergate.h for S900
> >  
> >  
> >  Example:
> > diff --git a/include/dt-bindings/power/owl-s900-powergate.h b/include/dt-bindings/power/owl-s900-powergate.h
> > new file mode 100644
> > index 000000000000..f1aaf761112b
> > --- /dev/null
> > +++ b/include/dt-bindings/power/owl-s900-powergate.h
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> checkpatch.pl warns about this line due to not using /* ... */ syntax
> for headers. I could fix that up on my own, but it made me realize that
> you are licensing this file under GPL-2.0+ only, whereas the .dts[i] is
> supposed to be dual-licensed.
> 
> Can you please give your consent to make this
> 
> /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> 

You can change the license to GPL-2.0+ OR MIT.

> like my S500 and S700 bindings?
> 
> Question: Should it still be GPL-2.0+ or the new GPL-2.0-or-later?
>

I think GPL-2.0+ is fine.

Thanks,
Mani

> Otherwise looks fine, except that I'll need a topic branch
> (v4.19/s900-sps-bindings) if we want to merge the driver portion at the
> same time.
> 
> Regards,
> Andreas
> 
> > +/*
> > + * Actions Semi S900 SPS
> > + *
> > + * Copyright (c) 2018 Linaro Ltd.
> > + */
> > +#ifndef DT_BINDINGS_POWER_OWL_S900_POWERGATE_H
> > +#define DT_BINDINGS_POWER_OWL_S900_POWERGATE_H
> > +
> > +#define S900_PD_GPU_B	0
> > +#define S900_PD_VCE	1
> > +#define S900_PD_SENSOR	2
> > +#define S900_PD_VDE	3
> > +#define S900_PD_HDE	4
> > +#define S900_PD_USB3	5
> > +#define S900_PD_DDR0	6
> > +#define S900_PD_DDR1	7
> > +#define S900_PD_DE	8
> > +#define S900_PD_NAND	9
> > +#define S900_PD_USB2_H0	10
> > +#define S900_PD_USB2_H1	11
> > +
> > +#endif
> > 
> 
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
