Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFCEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E082147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNP/IHQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E082147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbeGLP3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:29:54 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45898 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbeGLP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:29:54 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so30900936oic.12;
        Thu, 12 Jul 2018 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ku49n2pnzJt27LJbE9BwCiyKv06T+Enwo4Uz44PDqAA=;
        b=sNP/IHQ6z6n6n6nKpiF+nKkhb/zcQc0NP8so/UZB7xgPq9XxnZ9oWoHaZ7sHQqhyGF
         ml3+hFeLWEfTNxjZdvL8I0Tr3+yiO604R+dDmvzU9hROSbI/K2/glyYwVLkjVlRfdIbW
         G9XLL2gbDf58zaAqnvpZgOoktoaUirLpcuy1kdMaOJUaTuOPVUXKJCIGE1jGohV+leDr
         4n1Cji5GldsmjWKykq3LVYwEyPpEjHofoV+WHm2Vcjtwt0eq0jooB6G0lSea8lmr5mNP
         H5k93LVgkM6nRwPhb7ugBhBMr8WME3Z6rRUFeQOBso+u7yP8eqPyd8zDV91hQA6w0qFy
         mWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ku49n2pnzJt27LJbE9BwCiyKv06T+Enwo4Uz44PDqAA=;
        b=dEEnNfaNHhkFE1iNbd5EaqEtSFyTejo9Z/jr+jKksU75L5OPG6a+SAxwOKc3FGxGN5
         NCRKiM3QAOMPFpauaTXAJ+7SUnHJERvzFDnizRm4jzr884t/+laSAJqyudaDC58kwiyA
         J/Ie9skJhCS4VXt2iUfGLFCbGykIq5jvpV0wkfL4Moq3jh2mu0HNa+uR7lOKaXT4cGN+
         M4XQFqD0hnlrUnOHsbBTs1g4bevi9fAyzY+iMEGylPA5u+8oq/Ljd5MEkAQx+PieVHHK
         P+yb3VGmZBK1W+C6RUtRoQkOedOTMYqt90mLDy12WgnBa1J32ulofQ9A3M/aKoMIsIaT
         kghA==
X-Gm-Message-State: AOUpUlH3QKhehaliWyK7PMuEDAkJ/F7qr+ZtqQN1/ch4tlTdAZwF0JIg
        S7MO3z147346QsnUBuIFU20Z3RnpmqOAcXHbipk=
X-Google-Smtp-Source: AAOMgpfJWRDZyuHH4rUjJLh6Cysoua7QJHUSM/hvRIad6TXv7HzSsETqxQ2KsmPXeOWfCI9MnNHprDKT088Q1UoISPw=
X-Received: by 2002:aca:3a57:: with SMTP id h84-v6mr3006985oia.336.1531408793680;
 Thu, 12 Jul 2018 08:19:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 08:19:53
 -0700 (PDT)
In-Reply-To: <20180712110240.3006-2-m.felsch@pengutronix.de>
References: <20180712110240.3006-1-m.felsch@pengutronix.de> <20180712110240.3006-2-m.felsch@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 12 Jul 2018 12:19:53 -0300
Message-ID: <CAOMZO5Cx-ooNJ8hseTYBvBvWx6mMX0jOsFTmRxC1yogXk0ZZuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pfuze100: add optional pfuze-disable-sw binding
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

On Thu, Jul 12, 2018 at 8:02 AM, Marco Felsch <m.felsch@pengutronix.de> wrote:

> +Optional properties:
> +- pfuze-disable-sw: Disable all unused switch regulators to save power
> +  consumption. Attention, some platforms are using the switch regulators as DDR
> +  ref or supply voltage. Mark these regulators as "regulator-always-on" to skip
> +  disabling these regulators. If not specified, the driver simualtes the

s/simualtes/simulates/

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
