Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA48AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA45218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfBGO2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:28:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:45978 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfBGO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:28:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 06:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="120682728"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2019 06:28:47 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1grkfW-0006SC-8J; Thu, 07 Feb 2019 16:28:46 +0200
Date:   Thu, 7 Feb 2019 16:28:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 21/28] thunderbolt: Add support for Display Port
 tunnels
Message-ID: <20190207142846.GH9224@smile.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-22-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206131738.43696-22-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:31PM +0300, Mika Westerberg wrote:
> Display Port tunnels are somewhat more complex than PCIe tunnels as it
> requires 3 tunnels (AUX Rx/Tx and Video). In addition we are not
> supposed to create the tunnels immediately when a DP OUT is enumerated.
> Instead we need to wait until we get hotplug event to that adapter port
> or check if the port has HPD set before tunnels can be established. This
> adds Display Port tunneling support to the software connection manager.

> +static int tb_tunnel_dp(struct tb *tb, struct tb_port *out)
> +{
> +	struct tb_cm *tcm = tb_priv(tb);
> +	struct tb_switch *sw = out->sw;
> +	struct tb_tunnel *tunnel;
> +	struct tb_port *in;
> +
> +	if (tb_port_is_enabled(out))
> +		return 0;
> +
> +	do {
> +		sw = tb_to_switch(sw->dev.parent);
> +		if (!sw)
> +			return 0;
> +		in = tb_find_unused_port(sw, TB_TYPE_DP_HDMI_IN);
> +	} while (!in);
> +
> +	tunnel = tb_tunnel_alloc_dp(tb, in, out);
> +	if (!tunnel) {
> +		tb_port_dbg(out, "DP tunnel allocation failed\n");

> +		return -EIO;

In the same way how you done for XDomains it makes sense to return here -ENOMEM.

> +	}
> +
> +	if (tb_tunnel_activate(tunnel)) {
> +		tb_port_info(out, "DP tunnel activation failed, aborting\n");
> +		tb_tunnel_free(tunnel);
> +		return -EIO;
> +	}
> +
> +	list_add_tail(&tunnel->list, &tcm->tunnel_list);
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


