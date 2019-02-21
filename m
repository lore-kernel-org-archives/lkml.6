Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2221C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B255F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550776425;
	bh=v2s0umUHfGrPKSqbmZYJAk8ykkVYktDk12dLw+oexJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q8iqGjgDxgbV7AbZ4CyDF9fobmaYi+erUSF7iZLl8XBh7nmBvHnyVwtfxtBh+Jtpf
	 0ro/TxpJ6nV2K4OmtMLgEnII/gFGywq7/oFCWsBt6TBYB6KmT40P6pfp85VdBWVBeO
	 VuvlT3OctAbjWkAFoHOLffEHOHGxngpNme0vETDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfBUTNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfBUTNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:13:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF5E320836;
        Thu, 21 Feb 2019 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550776423;
        bh=v2s0umUHfGrPKSqbmZYJAk8ykkVYktDk12dLw+oexJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfTpjGJkzkZP+ZGMrz/DEkkcRF0gawK0GI4N8YF8FAXYkqYAT/0+8E68JMSTg8b/J
         7T5w9RFZw6A17D70SoylfQydFB+VCJWgl9eOkXBvltCS+fQgPUMrjWf5aQfZtsCzh+
         /GUOsx3L74EoOmyqdU7yXKmIGqHaM/C4sspDDxrM=
Date:   Thu, 21 Feb 2019 20:13:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Mehrtens, Hauke" <hauke.mehrtens@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "hauke@hauke-m.de" <hauke@hauke-m.de>
Subject: Re: [PATCH 4.9 04/20] net: Fix for_each_netdev_feature on Big endian
Message-ID: <20190221191340.GA23109@kroah.com>
References: <20190221125242.153179182@linuxfoundation.org>
 <20190221125242.858818453@linuxfoundation.org>
 <9231D502B07C5E4A8B32D5115C9F19991F89EFB4@IRSMSX108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9231D502B07C5E4A8B32D5115C9F19991F89EFB4@IRSMSX108.ger.corp.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:26:10PM +0000, Mehrtens, Hauke wrote:
> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org] 
> Sent: Thursday, February 21, 2019 3:36 PM
> To: linux-kernel@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; stable@vger.kernel.org; Mehrtens, Hauke <hauke.mehrtens@intel.com>; David S. Miller <davem@davemloft.net>
> Subject: [PATCH 4.9 04/20] net: Fix for_each_netdev_feature on Big endian
> 
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Hauke Mehrtens <hauke.mehrtens@intel.com>
> 
> [ Upstream commit 3b89ea9c5902acccdbbdec307c85edd1bf52515e ]
> 
> The features attribute is of type u64 and stored in the native endianes on the system. The for_each_set_bit() macro takes a pointer to a 32 bit array and goes over the bits in this area. On little Endian systems this also works with an u64 as the most significant bit is on the highest address, but on big endian the words are swapped. When we expect bit 15 here we get bit 47 (15 + 32).
> 
> This patch converts it more or less to its own for_each_set_bit() implementation which works on 64 bit integers directly. This is then completely in host endianness and should work like expected.
> 
> Fixes: fd867d51f ("net/core: generic support for disabling netdev features down stack")
> Signed-off-by: Hauke Mehrtens <hauke.mehrtens@intel.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/netdev_features.h |   23 +++++++++++++++++++++--
>  net/core/dev.c                  |    4 ++--
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> Hi Greg,
> 
> This commit adds a missing include, I do not know if this really causes a compile problem:
> https://git.kernel.org/linus/8681ef1f3d295bd3600315325f3b3396d76d02f6

I have that patch queued up as well :)

> It was also suggested to use a longer commit ID in the Fixes tag like this:
> Fixes: fd867d51f889 ("net/core: generic support for disabling netdev features down stack")

Yes, in the future please do that, I just took the changelog directly
from what is in Linus's tree.

thanks,

greg k-h
