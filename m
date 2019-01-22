Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CA5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630F820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mdh/az/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfAVWvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:51:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41849 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfAVWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:51:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so257371qtf.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/XBYHY6SKkDwEIlSoffdYinDoT8V1LONeQ2d/odNaQ=;
        b=Mdh/az/ur8N3P0fSSYxO41aX78d92rObeQskl7lbc4hS9DeDf73UVzUUoQnLrUd0Bd
         Zatbb+NMZBOeS3NFGPdYahMoTBb07Iq5+kNvUVnquujE7C9y5uRKH0RP9h9mCLl90VY+
         XomJsnQMp5EEdrxsr8xxLlc1SHbxLsUMdNl0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/XBYHY6SKkDwEIlSoffdYinDoT8V1LONeQ2d/odNaQ=;
        b=VxKE062krdKPzG0fLdS+QVAj0/eZI8iPmsdP9GBUbZmLh1P/XK/Qam79P7x6rtAgBK
         DA+z9caTrJcPa2/+Or64P2U3ySsogd1qWJAWN/pSEVSn0Itibxw6j5LhsTocP1BkBoIh
         rrocoBY1sikG9wFQYIi9rZMhwgxyr9QqNYdAhN+Pa0ClzfZKPcrLDKPPXVKGhy+21Ngm
         JP2N/VwhMy94aB5vTdUPOaULZ2rCcStzi97ICzqRaHKdmfHrNz0Ci9xDUKJRH7Nys9qt
         5Ww3jZFTBjLV2d34IZcY1+2aAmpojDUAu7IyMEQg7oD1jAsj0lJsW9AcEZ7Z8r6fxQeY
         QlXw==
X-Gm-Message-State: AJcUukdyhVuwdwku6oqCgjShKDKz9Mb4RgUcHkBA060TTe4oem4V0mWu
        2PQ76YLSA+Zp7KQ/0ckXyyolYa6wbp7F6kDFsatA2A==
X-Google-Smtp-Source: ALg8bN7Zt15oTdh/04iq08N8IN0vyYu7i10byl+0WgPF5QJSa0QzavTsyex2nrnJhE4cip6lVIqoJK0xipouBFaKmWQ=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr33380556qts.144.1548197477728;
 Tue, 22 Jan 2019 14:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com> <20190111102155.in5rctq5krs4ewfi@8bytes.org>
In-Reply-To: <20190111102155.in5rctq5krs4ewfi@8bytes.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 23 Jan 2019 06:51:05 +0800
Message-ID: <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>, hch@infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, stable@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> > Does anyone have any further comment on this series? If not, which
> > maintainer is going to pick this up? I assume Andrew Morton?
>
> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
> this should go through mm.

Gentle ping on this series, it seems like it's better if it goes
through your tree.

Series still applies cleanly on linux-next, but I'm happy to resend if
that helps.

Thanks!

> Regards,
>
>         Joerg
