Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F83ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C91A20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIH373yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C91A20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKHX5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:57:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46905 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHX5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:57:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id q5so18199765otl.13;
        Thu, 08 Nov 2018 06:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00QYdpUCoDcYCEhsNg4ja84AlsOP0lD0dpMXOYQ0GYI=;
        b=GIH373yScXVXITC/Lq366ziCObUYrmzLai2ZAKb9tpMvNX8/lVen5+/WMXmkB4DgMO
         JC8pU+pGsWtmQ5ryLEy1Nx/uQ9T4mSRwQpxHG24MuLLaeFQK1w7T3GuRPfezPXF9oG2P
         0Q6zifffl/gglwt6HeKjoegAqbkf65LsrNee/mEkTR1eDn6N/wT+U9EQFrhT6KyxOn/n
         eqwQb4SISmCZ1zhHulXWX7XXS9IUBKg0eA482ho3HtBQtRDyJCwBlzQZkWB77DGMd45M
         8kKFHSr11CG1Q71WHopj61nTirhZsTg+slqhTzHf26uWORgZDHP5Sp60fA1wkcYGilOS
         GZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00QYdpUCoDcYCEhsNg4ja84AlsOP0lD0dpMXOYQ0GYI=;
        b=VW0PIug9GKIIQHQeNJswQ4UG7KF5krZHS7M5/jE/0okwyq4DXQZaBd+jt+6kT/HEPS
         xuDYFnQUQhbiRXyJChQUdDQjEFQ3dOjmLDhPLAyyy8u++gutBTE1TA+OgqjSvi+/gAoE
         c/4shKyCVCYsr+MjM0K8YhPfZfO12v5Zdg7ebftVKu07rufR15PMTbvx8my+B7nPFi6E
         OMoDCNEO2Vjdv12vTquubeNKvZnj3aNn+B+HIy7f89LhGJk3+alBLV20J+tauJM3oxIH
         lJsYgzNNPKVXe7F/fALHA2WhPFTs1Wq1pi+u3as8yRbkOgy7PmH/gFhRbPN0CK6m6DkL
         j6sQ==
X-Gm-Message-State: AGRZ1gJEo1oYZPFZdnYpENRo7an/B+Jc550162g2uZO2xQfE1YD6zTUD
        nk2XUxsO/XElrblBPO5IG0ar7mdNi7s/yLPuFDI=
X-Google-Smtp-Source: AJdET5dL15zsYrORWp9ZUDe7wRGU1YFzhtHTEqW3MXlE6AaQGdBr9INgBjiZP9kfA/xcjifPwO00cOXMe706TFaxvlY=
X-Received: by 2002:a9d:41ef:: with SMTP id v44mr2614857oti.95.1541686893610;
 Thu, 08 Nov 2018 06:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-6-TheSven73@googlemail.com> <CAK8P3a1ZUaxJzfzYoqAK+_ZBazHzF6nG1V2aiZSoiQr6nDhiSQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1ZUaxJzfzYoqAK+_ZBazHzF6nG1V2aiZSoiQr6nDhiSQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 8 Nov 2018 09:21:22 -0500
Message-ID: <CAGngYiW5=oc486wq15yLbRLvO243PNALmouTDEh7QpO6GLO9Mg@mail.gmail.com>
Subject: Re: [PATCH anybus v3 5/6] dt-bindings: anybuss-host: document
 devicetree binding
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, thank you for the review and the feedback !

>
> To allow describing connected devices, I think we need a #address-cells
> and #size-cells property here, with fixed values.

I'm not sure I understand. Connected devices aren't described in the
devicetree. The anybus specification defines an id register, which is
then used to load the client driver automatically, in the manner of
pci/usb.

In case I have misinterpreted your feedback, could you clarify a bit?
Thanks,
Sven

E.g. here's the definition of an anybus client driver, a profinet card:

static struct anybuss_client_driver profinet_driver = {
    .probe = profinet_probe,
    .remove = profinet_remove,
    .driver = {
        .name   = "hms-profinet",
        .owner = THIS_MODULE,
    },
    .fieldbus_type = 0x0089,
};

static int __init profinet_init(void)
{
    return anybuss_client_driver_register(&profinet_driver);
}
module_init(profinet_init);
