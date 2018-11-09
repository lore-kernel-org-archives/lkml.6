Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE54AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BA620827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Du7Annu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BA620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeKIUCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:02:11 -0500
Received: from onstation.org ([52.200.56.107]:46838 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeKIUCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:02:11 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id C20801B;
        Fri,  9 Nov 2018 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1541758933;
        bh=ExR4VjhBi5ZAhofczko3/80kdANn8ZuQyVWqZ30MnoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Du7Annu0SnQs0JzN4yl/f7Z+oTO30acoXbWAby2u9gJjIXr2Gb4bIGn/YrtlsgVSY
         u0bAKR2IAiwU+BNXXxDUb7jS4ldEP2w0o4GwsvcQ8ySznjix6bx6qLFQIl0ngnOkkD
         /gHd9R/9YAeNBk6LX+lMGr0qDU8v96TtcoTSfHT8=
Date:   Fri, 9 Nov 2018 05:22:13 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jonathan@marek.ca
Subject: Re: [PATCH v2 5/7] pinctrl: qcom: spmi-gpio: fix gpio-hog related
 boot issues
Message-ID: <20181109102213.dijt35etkzwdvu2a@ad8ea8ed68ae>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-6-masneyb@onstation.org>
 <CACRpkdaabE-ekKQp93CiFtN_Qp6OohEUE-qufsX=12u2p_SXtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaabE-ekKQp93CiFtN_Qp6OohEUE-qufsX=12u2p_SXtw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:59:08AM +0100, Linus Walleij wrote:
> On Thu, Nov 1, 2018 at 1:12 AM Brian Masney <masneyb@onstation.org> wrote:
> 
> > When attempting to setup up a gpio hog, device probing would repeatedly
> > fail with -EPROBE_DEFERED errors. It was caused by a circular dependency
> > between the gpio and pinctrl frameworks. If the gpio-ranges property is
> > present in device tree, then the gpio framework will handle the gpio pin
> > registration and eliminate the circular dependency.
> >
> > See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
> > gpio-hog related boot issues") for a detailed commit message that
> > explains the issue in much more detail. The code comment in this commit
> > came from Christian's commit.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> 
> No word from Bjorn but I trust my own intuition and applied it.
> 
> Björn: shout if it's wrong.
> 
> Question: should this also be done for pinctrl-ssbi-gpio.c?

Yes, I believe so.

Brian
