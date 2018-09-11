Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ABEC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4922086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=easymile.com header.i=@easymile.com header.b="A4hn76KI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4922086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=easymile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeIKQpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:45:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35798 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKQpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:45:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so648828wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easymile.com; s=easymile;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qSxecYno4wHuok7Px9UKO7OGA4W1NetrD/YaScP5u2E=;
        b=A4hn76KIs/1oRdomY+Xqtm3arUA69k/ciMhXR/qvZ8qesKYtgcimEV9dgdS0SfRMK0
         pKNwVPqZzxqLhY/eJsXsLTjCRx5VY6ihjcF2IZaglVcC/tKA1YHxIlB+q5xfZghbpfaV
         ZHqIC7RB0iIiaYdMQUFUEq2qmfmiUvmK+GVsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qSxecYno4wHuok7Px9UKO7OGA4W1NetrD/YaScP5u2E=;
        b=LTUsKu/amPMkU+DPBiNfLd1jaLNdaKnpwkNdA9zMcienP0nlvTdtz9a9HE8YlsF1CZ
         RkvmvkekGYd2zl1ZtEEVLMd1w1AerZpFSkmtQlAG2FSQVoWm74n+aGQ5Z9RaiyqF/ai7
         T2zHE6KgaxXyhbGxGewowLIbKQ6goX6hvU8Vf5e+kYHceqdTNlycO0uumZ1Js3/Z3P6A
         AzV3r6ex/CTJSsEI2/BYyCDrTVCs9Vk3oYucaMu+4fe3fC0pLxig9zVvO7HG39gZB4vM
         K0wrkWgDcnZBtlwFygwIcvZcpPDy/dpiiAG/4SkVmOFHZoqFSpHQiDoFYu4UYcCz31TO
         Z+kQ==
X-Gm-Message-State: APzg51AQBmrIKRuCXHzqfcGpfcsA4GhDE2WvWfJnIONntNP7XRnGNTdb
        GBvX2T5zHemPJFRajsvKIJN8BQ==
X-Google-Smtp-Source: ANB0Vdb4Uw8j/8kHM/MWTLc56LPjKV3UO9PZhjxbMKmykr4km2LTks7h47yv7Vp4YTaauXKHjgq3fg==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr1045199wmd.127.1536666390981;
        Tue, 11 Sep 2018 04:46:30 -0700 (PDT)
Received: from super_plancton ([185.116.129.142])
        by smtp.gmail.com with ESMTPSA id z10-v6sm19736926wrv.22.2018.09.11.04.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 04:46:30 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:46:28 +0200
From:   Camille Bordignon <camille.bordignon@easymile.com>
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] e1000e driver stuck at 10Mbps after
 reconnection
Message-ID: <20180911114628.GA12572@super_plancton>
References: <20180806115913.GA21556@super_plancton>
 <CAKgT0UcUV8bQRAhyevfnvwE+yWnWjwAkH0WumUoUK4Fa9SCzhg@mail.gmail.com>
 <20180807064222.GA30741@super_plancton>
 <001556a4-c49c-b96b-0be8-b3c4be7bb09c@intel.com>
 <c1e2cf13-6bcc-498d-03ea-7c3792d675cb@intel.com>
 <20180907062851.GA7336@super_plancton>
 <20180911083147.GA31642@f2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911083147.GA31642@f2>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 11 sept. 2018 à 17:31:47 (+0900), Benjamin Poirier a écrit :
> On 2018/09/07 08:28, Camille Bordignon wrote:
> > Le mercredi 08 août 2018 à 18:00:28 (+0300), Neftin, Sasha a écrit :
> > > On 8/8/2018 17:24, Neftin, Sasha wrote:
> > > > On 8/7/2018 09:42, Camille Bordignon wrote:
> > > > > Le lundi 06 août 2018 à 15:45:29 (-0700), Alexander Duyck a écrit :
> > > > > > On Mon, Aug 6, 2018 at 4:59 AM, Camille Bordignon
> > > > > > <camille.bordignon@easymile.com> wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > Recently we experienced some issues with intel NIC (I219-LM
> > > > > > > and I219-V).
> > > > > > > It seems that after a wire reconnection, auto-negotation "fails" and
> > > > > > > link speed drips to 10 Mbps.
> > > > > > > 
> [...]
> > 
> > I recently figured out that neither the previous patch nor commit
> > 0b76aae741abb9d16d2c0e67f8b1e766576f897d fix this issue.
> > 
> > In these cases, after reproducing the issue, when ethernet wire is connected
> > kernel logs mention full speed (1000 Mbps) but actually it seems it is not.
> > The problem persists.
> > 
> 
> Hmm, so the newer (post 4110e02eb45e) kernels are actually "better", in
> that they accurately report that link speed is 10Mb/s.
> 
Exactly.

> In the end, do you know of a kernel version that doesn't exhibit the
> problem of slower actual link speed?
> 
No. I've tried older version but at some point API has changed and
it fails to compile.
> I had a look at the code and I tried to reproduce the problem on the
> hardware that I have (I217) but could not.
> 
> Also, out of curiosity, have you tried playing with the speed, autoneg
> and advertise settings via ethtool -s to force the link to 1000Mb/s?
Forcing the speed fixes the issue in any case (I mean even when speed is
wronly reported to 1000Mb/s).

Done this way:

#ethtool -s enp0s31f6 speed 1000 duplex full autoneg off

Thanks.
