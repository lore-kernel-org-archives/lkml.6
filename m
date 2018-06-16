Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14298C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB351208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB351208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeFPMYi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 08:24:38 -0400
Received: from gloria.sntech.de ([95.129.55.99]:48060 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932681AbeFPMYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 08:24:37 -0400
Received: from ip5f5a8448.dynamic.kabel-deutschland.de ([95.90.132.72] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fUAFV-0006iW-V5; Sat, 16 Jun 2018 14:24:10 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Sandy Huang <hjc@rock-chips.com>, kernel-janitors@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/rockchip: lvds: add missing of_node_put
Date:   Sat, 16 Jun 2018 14:24:09 +0200
Message-ID: <1948755.WvuARZiism@diego>
In-Reply-To: <1527102436-13447-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr> <1527102436-13447-6-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

Am Mittwoch, 23. Mai 2018, 21:07:16 CEST schrieb Julia Lawall:
> The device node iterators perform an of_node_get on each iteration, so a
> jump out of the loop requires an of_node_put.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> iterator name for_each_child_of_node;
> @@
> 
>  for_each_child_of_node(root, child) {
>    ... when != of_node_put(child)
>        when != e = child
> +  of_node_put(child);
> ?  break;
>    ...
> }
> ... when != child
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

thanks for catching this. I've added a "Fixes"-tag and
applied the patch to drm-misc-next 


Thanks
Heiko


