Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49F3C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A750D218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeLSRWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:22:53 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:49157 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeLSRWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:22:53 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5034428011B88;
        Wed, 19 Dec 2018 18:22:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0C4A01D378B; Wed, 19 Dec 2018 18:22:51 +0100 (CET)
Date:   Wed, 19 Dec 2018 18:22:50 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Message-ID: <20181219172250.ytronxeq2yc4vp4r@wunner.de>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
> +{
> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> +}

This looks like a duplication of the is_suspended flag in struct dev_pm_info.
Any reason why you can't use that?  If so, it would be good to document the
reason in the commit message.

If the point is to constrain refusal of transfers in suspended state to
certain drivers, those drivers could opt in to that functionality by
setting a flag, and the i2c core could then gate refusal based on
that flag and the is_suspended flag in struct dev_pm_info.

Also, why is it necessary to take a lock to perform an atomic bitop?
(Sorry if that's a dumb question, seems non-obvious to me.)

Thanks,

Lukas
