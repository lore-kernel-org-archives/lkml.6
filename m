Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46144C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED20F25688
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1M0f/ML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED20F25688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeFYJRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:17:20 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38041 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbeFYJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:17:18 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so12862605wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/LerCyzUS9JKAJHkfMoUIj30RC9wZl+DNMFkr7FzWVQ=;
        b=d1M0f/MLP/Vy1MkdRSo4IHZblIjYK7Cookao0l1nLbp8+gmtYeIBVULm3tIkU6eM4A
         +bv63yx020qzUwrduqxlBAZ0vKtRTtXTjSfWOmG+gOXc7CG1X7nUZLJzmYlbvz0ia/lQ
         hHqydpqBsEnM6VCRMgAUKfQM32zMxHGAiPm4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/LerCyzUS9JKAJHkfMoUIj30RC9wZl+DNMFkr7FzWVQ=;
        b=fqto2HJbRM+lU5ZkZpHvTEB0A7zwg4VvGKmELl7ywBKm1TrOxbKQkL0xJQ+Wvp1s6M
         Uu7n6KB5vAdozpxAILI6OP17xIUJXQJCUqjCMPMUoedsSE7opx9qkI1RMq2iepX9EBhI
         zQR+NbiMF5/az9b7ORi1DxZ0dNzQsHvnAj1HrKwEXy6AOHa24cIs9ZaKs6O1j2rrT3NM
         XOvu8seaqK9fhTpnfMH3OxWVwYGqckUopZ5OMPsosEVRTPVEpIo1cRET2ooF051MQs+o
         oFAIoRi6jaJ0lp/z7usqcVG1KJlBj6t8omgJ7ebtAolKBFgY2Dt9s1ztfvauU8BdtyGA
         IHSQ==
X-Gm-Message-State: APt69E2I1I/Hxf52+nzlBSFw5+4z6LES1eINVLxsTyw3diF8hpDU2b9F
        In8qPDbfAtYzR3qJXsqaEiHsYw==
X-Google-Smtp-Source: AAOMgpdzWjtx2M230neDjxVAwPPZRMm2naNzA+9Y6xoiyrR2egiqhFn4bh4bFZK/Ho6STvaTgsM23w==
X-Received: by 2002:a5d:4608:: with SMTP id t8-v6mr5013827wrq.52.1529918237260;
        Mon, 25 Jun 2018 02:17:17 -0700 (PDT)
Received: from apalos ([2a02:587:4609:4e00:a1a6:2387:fbc6:4245])
        by smtp.gmail.com with ESMTPSA id j131-v6sm1175730wmb.25.2018.06.25.02.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:17:16 -0700 (PDT)
Date:   Mon, 25 Jun 2018 12:17:13 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Petr Machata <petrm@mellanox.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        jiri@mellanox.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT] net: dsa: Allow configuring CPU port VLANs
Message-ID: <20180625091713.GA13442@apalos>
References: <20180624153339.13572-1-f.fainelli@gmail.com>
 <wih4lhrgrfd.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wih4lhrgrfd.fsf@dev-r-vrt-156.mtr.labs.mlnx>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:13:10PM +0300, Petr Machata wrote:
> Florian Fainelli <f.fainelli@gmail.com> writes:
> 
> >  	if (netif_is_bridge_master(vlan->obj.orig_dev))
> > -		return -EOPNOTSUPP;
> > +		info.port = dp->cpu_dp->index;
> 
> The condition above will trigger also when a VLAN is added on a member
> port, and there's no other port with that VLAN. In that case the VLAN
> comes without the BRIDGE_VLAN_INFO_BRENTRY flag. In mlxsw we have this
> to get the bridge VLANs:
> 
> 	if (netif_is_bridge_master(orig_dev)) {
> 		[...]
> 		if ((vlan->flags & BRIDGE_VLAN_INFO_BRENTRY) &&
> 		[...]
> 
> This doesn't appear to be done in DSA unless I'm missing something.
Petr's right. This will trigger for VLANs added on 'not cpu ports' if the VLAN
is not already a member. 

This command has BRIDGE_VLAN_INFO_BRENTRY set:
bridge vlan add dev br0 vid 100 pvid untagged self 
I had the same issue on my CPSW RFC and solved it
exactly the same was as Petr suggested.

> 
> Thanks,
> Petr

Regards
Ilias
