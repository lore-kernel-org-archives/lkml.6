Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655E8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3145C222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfBLTmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:42:51 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:51711 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLTmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:42:51 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5F81C2800B3E2;
        Tue, 12 Feb 2019 20:42:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 16F1117E4A; Tue, 12 Feb 2019 20:42:49 +0100 (CET)
Date:   Tue, 12 Feb 2019 20:42:49 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 16/28] thunderbolt: Discover preboot PCIe paths the
 boot firmware established
Message-ID: <20190212194249.2ftl2ckureow44lo@wunner.de>
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
> +static struct tb_port *tb_port_remote(struct tb_port *port)
> +{
> +	struct tb_port *remote = port->remote;
> +
> +	/*
> +	 * If we have a dual link, the remote is available through the
> +	 * primary link.
> +	 */
> +	if (!remote && port->dual_link_port && port->dual_link_port->remote)
> +		return port->dual_link_port->remote->dual_link_port;
> +	return remote;
> +}

Yet more special-casing for dual-link ports. :-(


> +	if (tunnel->dst_port->config.type != TB_TYPE_PCIE_UP) {
> +		tb_port_warn(tunnel->dst_port,
> +			     "path does not end to a PCIe adapter\n");

Nit: I think the proper proposition is "on" or "at", not "to".

The tunnel discovery algorithm looks solid to me, so:
Reviewed-by: Lukas Wunner <lukas@wunner.de>

When the module is unloaded, tb_stop() currently deactivates all PCI
tunnels.  Is this still a good idea now that tunnels are discovered
on probe?  We could just leave the tunnels in place and rediscover
them when the module is reloaded.  If something was unplugged in the
meantime, pciehp will have disconnected the devices and we should
notice on reprobe that certain tunnels cannot be rediscovered, so no
harm no foul.  Thoughts?

Thanks,

Lukas
