Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7644BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BA4214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOFCsNix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BA4214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbeKVDO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:14:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbeKVDO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:14:26 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8F5214C1;
        Wed, 21 Nov 2018 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542818356;
        bh=y3LFa2TrnCqDBLKbVOHe7YP7WgURDboAfp1yVTn9rXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WOFCsNix6RYJm9adVVTEpvJSRyLf2PyS7nBGgaq1wfWp+a9YzjbC0bCDbaUSK1v04
         /AzHj3MiI+5hZmK1bLWpvEXCBoum/+TCaUPOHnqINIunh8zPNeepH/qoyHiEdTDByh
         sXaHNEv86B5qEobstRlX4iNX3rzf95YhOnyjqwLE=
Received: by mail-qk1-f174.google.com with SMTP id o125so5267395qkf.3;
        Wed, 21 Nov 2018 08:39:15 -0800 (PST)
X-Gm-Message-State: AA+aEWZCjBOMkxTVK0DDb5/JQ5N9XWbV1/y6U6FbBWjUcIyYFRZzl1hx
        cJsWj2BmXxg2adL59aYRNf0RI/pwypjuPKnHBg==
X-Google-Smtp-Source: AFSGD/V7OhglCYZpgBAxhoG1bZsUZADC96a5jiHPNY1tjgwGhb1Lr5aWX+G1EtoTenJLmjj1cpz+H+QIrkFbFRn1vAs=
X-Received: by 2002:a37:5686:: with SMTP id k128mr5915745qkb.29.1542818355174;
 Wed, 21 Nov 2018 08:39:15 -0800 (PST)
MIME-Version: 1.0
References: <1542787873-8429-1-git-send-email-miles.chen@mediatek.com>
In-Reply-To: <1542787873-8429-1-git-send-email-miles.chen@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 21 Nov 2018 10:39:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLGvUYQmCGXLgSO+6kFj2i87dpaTbMGbyu5oMt=eeu35A@mail.gmail.com>
Message-ID: <CAL_JsqLGvUYQmCGXLgSO+6kFj2i87dpaTbMGbyu5oMt=eeu35A@mail.gmail.com>
Subject: Re: [RFC PATCH] of: make MAX_RESERVED_REGIONS configurable
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 2:11 AM <miles.chen@mediatek.com> wrote:
>
> From: Miles Chen <miles.chen@mediatek.com>
>
> When we use more than 32 entries in /resered-memory,
> there will be an error message: "not enough space all defined regions.".
> We can increase MAX_RESERVED_REGIONS to fix this.
>
> commit 22f8cc6e3373 ("drivers: of: increase MAX_RESERVED_REGIONS to 32")
> increased MAX_RESERVED_REGIONS to 32 but I'm not sure if increasing
> MAX_RESERVED_REGIONS to 64 is suitable for everyone.
>
> In this RFC patch, CONFIG_MAX_OF_RESERVED_REGIONS is added and used as
> MAX_RESERVED_REGIONS. Add a sanity test to make sure that
> MAX_RESERVED_REGIONS is less than INIT_MEMBLOCK_REGIONS.
> Users can configure CONFIG_MAX_OF_RESERVED_REGIONS according to their
> need.

I don't want a kconfig option for this. I think it should be dynamic instead.

The current flow is like this:

for each reserved node:
  - call memblock_reserve
  - Add info to reserved_mem array

I think we should change it to:

for each reserved node:
  - call memblock_reserve
  - count number of nodes

Alloc array using memblock_alloc

for each reserved node:
   - Add info to reserved_mem array

Rob
