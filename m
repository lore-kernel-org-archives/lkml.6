Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754EDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4667E2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBKGf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:35:57 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:40537 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKGf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:35:57 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6E7152800B1DF;
        Mon, 11 Feb 2019 07:35:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1E343115A6F; Mon, 11 Feb 2019 07:35:55 +0100 (CET)
Date:   Mon, 11 Feb 2019 07:35:55 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 15/28] thunderbolt: Deactivate all paths before
 restarting them
Message-ID: <20190211063555.2bozvqen2jmskox4@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-16-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206131738.43696-16-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:25PM +0300, Mika Westerberg wrote:
> We can't be sure the paths are actually properly deactivated when a
> tunnel is restarted after resume.

Why can't we be sure?  Please provide proper reasoning.


> So instead of marking all paths as
> inactive we go ahead and deactivate them explicitly.

This seems like a bad idea if the root partition is on a Thunderbolt-
attached drive, the system is waking from hibernate and the EFI NHI
driver has already established a tunnel to that drive.  It would seem
more appropriate to discover tunnels already existing on resume from
system sleep and then attempt to establish any others that might be
missing.


> @@ -183,8 +183,15 @@ int tb_tunnel_restart(struct tb_tunnel *tunnel)
>  
>  	tb_tunnel_info(tunnel, "activating\n");
>  
> +	/* Make sure all paths are properly disabled before enable them again */

This isn't proper English, s/enable/enabling/.

Thanks,

Lukas
