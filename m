Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EA3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8DE2190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBGOdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:33:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:19576 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfBGOdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:33:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 06:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="136642324"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2019 06:33:13 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1grkjo-0006Te-J6; Thu, 07 Feb 2019 16:33:12 +0200
Date:   Thu, 7 Feb 2019 16:33:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 13/28] thunderbolt: Add helper function to iterate
 from one port to another
Message-ID: <20190207143312.GI9224@smile.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-14-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206131738.43696-14-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:23PM +0300, Mika Westerberg wrote:
> We need to be able to walk from one port to another when we are creating
> paths where there are multiple switches between two ports. For this
> reason introduce a new function tb_port_get_next() and a new macro
> tb_for_each_port().

> +struct tb_port *tb_port_get_next(struct tb_port *start, struct tb_port *end,
> +				 struct tb_port *prev)
> +{
> +	struct tb_port *port, *next;
> +
> +	if (!prev)
> +		return start;
> +
> +	if (prev->sw == end->sw) {

> +		if (prev != end)
> +			return end;
> +		return NULL;

I would prefer to see the similar pattern as you used below, i.e. when we have
an "bail out" condition, check for it.

		if (prev == end)
			return NULL;
		return end;


> +	}
> +
> +	/* Switch back to use primary links for walking */
> +	if (prev->dual_link_port && prev->link_nr)
> +		port = prev->dual_link_port;
> +	else
> +		port = prev;
> +
> +	if (start->sw->config.depth < end->sw->config.depth) {
> +		if (port->remote &&
> +		    port->remote->sw->config.depth > port->sw->config.depth)
> +			next = port->remote;
> +		else
> +			next = tb_port_at(tb_route(end->sw), port->sw);
> +	} else if (start->sw->config.depth > end->sw->config.depth) {
> +		if (tb_is_upstream_port(port))
> +			next = port->remote;
> +		else
> +			next = tb_upstream_port(port->sw);
> +	} else {

> +		/* Must be the same switch then */
> +		if (start->sw != end->sw)
> +			return NULL;
> +		return end;

Here is a good pattern.

> +	}
> +
> +	/* If prev was dual link return another end of that link then */
> +	if (next->dual_link_port && next->link_nr != prev->link_nr)
> +		return next->dual_link_port;
> +
> +	return next;
> +}

-- 
With Best Regards,
Andy Shevchenko


