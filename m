Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A1C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3232086B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3232086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754310AbeFTCfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:35:16 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:58317 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754014AbeFTCfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:35:15 -0400
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 20 Jun 2018 02:35:05 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 19:35:02 -0700
Received: from localhost (10.20.78.225) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 19 Jun
 2018 19:35:02 -0700
Date:   Tue, 19 Jun 2018 19:35:02 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mips: generic: allow not building DTB in
Message-ID: <20180620023502.r5e6j222qml2bb47@pburton-laptop>
References: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
 <20180425211607.2645-2-alexandre.belloni@bootlin.com>
 <20180425220149.GI4813@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180425220149.GI4813@piout.net>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529462099-637137-2582-19112-2
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194212
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-Orig-Rcpt: alexandre.belloni@bootlin.com,jhogan@kernel.org,ralf@linux-mips.org,allan.nielsen@microsemi.com,thomas.petazzoni@bootlin.com,linux-mips@linux-mips.org,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Thu, Apr 26, 2018 at 12:01:49AM +0200, Alexandre Belloni wrote:
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index 5e9fce076ab6..3d3554c13710 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -404,7 +404,7 @@ endif
> >  CLEAN_FILES += vmlinux.32 vmlinux.64
> >  
> >  # device-trees
> > -core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
> > +core-y += arch/mips/boot/dts/
> >  
> >  %.dtb %.dtb.S %.dtb.o: | scripts
> >  	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
> > diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
> > index 8982b19504a3..437ec65ec14a 100644
> > --- a/arch/mips/boot/dts/mscc/Makefile
> > +++ b/arch/mips/boot/dts/mscc/Makefile
> > @@ -1,3 +1,3 @@
> >  dtb-$(CONFIG_MSCC_OCELOT)	+= ocelot_pcb123.dtb
> >  
> > -obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> > +obj-($CONFIG_BUILTIN_DTB)	+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> 
> I made a typo here, I'll resend after waiting for a few comments.

Are you happy with this series apart from fixing up the above?

If so I'm happy to s/(\$/$(/ whilst applying this.

Thanks,
    Paul
