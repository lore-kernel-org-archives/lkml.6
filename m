Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F27AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0895B20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfBLRtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:49:45 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:37209 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfBLRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:49:45 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 57F622800B1DF;
        Tue, 12 Feb 2019 18:49:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EC961160E1D; Tue, 12 Feb 2019 18:49:42 +0100 (CET)
Date:   Tue, 12 Feb 2019 18:49:42 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 16/28] thunderbolt: Discover preboot PCIe paths the
 boot firmware established
Message-ID: <20190212174942.if2ene44f5m5mern@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-17-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206131738.43696-17-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:26PM +0300, Mika Westerberg wrote:
>  		/* dword 0 */
>  		hop.next_hop = path->hops[i].next_hop_index;
>  		hop.out_port = path->hops[i].out_port->port;
> -		/* TODO: figure out why these are good values */
> -		hop.initial_credits = (i == path->path_length - 1) ? 16 : 7;
> +		hop.initial_credits = path->hops[i].initial_credits;
>  		hop.unknown1 = 0;
>  		hop.enable = 1;
[...]
> @@ -78,6 +78,74 @@ static void tb_pci_init_path(struct tb_path *path)
>  	path->weight = 1;
>  	path->drop_packages = 0;
>  	path->nfc_credits = 0;
> +	path->hops[0].initial_credits = 7;
> +	path->hops[1].initial_credits = 16;

I guess Andreas' algorithm (the last hop in the path is assigned
16 and all the ones before are assigned 7) was reverse-engineered
from Apple's driver.  The fact that this algorithm works for paths
of arbitrary length could indicate that Apple indeed does establish
tunnels between non-adjacent switches.

Also, why are these good values?  (You've deleted the comment.)

Thanks,

Lukas
