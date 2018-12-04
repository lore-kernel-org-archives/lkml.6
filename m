Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF242082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYI1XXW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF242082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbeLDSPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDSPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:15:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510A62081C;
        Tue,  4 Dec 2018 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543947342;
        bh=Y4/p4moEvmuABAAGtdeSo+XewcMe4C8bg/taUOvaUtI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=jYI1XXW6d/ILRf0IXat3o1QE4Ef1DptDzbS94L81/xFH6d3B1WoqwSzTB8iJfF8lZ
         LrAx4Ap+jL/SUrAhLHa6Jc7lfPMz3R/UgI4914rj5m8ytqHzjvAPpc/uBrkB/MR9c9
         q2JyEyIaNJ4XfHgOQGV+qnkuKEbc8fUqwEeFcyP8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <298cd5a5-66cf-0936-405e-59bcc7c396ed@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <298cd5a5-66cf-0936-405e-59bcc7c396ed@socionext.com>
Message-ID: <154394734173.88331.18352656286616172689@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date:   Tue, 04 Dec 2018 10:15:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sugaya, Taichi (2018-12-04 00:26:16)
> On 2018/11/30 17:31, Stephen Boyd wrote:
> > Quoting Sugaya Taichi (2018-11-18 17:01:12)
> >> +void __init m10v_clk_mux_setup(struct device_node *node)
> >> +{
> >> +       const char *clk_name =3D node->name;
> >> +       struct clk_init_data init;
> >> +       const char **parent_names;
> >> +       struct m10v_mux *mcm;
> >> +       struct clk *clk;
> >> +       int i, parents;
> >> +
> >> +       if (!m10v_clk_iomap())
> >> +               return;
> >> +
> >> +       of_property_read_string(node, "clock-output-names", &clk_name);
> >> +
> >> +       parents =3D of_clk_get_parent_count(node);
> >> +       if (parents < 2) {
> >> +               pr_err("%s: not a mux\n", clk_name);
> > =

> > How is this possible?
> =

> When the node has more than 1 clks...
> Or I am misunderstanding your question?

This looks like code that's checking DT for correctness. We don't
typically do that in the kernel because the kernel isn't a DT validator.
That's all I'm saying. I think this comment is not useful if the driver
design is done to specify parent linkages in C code instead of DT, so
don't worry about this too much.

