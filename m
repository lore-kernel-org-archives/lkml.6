Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD95C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C469E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cprO2E8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C469E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeK0Pi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:38:26 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:50251 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbeK0Pi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=qgy/DgD/41Sxf3P4ftUh7aYqvsqKkozslxAd+N/oZOE=;
        b=cprO2E8SKX49uiibZpUqHHEbWISfgW57t7bZuN8BGYa5dcJtb2dKk6KepFlpvgmZPRMvFVBBACw2OdnJvwMG+8PiKeJKoDdFkC2HPt/he9tjlXwfxHmv+7+1eDJ9CMTDmXDGqWrndiSHPPJhOi0JQF63rDuokEttVnS5wDC32Do=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gRVBv-0000xn-72; Tue, 27 Nov 2018 05:41:43 +0100
Date:   Tue, 27 Nov 2018 05:41:43 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alacn <alacn1@gmail.com>
Cc:     Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mv88e6060 station roaming
Message-ID: <20181127044143.GB3181@lunn.ch>
References: <CAMbhjvMAe5UbRPAdyahqvu24muJP3K6n63q3ahxG8aae3NPNsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMbhjvMAe5UbRPAdyahqvu24muJP3K6n63q3ahxG8aae3NPNsA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:31:02PM -0200, Alacn wrote:
> hello,
> 
> I'm sending a patch for Marvell 88e6060 driver.
> 
> Problem description:
> Multiple APs with inter-AP roaming connected to different ports,
> when station moves from one AP on one port to another AP on another port,
> traffic flow breaks down because the learning table is not updated.
> 
> 
> When Marvell's mac learning is enabled it drops all frames that
> arrive from a MAC address that is on a different port at learning table.
> It doesn't update learning table and breaks station roaming.
> 
> 
> This patch disable Marvell 88E6060 hardware level mac learning and let it
> be handled by the kernel.

Hi Anderson.

> @@ -145,8 +144,7 @@

        /* Enable automatic address learning, set the address
         * database size to 1024 entries, and set the default aging
         * time to 5 minutes.
         */


>   * time to 5 minutes.
>   */
>   REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
> -   GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
> -   GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
> +   GLOBAL_ATU_CONTROL_LEARNDIS);

Please update the comment as well.

       Thanks
	Andrew
