Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C70FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD9220896
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLN1pkcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD9220896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbeGCG5B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:57:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33177 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbeGCG45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:56:57 -0400
Received: by mail-qt0-f194.google.com with SMTP id l10-v6so708216qtj.0;
        Mon, 02 Jul 2018 23:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9s8QgBuchYPxqarOAtPwGFfQzJxZQuBOE/hmnkFDId0=;
        b=gLN1pkcIqzyrsiKeXIY3CECEqvOAvcMB35fEBQDe10eYvSngGBpXTjmlMke+Xhjj39
         1YAVmTQ3pM+uVaGxX9XVUfDkO+pGjvxo8AH9h6QPo/qiKsGBxbKE8r7nMtyll460UjUc
         W3CeZI+wLmuy4h9P1pjTak7QeTUx9W2yLIGrcowHk8EQF+KY3y8eoRJxerX8sWK/Dsvj
         RSVpVBOYHVZzOVOpmbtQNDlkEYWU9Ao6Vdjwe5ka8lLRmsCZ/MhsswHGOtMsT3E5BHgz
         +2y7DlUt525vyoSSocgYa12G2FWh9MTEe0RoDCSGFA+dcbQFbnJD1hWCNkypJ3Xgk3MD
         ayPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9s8QgBuchYPxqarOAtPwGFfQzJxZQuBOE/hmnkFDId0=;
        b=oph85vUrGlvfSqjiw2KL5Hs27Uni1GHAYqum6vZ6TyIXv6oyYhu2qc93dG8CfVlmm0
         kLw2Tha8OY1nXKsulAbhU6pwOE4dvtMoK4TVchO6fYj0Ne+ds9EX/yY1flpAyQ8XDbFq
         hsLwNhDcuoLEaGWV1dvCrJaxHScVlnvnDKW84bclvMiyDv+4+1LGTLGhljryWooUBYPN
         mwdL5HFT9dYrenvK/GwZN62FIn67ReZ8kgx3AbTmXOUC2PvIcHq5ESKMc9WBZpG0dHS0
         YCWH7by6vuy9bQqY1Z1n6vP8xg52e6q35Qnt+AhfihYt4VB2/jJX1vIKBgYwFobHU9Z8
         J8kg==
X-Gm-Message-State: APt69E18KaQ39O58/PxO05zl+ad9MSL0G2dvJmdxFpDEBbEMxBFYpcF8
        QjGgMw6eAr+iGei20wjKqZ+WDXbxeQ9DEFjLmxA=
X-Google-Smtp-Source: AAOMgpfxrbantpGjrGRfiJoRhlXXMz3BjhX46UskCGcUC/oRlFAweOqZKg1OIqUzY/ZUdHhq5qUajX3bu3yYoLE0E04=
X-Received: by 2002:ac8:950:: with SMTP id z16-v6mr26279595qth.299.1530601016493;
 Mon, 02 Jul 2018 23:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180628054205.17737-1-luaraneda@gmail.com> <20180628054205.17737-5-luaraneda@gmail.com>
 <9d00dae5-835f-43b4-0a78-2aa43bbcff54@xilinx.com>
In-Reply-To: <9d00dae5-835f-43b4-0a78-2aa43bbcff54@xilinx.com>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Tue, 3 Jul 2018 02:56:42 -0400
Message-ID: <CAHbBuxr4ODSDy+ZMFbH-zit3DgY+ULX8OcNXcgD6ZTxvF+gt=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] arm: dts: zynq: rename board zed to zedboard
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Jun 28, 2018 at 2:40 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zedboard.dts
> > similarity index 93%
> > rename from arch/arm/boot/dts/zynq-zed.dts
> > rename to arch/arm/boot/dts/zynq-zedboard.dts
> > index bf3e26dbf..540581c56 100644
> > --- a/arch/arm/boot/dts/zynq-zed.dts
> > +++ b/arch/arm/boot/dts/zynq-zedboard.dts
> > @@ -8,7 +8,7 @@
> >
> >  / {
> >       model = "Avnet ZedBoard board";
> > -     compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
> > +     compatible = "avnet,zynq-zedboard", "xlnx,zynq-7000";
> >
> >       aliases {
> >               ethernet0 = &gem0;
> >
>
> It will just cause confusion and I can't see any benefit to rename this
> file. If you want to state different compatible string with full board
> name I am fine with that but that's it.

Ok, I'll drop this patch for V2.


Thanks,

Luis Araneda.
