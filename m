Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE85DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB021473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfA2V7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:59:02 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:37201 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfA2V7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:59:01 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3FBAA100D940B;
        Tue, 29 Jan 2019 22:58:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AFA2CDCB9; Tue, 29 Jan 2019 22:58:58 +0100 (CET)
Date:   Tue, 29 Jan 2019 22:58:58 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 03/28] thunderbolt: Enable TMU access when accessing port
 space on legacy devices
Message-ID: <20190129215858.c2yws2ce76d7qm62@wunner.de>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
 <20190129150143.12681-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129150143.12681-4-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 06:01:18PM +0300, Mika Westerberg wrote:
> +	if (enable)
> +		value |= BIT(20);

Can we have a macro for this bit?


> +int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
> +{
> +	int ret;
> +
> +	ret = tb_port_enable_tmu(port, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = __tb_port_find_cap(port, cap);
> +
> +	tb_port_enable_tmu(port, false);
> +
> +	return ret;
> +}

Would there be a downside to setting the TMU bit on all ports all the time
(e.g. on switch enumeration)?

Thanks,

Lukas
