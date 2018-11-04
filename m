Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0092AC6786F
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B445520847
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zZKyTU5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B445520847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeKDM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 07:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbeKDM1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 07:27:31 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D466A2082A;
        Sun,  4 Nov 2018 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541301251;
        bh=b8AC6Cqcrn8Irh108e/IGsv5dHDHo7jtHrYsH/0HqxI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=zZKyTU5iTwzjEX/vza1b8dqtxQScZUByE0axN/bXdC+jdCDPQOGE2BU5YDXGZue5e
         Vg5et8T6sNRicKv4dL3PAaGNtrUFvs1AY8mfaoe1M4qDiTrEUz6bxh77Y9YFlBR9HV
         xbFjmRXq8IuJVUQK4RBhxV6zVZ37F+QgA9M5+gjY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jiada Wang <jiada_wang@mentor.com>, geert+renesas@glider.be,
        horms@verge.net.au, magnus.damm@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9f9fbf3a-4455-bdf3-0438-b39b9cdda112@mentor.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
References: <20181025072349.15173-1-jiada_wang@mentor.com>
 <20181025072349.15173-3-jiada_wang@mentor.com>
 <154083775062.98144.11157403961171783929@swboyd.mtv.corp.google.com>
 <9f9fbf3a-4455-bdf3-0438-b39b9cdda112@mentor.com>
Message-ID: <154130125117.88331.5969014008610987799@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH linux-next v1 2/4] clk: renesas: Add binding document for AVB
 Counter Clock
Date:   Sat, 03 Nov 2018 20:14:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiada Wang (2018-10-31 05:00:49)
> On 2018/10/30 3:29, Stephen Boyd wrote:
> > Quoting jiada_wang@mentor.com (2018-10-25 00:23:47)
> >> +Required Properties:
> >> +  - compatible: Must be "renesas,clk-avb"
> >> +  - reg: Base address and length of the memory resource used by the A=
VB
> >> +  - #clock-cells: Must be 1
> >> +
> >> +Example
> >> +-------
> >> +
> >> +       clk_avb: avb-clock@ec5a011c {
> >> +               compatible =3D "renesas,clk-avb";
> >> +               reg =3D <0 0xec5a011c 0 0x24>;
> > This is an odd register offset. Is this just one clk inside of a larger
> > clk controller?
> >
> Yes, avb_counter clock is part of Audio Clock Generator reg: <0 =

> 0xec5a0000 0 0x140>,
> but "adg" has already been declared in R-Car GEN2/GEN3 SoC .dtsi file, =

> with reg: <0 0xec5a0000 0 0x100>,
> which leaves <0 0xec5a0100 0 0x140> currently not used by any module.
> =


So why can't we expand the register size in the dts file and update the
audio clock generator driver to register this avb clock too? Presumably
the mapping is large enough to cover the clk registers already so it is
more of a formality to expand the register size than a requirement.

