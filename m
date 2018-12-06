Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B2C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1972146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544061377;
	bh=hHQot3haubOn0EISoJdz3Gss44BqWaF7LI+cDKkcJ+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0XZzbGwJ3ym7ss0Y8BwYYfdoPmyFvH9nPCU2KnFOzqGVb87308E9awkU3Y0oTtaHv
	 vbao0HU3kUkFIfCjyQ4kbZOoC6vdw6a3dr8j1FYdxVnvnz5i0WIXdyigFBigIEUXbP
	 6GXmi1XJ+E+M7BunqthfV4Ft8VX05D3DuYUs4VNI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1972146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbeLFB4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLFB4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:56:15 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC80213A2;
        Thu,  6 Dec 2018 01:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544061375;
        bh=hHQot3haubOn0EISoJdz3Gss44BqWaF7LI+cDKkcJ+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBxaouHknapEmjCsBohSj/RHGnyWF/TI8qYxxe6rlBuTqLgas/eQh0ZUxh3jl9wIP
         pKjMBUnpnoxKKhMt9VBgDVCOsWBbcgAHZuehevpeaRcIwT2XSOcrSucFqi91BtDgKp
         M6IevfUhZjl18B0GvOu+qN3yJCndtL21B1Ju0Eoo=
Date:   Thu, 6 Dec 2018 09:55:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] ARM: imx: update the cpu power up timing setting on
 i.mx6sx
Message-ID: <20181206015533.GW3987@dragon>
References: <1543893119-3716-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543893119-3716-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:17:45AM +0000, Anson Huang wrote:
> The sw2iso count should cover ARM LDO ramp-up time,
> the MAX ARM LDO ramp-up time may be up to more than
> 100us on some boards, this patch sets sw2iso to 0xf
> (~384us) which is the reset value, and it is much
> more safe to cover different boards, since we have
> observed that some customer boards failed with current
> setting of 0x2.
> 
> Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6sx")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
