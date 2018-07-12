Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1656C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F97F21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMfd6JBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F97F21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbeGLP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:28:16 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39476 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732557AbeGLP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:28:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so56436631oib.6;
        Thu, 12 Jul 2018 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x2re6sEyIFh6UFvzoVLgEZJ3iLjpdmrjE6slE9J8KiQ=;
        b=RMfd6JBAbfzCKsERjKBw0B1V6KxeGrAPZxxFismYBpFmVb6936lifzcJ1/wMXfjjPn
         j5c0aXi5bRjsjStytjeN10cNq/tLirmMZjkiygrdS7NMw2KFh/ufaqukBSPQ1jDoviD2
         ELHF2NLK0awy6ROiz8Ry63Md20a1urv8QzkDqLb3JHqjHBabcypvfwdsWbSSnmqo5287
         tHl/w5w+tzDV0vnbU0jCd4b5sdvESHdLtTwSA7QvW0z3014sWjt1TZsqixACrWnDTDy8
         Z9hchablzU57b+GOImkXlrMGcKotDZmlRf7aWwtbXb94xBHt0sJsWeurRgXW+7gPd+2/
         pKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x2re6sEyIFh6UFvzoVLgEZJ3iLjpdmrjE6slE9J8KiQ=;
        b=otQw4XZbfhCiYZ9pQ63leGdujrwnfXBnpsHp7aGyn/F/nVA4x4hMkOeaCU3vCdHmKP
         W7bMfnLU4p0uh64CO98SjclIPLg+1ikVUI1ZJcQwCmUeh6H/bATqZijgnktRaNIBXo/s
         J46zgEP93mweFKOU9vfnpW0HVQpETIlejfHAGjgoq4SXo3fue2/urrPUu+fg4I36TySu
         7C4qlhf7keH15TZeFY24w9R6FN/3GDHmfj0uKGzsiVUoGU4RCOp5aG7x+VEyC2Eyu8zm
         c21rkJA80+JItSF+c3KDcD8VZjMFoq7iFZwFwl0Ov1jNAqLRUwkaxxgwvY+XXg0iexFk
         feog==
X-Gm-Message-State: AOUpUlEKOUcA+9pnajkFqmHyBFEM4xTTMw9Iez5+LhUSml81PpFww5f8
        csDNHnjYulPD3eg6P5XQjgQmq/VV6IIDP9FCDac=
X-Google-Smtp-Source: AAOMgpfg4tQxmNomBbl4WCrxURtoEZ375qonfKJkLJexjzD97+56cBM5OyWD9P/L9gnxGekwhzlBB4mf9t8aTgHxutU=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr2987980oif.9.1531408695339;
 Thu, 12 Jul 2018 08:18:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 08:18:14
 -0700 (PDT)
In-Reply-To: <20180712110240.3006-3-m.felsch@pengutronix.de>
References: <20180712110240.3006-1-m.felsch@pengutronix.de> <20180712110240.3006-3-m.felsch@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 12 Jul 2018 12:18:14 -0300
Message-ID: <CAOMZO5AtrR52+U1XrJbeD6WnuVmsYMESYwq643uFvRE2avJxNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: pfuze100: add support to en-/disable
 switch regulators
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Thu, Jul 12, 2018 at 8:02 AM, Marco Felsch <m.felsch@pengutronix.de> wrote:
> Add enable/disable support for switch regulators on pfuze100.
>
> Based on commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for
> switch") which is reverted due to boot regressions by commit 464a5686e6c9
> ("regulator: Revert "regulator: pfuze100: add enable/disable for switch"").
> Disabling the switch regulators will only be done if the user specifies
> "pfuze-disable-sw" in its device tree to keep backward compatibility with
> current dtb's [1]. Otherwise the regulators are marked as 'disabled', but
> the driver keeps them on. So it's more like a simulated disable.
>
> [1] https://patchwork.kernel.org/patch/10490381/
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
