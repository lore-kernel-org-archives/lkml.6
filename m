Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE216C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A486208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLePxzRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A486208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbeGIWsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752112AbeGIWsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:48:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC722086B;
        Mon,  9 Jul 2018 22:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531176503;
        bh=r7gKojI+1BWfuNXwV3ExE1KBSoMuyjY7vwk5uEoNwVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLePxzRzh4HMFq7a2aFlE215WVn95Mu3UBXpKd1JSB067/wc1GldEexbglr1XOf8J
         Qrhl3xS1y6aAdhxbl/gVjcRr3ts/Lq8RMQ75aJAPjjweHX9moj2SwpFH5YJSetoEtZ
         AhqvJn2+82rLbf6qYB+ZAzAZpgD8Y8nBzCPcWw+g=
Date:   Mon, 9 Jul 2018 17:48:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/12] pci: use for_each_if
Message-ID: <20180709224821.GA188359@bhelgaas-glaptop.roam.corp.google.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-10-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709083650.23549-10-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:36:48AM +0200, Daniel Vetter wrote:
> Avoids the inverted condition compared to the open-coded version.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge this with the rest of the series.

> ---
>  include/linux/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 340029b2fb38..1484471ed048 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -601,7 +601,7 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
>  
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
> -		if (!pci_is_bridge(dev)) {} else
> +		for_each_if (pci_is_bridge(dev))
>  
>  static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
>  {
> -- 
> 2.18.0
> 
