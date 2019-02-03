Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD7FC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1052083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBCHCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:02:49 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:25424 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfBCHCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:02:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,555,1539640800"; 
   d="scan'208";a="367739064"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2019 08:02:47 +0100
Date:   Sun, 3 Feb 2019 08:02:46 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Kishon Vijay Abraham I <kishon@ti.com>
cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org
Subject: question about drivers/phy/renesas/phy-rcar-gen2.c
Message-ID: <alpine.DEB.2.21.1902030759010.19281@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was wondering whether phy-rcar-gen2.c would use dynamically allocated
device nodes?  If so, it looks like the following code could cause a
use-after-free, due to not incrementing th reference count:

	for_each_child_of_node(dev->of_node, np) {
		struct rcar_gen2_channel *channel = drv->channels + i;
		u32 channel_num;
		int error, n;

		channel->of_node = np;
		...
	}

On the other hand, if the reference cound it incrememnted, preventing
memory leaks in the case where the probe function fails would entail some
complex rewriting of the code, so I thought it would be better to ask
first.

thanks,
julia
