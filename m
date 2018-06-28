Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6506EC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C27924B3F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKfKIZzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C27924B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933005AbeF1FTv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:19:51 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41711 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeF1FTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:19:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id y127-v6so3202877lfc.8;
        Wed, 27 Jun 2018 22:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l0qfrv/Dgth6OMQYg2GtUChO1qv03sjYcYdZeharIv8=;
        b=gKfKIZzlDaKMbSuqZ7iuUIE5RAvi02KuuXuNkQGWKLZZYvHiVjAZYMNSBAtiNlokCn
         czPt2cyLaskX+VrvYAeGcuylq7sUWug62kPzyYYGJDQF1FlLGjNy/SjGDirX73Th2+Fi
         UIGAksXyTBnRoNLv/yL9xm7BpLNp5U+3eie/k+wldpAgexY287x/M5p1HijTD82p2YjK
         6yNTjUqVTvEGbmJ38JyRPUMk07k1qze1L3SYEu7iakAvTupX+Iq6uz+sB7sBVy4tmcCq
         pK5qn38X5d1nNC801cPJZLeuBfHc7HZO4k54fm+X7RWy4om0dVbUE+cKAy6/jVtn7qli
         Og4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l0qfrv/Dgth6OMQYg2GtUChO1qv03sjYcYdZeharIv8=;
        b=eOkPd12yjX8Q6gEcl8LRZWSThDTy97K1g8Ty2u7pLi5t9V30AWhwS7MnGOhTXEE3++
         qkk9/OVD79tBcCJEzTtoWiz/O55KRX6kOEzL1wzcj9XM0c35LZaMg9gzGIbDT4kjQPub
         g8URk+/h4rl/2SZCG/KB0+N5iw07XaLB4ZpnAd63FWn3G5h3rKYytfQMEsgiF1fRYqhq
         MLsRxfbW0GldpbGAHmJ1Y1gWKEvgzj8WNFM1vqD5lgKefENf6CcSX4E2AtKZTN3hCXxP
         a7fEUuyMBYkWzxWCEjJxPq5FkrMM9rIfEBo6qMywsmp642cgH6lXcvylKAWv9+/goPt+
         c0kg==
X-Gm-Message-State: APt69E3efQm5JE8t74mh5w1MRpH5gAUccHggL/I5aIJxNyJEWn7orGWK
        sDfoaNtzDdKTMDM9DXH6T2jJrQnK
X-Google-Smtp-Source: AAOMgpcOLp+Y6onpaAqNSJASgG1QTyNL3O8RdlpkfgsYepOO2uAJrN4PV7cEJdL4jrfmjs960/wFSg==
X-Received: by 2002:a19:8f10:: with SMTP id r16-v6mr983414lfd.92.1530163187544;
        Wed, 27 Jun 2018 22:19:47 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id s26-v6sm1122288lfi.92.2018.06.27.22.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 22:19:46 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fYPLJ-0001N5-KP; Thu, 28 Jun 2018 07:19:41 +0200
Date:   Thu, 28 Jun 2018 07:19:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
Message-ID: <20180628051941.GF629@localhost>
References: <cover.1530004712.git.sean.wang@mediatek.com>
 <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
 <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
 <CAHp75VedHLw52J_ymh3iYf2w=r8d+Kqg=fJZmBGnaCrEbNEPdQ@mail.gmail.com>
 <1530155173.29697.48.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530155173.29697.48.camel@mtkswgap22>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:06:13AM +0800, Sean Wang wrote:
> On Wed, 2018-06-27 at 20:04 +0300, Andy Shevchenko wrote:
> > On Wed, Jun 27, 2018 at 7:59 PM, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Jun 27, 2018 at 8:43 AM,  <sean.wang@mediatek.com> wrote:
> > >> From: Sean Wang <sean.wang@mediatek.com>

> > >> +#include <net/bluetooth/bluetooth.h>
> > >> +#include <net/bluetooth/hci_core.h>
> > 
> > >> +       /* Enable the power domain and clock the device requires. */
> > >> +       pm_runtime_enable(dev);
> > >> +       err = pm_runtime_get_sync(dev);
> > >> +       if (err < 0)
> > >> +               goto err_pm2;

> > >> +err_pm1:
> > >> +       pm_runtime_put_sync(dev);
> > >> +err_pm2:
> > >> +       pm_runtime_disable(dev);

Please name error labels after what they do, not using numbers (see
CodingStyle). Here you could use err_disable_rpm instead of err_pm2, for
example.

Also, if you really want to undo pm_runtime_get_sync() failing above,
you still need a pm_runtime_put_noidle() to balance the usage count.

> > >> +struct mtk_stp_hdr {
> > >> +       __u8 prefix;
> > >> +       __u8 dlen1:4;
> > >> +       __u8 type:4;
> > 
> > >> +       __u8 dlen2:8;
> > >> +       __u8 cs;
> > >> +} __packed;

Perhaps too much context have been lost here, but unless you're sharing
this struct with user space, you should be using u8 (without __) above
(and elsewhere).

Johan
