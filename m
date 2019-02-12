Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC38C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AD320838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfBLOEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:04:24 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:33545 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfBLOEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:04:24 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A35A72800B6DE;
        Tue, 12 Feb 2019 15:04:22 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5DE1313BC1A; Tue, 12 Feb 2019 15:04:22 +0100 (CET)
Date:   Tue, 12 Feb 2019 15:04:22 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 18/28] thunderbolt: Scan only valid NULL adapter ports
 in hotplug
Message-ID: <20190212140422.hiwll4cilgs7ruev@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-19-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206131738.43696-19-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:28PM +0300, Mika Westerberg wrote:
> The only way to expand Thunderbolt topology is through the NULL adapter
> ports (typically ports 1, 2, 3 and 4). There is no point handling
> Thunderbolt hotplug events on any other port.
> 
> Add a helper function (tb_port_is_null()) that can be used to determine
> if the port is NULL port, and use it in software connection manager code
> when hotplug event is handled.

Andreas called these ports TB_TYPE_PORT.  If the official name is NULL,
then renaming to TB_TYPE_NULL might be a useful cleanup.  (Though it
seems the control port, i.e. port 0, is also of type TB_TYPE_PORT?)


> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -344,10 +344,12 @@ static void tb_handle_hotplug(struct work_struct *work)
>  		tb_port_info(port,
>  			     "got plug event for connected port, ignoring\n");
>  	} else {
> -		tb_port_info(port, "hotplug: scanning\n");
> -		tb_scan_port(port);
> -		if (!port->remote)
> -			tb_port_info(port, "hotplug: no switch found\n");
> +		if (tb_port_is_null(port)) {
> +			tb_port_info(port, "hotplug: scanning\n");
> +			tb_scan_port(port);
> +			if (!port->remote)
> +				tb_port_info(port, "hotplug: no switch found\n");
> +		}

There's several other sanity checks further up in this function.
Why not move the tb_port_is_null() check near them, e.g. below the
check for tb_is_upstream_port()?

Thanks,

Lukas
