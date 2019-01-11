Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41466C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108042133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547244432;
	bh=cry8ka0UcsPL2eaNlb/w7tXR7U14g81gdG3LEwqEbQ8=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=MHk3Lsp7Yjtp7sVHatGZ+i4PXYG4iOjtPpfZcEpQJxOoDApzy9KgYjdWM+ifv/rg9
	 4lrHW2Xrh3kxt0DS0DJ2rjCiYEh/h8QsjLqwdyv8gKIMe12d0z01NzgeRb9U3DBOq+
	 c1sQlQLN1qewM2sCJq348Ej4gGWMwGwHarrJQFsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfAKWHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfAKWHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:07:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2023D20878;
        Fri, 11 Jan 2019 22:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547244430;
        bh=cry8ka0UcsPL2eaNlb/w7tXR7U14g81gdG3LEwqEbQ8=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=VEJVswjNW/obY6gQq0qVRsk0hef1kFH/7Z9jUc/V6QkaQy1z71wr/gxEubdRvHzWU
         474i/LqsYBDSVFhd7c1XrkJgDP0MAJiXdg41lj2gRtuLmA+omwoPzraTLHjNPlE/5A
         5n1yB2276hr8WQKnT6o3VmCGliIKnXK1pfScoxw4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/6] spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical IRQ chips
User-Agent: alot/0.8
In-Reply-To: <20190110011258.17227-3-masneyb@onstation.org>
References: <20190110011258.17227-1-masneyb@onstation.org> <20190110011258.17227-3-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154724442941.169631.5308212449003169927@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 14:07:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-09 17:12:54)
> Convert the spmi-pmic-arb IRQ code to use the version 2 IRQ interface
> in order to support hierarchical IRQ chips. This is necessary so that
> spmi-gpio can be setup as a hierarchical IRQ chip with pmic-arb as the
> parent. IRQ chips in device tree should be usable from the start without
> the consumer having to make an additional call to gpio[d]_to_irq() to
> get the proper IRQ on the parent. Driver was tested on a LG Nexus 5
> (hammerhead) phone.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v2:
> - None
>=20
> Changes since v1:
> - Add intspec variable to qpnpint_irq_domain_translate to reduce the
>   overall diff.
> - Remove irq_domain_disassociate hack.

I thought we would need to keep that around? And then dispose of the
hack later on. Won't this just wreck the world almost immediately
because the MFD is counting irqs from DT?

