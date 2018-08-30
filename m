Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0D320645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV+8521l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0D320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeH3TyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbeH3TyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:54:10 -0400
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com [209.85.216.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9E620834;
        Thu, 30 Aug 2018 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535644282;
        bh=Ge7u50KM178hS1srxJrueZTFvb1rDyK4EtOX9N20+hU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cV+8521lOC7KBfvk1xCqQqIC+I/AADvUOV0zDByqbdu4JpkzmnAMwm8VlF/7UDZjE
         h5WNnD+GXfWe1JPgezfyKZdOLejoHXtE6A9eAc+aJEX1FksZ5FV3/JGrC1/i6/hT6+
         P8fvEBVMkgTGchv9nwJgLvJIMcQqdnKMw4vJIok8=
Received: by mail-qt0-f172.google.com with SMTP id z8-v6so10630571qto.9;
        Thu, 30 Aug 2018 08:51:22 -0700 (PDT)
X-Gm-Message-State: APzg51B4bFWQ1ozQWF5iY8qbjqHCtGY5jQ00Z7ABtbue3mpcqa6grp5r
        yL0SzYfyKrVTEVQqTHIPG5uYiFntacMfLOx0sg==
X-Google-Smtp-Source: ANB0VdaU2dZ+0NwgqMng14qbUFBpACOSLQkth/2HNIsyoePaYdfVgX0utHIIBygFo9niBpdinSKKAZtCwh0lcC4/QEU=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr12532768qtd.101.1535644281600;
 Thu, 30 Aug 2018 08:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180827082153.22537-1-johan@kernel.org> <20180827082153.22537-2-johan@kernel.org>
In-Reply-To: <20180827082153.22537-2-johan@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 30 Aug 2018 10:51:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLv8MBpFsictS9Ldm2y7L-v7RiSVJHFTNHSixFhzppaPA@mail.gmail.com>
Message-ID: <CAL_JsqLv8MBpFsictS9Ldm2y7L-v7RiSVJHFTNHSixFhzppaPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] of: add helper to lookup compatible child node
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 3:22 AM Johan Hovold <johan@kernel.org> wrote:
>
> Add of_get_compatible_child() helper that can be used to lookup
> compatible child nodes.
>
> Several drivers currently use of_find_compatible_node() to lookup child
> nodes while failing to notice that the of_find_ functions search the
> entire tree depth-first (from a given start node) and therefore can
> match unrelated nodes. The fact that these functions also drop a
> reference to the node they start searching from (e.g. the parent node)
> is typically also overlooked, something which can lead to use-after-free
> bugs.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/of/base.c  | 25 +++++++++++++++++++++++++
>  include/linux/of.h |  8 ++++++++
>  2 files changed, 33 insertions(+)

I've applied this one and plan to send to Linus tomorrow.

Rob
