Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E104CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51292177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51292177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbeHMVzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:55:45 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43354 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbeHMVzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:55:45 -0400
Received: by mail-qk0-f196.google.com with SMTP id z74-v6so11742751qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 12:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EOogoXKHwA4zGH+LVUcAbwkU09lkivXbOne/fyudKtw=;
        b=sp/AaA+JS6WBxz66uC3HLag3+Rq8702pPzFuEjOXGbvkWjEOyKeBeREHIqyAVUNFxj
         0S/0vtwIRxES5TEKKR75bKyfSrs2x71AP/FvsxpoABFaKdtmUd1B1/hRjJagSu2C2gko
         VOX9R78TXzrX7l7E8ZwTe1BpFmfj/WonODttpwjAzz6OCmVPA00UbJfDrZPgfWIGVFkh
         HeChLFMFIcjk0kxbKHVtuuJqe6lzJ8MFr7nOGkExYMqk9GcbLszvYeF2pimkaanKtaTX
         hP40dsjXDX1rjaoD61qJObch5mptZMlO1cfHjWQxuLQMoidHjshGUc08IBNiLYZo9Jxm
         A4LA==
X-Gm-Message-State: AOUpUlHt5J0nZUHwXGtT8HkQXPL5flHCDeOpeVr3uhQmZ2+57jGwpoKS
        bvzVLtTakuh64P70ZO2WW7WgDQ==
X-Google-Smtp-Source: AA+uWPwKC57jKL9Ys6cLQcD+Hmiurs63L70IGUh2mIGSHlWufkzzOOEKLGA/uH1qt2Bs/N5O/4kBRw==
X-Received: by 2002:a37:afc5:: with SMTP id y188-v6mr17481374qke.273.1534187533671;
        Mon, 13 Aug 2018 12:12:13 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id c20-v6sm8416390qtq.30.2018.08.13.12.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:12:13 -0700 (PDT)
Message-ID: <5eedf19a59f06a4c7055660dc85d6dc23964abe9.camel@redhat.com>
Subject: Re: [PATCH v6 3/5] drm/nouveau: Fix deadlock with fb_helper with
 async RPM requests
From:   Lyude Paul <lyude@redhat.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "# 3.9+" <stable@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 13 Aug 2018 15:12:11 -0400
In-Reply-To: <CAKb7UvjqVC5w4PDaVLtZqKs94bo22d4BGYgsQj9K-2_rksoqvg@mail.gmail.com>
References: <20180813190706.24172-1-lyude@redhat.com>
         <20180813190706.24172-4-lyude@redhat.com>
         <CAKb7UvjqVC5w4PDaVLtZqKs94bo22d4BGYgsQj9K-2_rksoqvg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 15:11 -0400, Ilia Mirkin wrote:
> On Mon, Aug 13, 2018 at 3:07 PM, Lyude Paul <lyude@redhat.com> wrote:
> > +bool
> > +nouveau_fbcon_hotplugged_in_suspend(struct nouveau_fbdev *fbcon)
> > +{
> > +       bool hotplug;
> > +
> > +       if (!fbcon)
> > +               return false;
> > +
> > +       mutex_lock(&fbcon->hotplug_lock);
> > +       hotplug = fbcon->hotplug_waiting;
> > +       mutex_unlock(&fbcon->hotplug_lock);
> > +
> > +       return hotplug;
> > +}
> 
> I'm probably missing it, but where is this function used?
oh no you aren't, I thought I got rid of that function! will respin in just a
moment
-- 
Cheers,
	Lyude Paul

