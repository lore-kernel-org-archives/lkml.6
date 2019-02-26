Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D145C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A851217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pwbLUlaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfBZLFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:05:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:34324 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZLFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1551179104;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NTJ1/GTBQLroPgv3yXOXY9ou18+4xRGJwgU9nlQMKtA=;
        b=pwbLUlaUpEgbCsVLWboz7iIhynXApQlkGlZJ3l5FSGdoE+VWdflPt8KZ/E8xKRp6zk
        c2PGNZ1PwhHafWzHMl2S4b3tVf8yI3wCCXGAU70ScL9J3ltqwTnEtOK7pQGt7/GGpT/p
        fPiMRVAoc1e34S3S0M1bOhyekKmpmVJQ9KqjnWnBYppEY0fSKuwUiN5ND7cBATNZuUlv
        IRVuytF8HniIuypq4qWRBCtgCJDMOmhkGHR9MiAPQGcuvRrFaT8PMKajvBl95266ldwZ
        +g0Yds2wAB6kPHDl6QAT0/eF4W1fJjhXdgnb2nO6ISwjxjPjE9497cBKy214Sz8kbve0
        xL/w==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jXdVqE32oRVrGn+2w7fg=="
X-RZG-CLASS-ID: mo00
Received: from [10.180.89.44]
        by smtp.strato.de (RZmta 44.13 AUTH)
        with ESMTPSA id e06351v1QB4D5KF
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 26 Feb 2019 12:04:13 +0100 (CET)
Subject: Re: [PATCH RFC] mac80211: Use IFF_ECHO to force delivery of tx_status
 frames
To:     Julius Niedworok <julius.n@gmx.net>, linux-wireless@vger.kernel.org
Cc:     ga58taw@mytum.de, david@redhat.com, nc@net.in.tum.de,
        "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Edward Cree <ecree@solarflare.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Li RongQing <lirongqing@baidu.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190226094104.35192-1-julius.n@gmx.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <c522f2e0-1bef-8679-45f7-707854918820@hartkopp.net>
Date:   Tue, 26 Feb 2019 12:04:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190226094104.35192-1-julius.n@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julius,

On 26.02.19 10:40, Julius Niedworok wrote:

> In order to force delivery of TX status frames for research and debugging
> purposes, implement the IFF_ECHO flag for ieee80211 devices. When this flag
> is set for a specific interface, IEEE80211_TX_CTL_REQ_TX_STATUS is enabled
> in all packets sent from that interface. IFF_ECHO can be set via
> /sys/class/net/<dev>/flags. The default is disabled.

(..)

> +	/*
> +	 *	Force TX status frames on ieee80211 devices.
> +	 *	Since IFF_ECHO is used by CAN devices for a different
> +	 *	purpose, we must check dev->ieee80211_ptr.
> +	 */

The reason for IFF_ECHO was, that the data frame which is sent onto the 
wire (by one application) is not visible to all the other applications 
on the same (local) host. Therefore a successful transmission on the 
wire triggers the 'echo' of the sent content into the local host.

So what are you getting back after you enabled IFF_ECHO on your mac80211 
device?

Is it just a 'status' about a sent packet, or is it the packet ('full 
content') itself?

Regards,
Oliver

