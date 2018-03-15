Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCODJF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 23:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbeCODJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 23:09:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECFA204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 15 Mar 2018 11:08:06 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 1/2] soc: imx: gpcv2: Do not pass static memory as
 platform data
Message-ID: <20180315030804.GI26859@dragon>
References: <20180122150748.1742-1-andrew.smirnov@gmail.com>
 <20180208064709.GB31910@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208064709.GB31910@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 02:47:10PM +0800, Shawn Guo wrote:
> On Mon, Jan 22, 2018 at 07:07:47AM -0800, Andrey Smirnov wrote:
> > Platform device core assumes the ownership of dev.platform_data as
> > well as that it is dynamically allocated and it will try to kfree it
> > as a part of platform_device_release(). Change the code to pass
> > kzalloc'ed chunk of memory instead of a pointer to a static memory to
> > avoid causing a BUG() when calling platform_device_put().
> > 
> > The problem can be reproduced by artificially enabling the error path
> > of platform_device_add() call (around line 357).
> > 
> > Note that this change also allows us to constify imx7_pgc_domains,
> > since we no longer need to be able to modify it.
> > 
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> 
> Applied both, thanks.

I decided to drop these two patches.  Triggered by Fabio's patch on top
of you changes, I just took another look at them, and found that
platform_device_add_data() can help us do the same thing in a nicer way.

Shawn

[1] https://patchwork.kernel.org/patch/10274969/
