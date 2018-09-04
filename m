Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8492FC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F7220659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAPWCk1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F7220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeIDRS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:18:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36392 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIDRS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:18:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id x207-v6so2866606lff.3;
        Tue, 04 Sep 2018 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8es9PoX8fIxOkxx2e4PCt5th2RS4v5XOWz1z5tmbXjs=;
        b=JAPWCk1pVj2qlp4Dl4OSeg0u8kA/4MtVB9/z24BgXyIf8HmvXpaspflmK/UJOnLAyN
         J83CZ77NLMWZlOAOiJmhAivK0oX+uxVNQM0Sx4ZJEB/6BhwZIM4JAS5QNLi4YEnnXMFR
         9cQHrUWJbN6Xzs8K0Vec95wCQ3254SbWGvdHkvYt4OsbPYwvOpQg9H6NsH2I0d8d0/h0
         kg5+6GGXfWSNbRgjxSjQfBtIyPyaP2xpZChqsWfN1HhdhzeJGJ8lRT3EfL7aknC84T89
         YPICAzolhyXNzQPIrulICcn23n2ZcEXwo6+jLVpwa8Q7VRY+LFS31Bl0xcbZyZYPQbne
         TSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8es9PoX8fIxOkxx2e4PCt5th2RS4v5XOWz1z5tmbXjs=;
        b=TNeuN1xjRQ6wBWdm48nGYKVmXpyL/xa6lJBGEA1BjYGydqluX6vHbC9SNRsi0vBuS+
         uvR7/5wRuSDk+186PxbBx1a/6ytjvwcummRNeUsRhBtlXGSYx7t298HpwCe/vbfK9aap
         A4pTVDDqFz8zfnj/ASTrRiDxvIX9iOG1sZ6nheXdg5UtK8gVzrOJhDTnNRFFWTuO1cML
         XaxXTBNJcz3QXIR5gbfoW6nyXXviBEZrzR1ntr4+3e+cXeyRVcDqTGZzUouQzdFoILK5
         54xAIxEy5XPSS4D/Ekaqnu4786IMdkSlXZSFmcb0YpQrOFAeU6VVLIGSTxXvpxDgiF/X
         aCyw==
X-Gm-Message-State: APzg51B1x0Q6uuR9IrcLVZgk4d48O4fS2BqQUCbSber0UMvtc4f3B2fv
        O3wgr6LXEKRtkMQhsTSe8ZI=
X-Google-Smtp-Source: ANB0VdY0vFfFpHYawhfWoWpW58od+QODtbzbrpvMsD4baITeVqIyzUQ3mYpuL5lMGJk3wFzzaaBv3w==
X-Received: by 2002:a19:57c5:: with SMTP id l188-v6mr21655610lfb.109.1536065634724;
        Tue, 04 Sep 2018 05:53:54 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z5-v6sm4022077lff.96.2018.09.04.05.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:53:53 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxAqI-0001dJ-JG; Tue, 04 Sep 2018 14:54:02 +0200
Date:   Tue, 4 Sep 2018 14:54:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 4/9] mmc: meson-mx-sdio: fix OF child-node lookup
Message-ID: <20180904125402.GR28861@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180827082153.22537-5-johan@kernel.org>
 <CAPDyKFot-Nx=R83vxS=WQp2kSFmMiQ7wfOK4m6hbPt0MB3Z25A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFot-Nx=R83vxS=WQp2kSFmMiQ7wfOK4m6hbPt0MB3Z25A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 04:44:44PM +0200, Ulf Hansson wrote:
> On 27 August 2018 at 10:21, Johan Hovold <johan@kernel.org> wrote:
> > Use the new of_get_compatible_child() helper to lookup the slot child
> > node instead of using of_find_compatible_node(), which searches the
> > entire tree from a given start node and thus can return an unrelated
> > (i.e. non-child) node.
> >
> > This also addresses a potential use-after-free (e.g. after probe
> > deferral) as the tree-wide helper drops a reference to its first
> > argument (i.e. the node of the device being probed).
> >
> > While at it, also fix up the related slot-node reference leak.
> >
> > Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
> > Cc: stable <stable@vger.kernel.org>     # 4.15
> > Cc: Carlo Caione <carlo@endlessm.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for the ack. Rob's gotten the helper into -rc2, so feel free to
pick this one up directly to whichever mmc branch you prefer. I've been
able to trigger crashes after probe deferrals due to the use-after-free,
but this seems unlikely to be exploitable.

Thanks,
Johan
