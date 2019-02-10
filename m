Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF86C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728BA21934
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfBJMN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 07:13:56 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:34345 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfBJMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 07:13:56 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D10E930000CDE;
        Sun, 10 Feb 2019 13:13:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A755BF53; Sun, 10 Feb 2019 13:13:53 +0100 (CET)
Date:   Sun, 10 Feb 2019 13:13:53 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 12/28] thunderbolt: Add functions for allocating and
 releasing hop IDs
Message-ID: <20190210121353.fw7gj4pm7ce3flvf@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-13-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206131738.43696-13-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:22PM +0300, Mika Westerberg wrote:
> Each port has a separate path configuration space that is used for
> finding the next hop (switch) in the path. Hop ID is an index to this
> configuration space and hop IDs 0 - 7 are reserved.
> 
> In order to get next available hop ID for each direction we provide two
> pairs of helper functions that can be used to allocate and release hop
> IDs for a given port.
[...]
> +static int tb_port_alloc_hopid(struct tb_port *port, bool in, int min_hopid,
> +			       int max_hopid)
> +{
> +	int port_max_hopid;
> +	struct ida *ida;
> +
> +	if (in) {
> +		port_max_hopid = port->config.max_in_hop_id;
> +		ida = &port->in_hopids;
> +	} else {
> +		port_max_hopid = port->config.max_out_hop_id;
> +		ida = &port->out_hopids;
> +	}
> +
> +	/* Hop IDs 0-7 are reserved */
> +	if (min_hopid < 8)
> +		min_hopid = 8;
> +
> +	if (max_hopid < 0 || max_hopid > port_max_hopid)
> +		max_hopid = port_max_hopid;
> +
> +	return ida_simple_get(ida, min_hopid, max_hopid + 1, GFP_KERNEL);
> +}

If there are two Macs at the ends of the daisy-chain with Thunderbolt
devices in-between, the other Mac may already have established tunnels
to some of the devices and therefore has occupied hop entries in the
devices' path config space.  How do you ensure that you don't allocate
the same entries and overwrite the other Mac's hop entries, thereby
breaking its tunnels?  Because you're only allocating the hop entries
locally here.  Maybe there's some check in a later patch whether a
hop entry is already occupied, I'm not even halfway through this patch
bomb.

Thanks,

Lukas
