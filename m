Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6661CC65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACEB2148D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzClb8Mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACEB2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeJEV1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:27:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39072 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeJEV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:27:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id c20-v6so12875647otl.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmjDzKc/dzKvy5tX043ZaikUuJfkyEFzmjZGZ3CTqE0=;
        b=LzClb8Mume0SgAfDObj9AroMMfyEzizeZ35GdCz5aEtOMnYV/btG1NSWHc47xU0H95
         KUXjpH2+8mmAhjZY/ZpdjrzamXlHPv8pw+5aXmQ7EF2kdcz1B51znDfXX+W7fUHX+Qka
         ZIlSsBQEw8GCca3Qmtnhc5FkRjUvffSXIFV00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmjDzKc/dzKvy5tX043ZaikUuJfkyEFzmjZGZ3CTqE0=;
        b=Akq5DroO+kcfDt4tckvE2W0Zgs8M7exEscnRzflYDzjkEH76hGIAMLgZ0+OyQf5wK+
         O1u+ZFkTU69tyv+GT1xAQVgrk2UXXHDvNpz7xY1P1B5JzhBocK0MFg3OcnwnnDG/jeZN
         Uo4Bu0Uaa3RDw4w+/Zjic/WIdi5N6wMB4fPpdFSZI1ndW4D8ihVDHS6hxnzPAdnEDCHA
         Go1IZ2DjLpEudpf9YGwut5Zu8YcJjutco0JrQ5KQGSemdysHV1b3dC3zvxsZBVU2Bm18
         NJLE55fs4GlJIGqly94vpfqKCuk29c4T2rTRiK17LlHlXPngVYxlERRSV4pwCOuUYAjh
         czRA==
X-Gm-Message-State: ABuFfoh4SwU34qtYnXbG8dOMFwwj2GJ616QS3KtLBhBv4kedBaOYut3U
        a5EvY8g8FLG/4RBeg1YbEOe6/A==
X-Google-Smtp-Source: ACcGV60xcUaLhPw8l5fRLHZ0yD3c+cCsPVRA4+lexSl9kYzXiUJ7NuMoj7MddMkDkrLheMf+Nn1rdw==
X-Received: by 2002:a9d:48b9:: with SMTP id d54mr6408282otf.144.1538749714504;
        Fri, 05 Oct 2018 07:28:34 -0700 (PDT)
Received: from localhost ([64.157.242.222])
        by smtp.gmail.com with ESMTPSA id l60-v6sm2496356otl.52.2018.10.05.07.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 07:28:33 -0700 (PDT)
Date:   Fri, 5 Oct 2018 09:28:31 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm-soc <arm@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [GIT PULL] Qualcomm Device Tree updates for 4.20
Message-ID: <20181005142831.GB15665@hector.nxp.com>
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
 <1538332682-12018-5-git-send-email-andy.gross@linaro.org>
 <CAK8P3a3SVftnc83sxe1NCsLbu23Buc+SHOpn9JUQJCZ=MXDuJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3SVftnc83sxe1NCsLbu23Buc+SHOpn9JUQJCZ=MXDuJw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:36:11AM +0200, Arnd Bergmann wrote:
> On Sun, Sep 30, 2018 at 8:38 PM Andy Gross <andy.gross@linaro.org> wrote:
> >
> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> >
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.20
> >
> > for you to fetch changes up to ca02f96b95ca1a50344e7e2a7bb43fbb825aa3a2:
> >
> >   ARM: dts: qcom: Update coresight bindings for hardware ports (2018-09-30 13:14:05 -0500)
> >
> > ----------------------------------------------------------------
> > Qualcomm Device Tree Changes for v4.20
> >
> > * Fix IRQ constants usage on MSM8974
> > * Add led, gpio-button, sdcc, and pcie nodes for IPQ8064
> > * Move/cleanup common nodes for IPQ8064
> > * Add i2c sensor nodes for MSM8974 Hammerhead
> > * Fixes for SAW, kpss, opp, pci range, and space/tab on IPQ4019
> > * Update coresight bindings
> 
> Some of the ipq4019 changes look like important fixes, should
> they be applied for linux-4.19 and possibly backported to stable?
> If so, please submit them again for the fixes branch.
> 
> I also get this one warning (both with and without your patches):
> 
> arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning
> (graph_endpoint): /soc/mdp@5100000/ports/port@3/endpoint: graph
> connection to node '/soc/hdmi-tx@4a00000/ports/port@0/endpoint' is not
> bidirectional

We may very well drop the sd600.  It was not distributed in any large numbers,
was only used for development.  I am in the process of determining whether or
not to send the patch removing this entirely.


Andy
