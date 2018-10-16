Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FD921470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AUnfYc6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FD921470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJQAvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:51:31 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43838 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeJQAvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:51:31 -0400
Received: by mail-ua1-f65.google.com with SMTP id c89so3634405uac.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fuKNXUJS/uVRj8tW7FwdhjIl2osSgUbvVT+7sYT6F0=;
        b=AUnfYc6YzTix7jEi2x9qQmbFIMPFLrKuCDoGQYjTIPKre6P8o12d4bLe9irkYsXuAN
         YK04ofqxn25nFX1+NckHlw8mJP9RnRZp65arSqwnZv7uNgRS2EVViO5IUJOmYU8nuagR
         9cCAP+U9XuF+7ZC1btkA5x6WsimLGzv85iwjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fuKNXUJS/uVRj8tW7FwdhjIl2osSgUbvVT+7sYT6F0=;
        b=m1rqKP+uNOqyeNsW4+g6DJSk6G6WhAoGLXJXQsZf54hcrmOJS8wMZda6ZNkxEDfyPO
         lYuMT6Y/VxdEYYlya5GF37Fle1dlpsYbeGIOQEuia9Fxb7aQGtIpgpR0uk00Xn83eI2j
         xZF1EJXTfPbog7KF7CuLeiYt5o011nG9WP9Qn01RWPKagcdgMZdS6ljYn6fz3LK0FrtJ
         DIh02hDTntdhwZIssQe//K862GI48vSrByOx4UIP1MdvG49OIyiERmKvRV35XB8QAaUA
         oJgk/9Lxa2CyD0QWuM/gK82XW2yrL05atmaIj7t80mMa0xRJ5Fk7KZaOGajokUk1ElCg
         DYfA==
X-Gm-Message-State: ABuFfogaH27Vi18S4vsrIBzj0tjSsD52LSYIBqaGm88FOK97fx41tvoc
        8RY8vcoLcy10L+54iCgfq0rBtEeJA9g=
X-Google-Smtp-Source: ACcGV637HjdDLnbV640o3vA/DqfSiAS0GYeZ90bH3AL9M1gw5gf5o/6FnLehYHHgsaEn7hjJzpyPTA==
X-Received: by 2002:ab0:6005:: with SMTP id j5mr9893429ual.69.1539709211100;
        Tue, 16 Oct 2018 10:00:11 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id f188-v6sm3129848vke.53.2018.10.16.10.00.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 10:00:09 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id a202so18907326vsd.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:00:09 -0700 (PDT)
X-Received: by 2002:a67:8316:: with SMTP id f22mr8896665vsd.6.1539709208870;
 Tue, 16 Oct 2018 10:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181012213926.253765-1-dianders@chromium.org>
 <CAFp+6iFy8V34cs6pEOie_tBX5wJqM7teUnH_XLLZ7cioPrX_hA@mail.gmail.com>
 <CAD=FV=WYM5OOigy+81cVzPtAJXhvrhB1znr9zHzMf3q5iFOtFw@mail.gmail.com> <CAFp+6iGxvDoptnjM18ggnHqX6MV0+HFqsnCMi61b8gquBxaYmw@mail.gmail.com>
In-Reply-To: <CAFp+6iGxvDoptnjM18ggnHqX6MV0+HFqsnCMi61b8gquBxaYmw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 16 Oct 2018 09:59:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWC8q4Cx4GF0yXCgj2APwd5ZfccVBC_ORwnJg0vRsS7A@mail.gmail.com>
Message-ID: <CAD=FV=XWC8q4Cx4GF0yXCgj2APwd5ZfccVBC_ORwnJg0vRsS7A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ufs: Fix the compatible string definition
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        cang@codeaurora.org, Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sayalil@codeaurora.org, Asutosh Das <asutoshd@codeaurora.org>,
        devicetree@vger.kernel.org, liwei213@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 15, 2018 at 10:51 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> > > P.S.: While you are at it, can you please move 'ufs-qcom.txt'
> > > to Documentation/devicetree/bindings/phy/qcom,ufs-phy.txt.
> > > The current name and file location is misleading.
> >
> > I'd rather someone at Qualcomm do this.  Do you have a suggested
> > person?  The reason I feel that Qualcomm needs to get involved is that
> > I see that when I look at the file you refer to says it's for:
> >
> >   "qcom,ufs-phy-qmp-20nm" for 20nm ufs phy,
> >   "qcom,ufs-phy-qmp-14nm" for legacy 14nm ufs phy,
> >   "qcom,msm8996-ufs-phy-qmp-14nm" for 14nm ufs phy
> >   present on MSM8996 chipset.
> >
> > ...but there's another Qualcomm file, 'qcom-qmp-phy.txt'.  That
> > handles the compatible string:
> >
> >        "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> >
> > So I'm a little confused.  Should the SDM845 UFS PHY been handled by
> > the older UFS PHY driver?  ...or should all the older UFS PHYs be
> > moved to be handled by the newer QMP PHY driver?  ...or are they
> > really different hardware blocks, in which case how would you describe
> > the difference (both are described as UFS QMP PHYs I think).
>
> As you rightly said "ufs/ufs-qcom.txt" describes the bindings for
> 14nm, and 20nm ufs phy. These phys are however handled by the older
> ufs phy driver present at:
> drivers/phy/qualcomm/phy-qcom-ufs-qmp-{14nm,20nm}.c
> The sdm845 UFS phy driver is handled by the new consolidated qmp phy
> driver: drivers/phy/qualcomm/phy-qcom-qmp.c whose bindings are
> described by 'qcom-qmp-phy.txt'.
> We didn't attempt to move the 14nm phy to new driver as we already had
> 8996 using the bindings.
>
> So, really these are two separate drivers with different bindings. I
> believe it should be okay to move the file. If you are fine, I can
> attempt to post a small patch to do that.

I guess what I should have said was that the new name you're proposing
"qcom,ufs-phy.txt" is confusing and opening the file doesn't help
clarify things.  The name and the binding make it sound like this is
_the_ file to look at for Qualcomm UFS PHYs.  ...and then you look in
the examples in the file and it seems that this even includes Qualcomm
QMP PHYs for UFS.

...so while I agree that the file "ufs-qcom.txt" needs to be moved to
the "PHY" directory, I think at the same time we need to change the
name of the file and maybe the contents to disambiguate which things
belong in this file vs. the "qcom-qmp-phy.txt".  ...and I feel like
someone at Qualcomm will have the most information to properly do
that.

For instance, you could call the older bindings
"qcom-qmp-phy-14nm-20nm.txt" or something like that.

One point of clarification I'd like to know is if there's really a
good reason to have two drivers here.  Certainly if the hardware is
really different then a new driver can make sense, but if there are
two drivers for arbitrary reasons then maybe they should be combined
into one eventually?


-Doug
