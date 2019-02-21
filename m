Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C398C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADA021738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550742776;
	bh=QrYZrdDCeXmj9tMrX0loJyXbEtoCT+CVY4/YFVrMSX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mXRkn800kV6StC/Sg2pLmrlc/R7erjVM56J85C92GhznIxvDWXw2Wc2ieLAbFt7Ap
	 xwdHqJPAYar10mVWdIdyJciYt/cijLf574TQ1EI3PFm+nigXPrBCfWvS/7aPckakbA
	 ChYEHkpS2gJIu3MylHT7cLQUOIopNy9gdRGHmJ1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfBUJwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:52:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfBUJwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:52:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA9BF214AF;
        Thu, 21 Feb 2019 09:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550742773;
        bh=QrYZrdDCeXmj9tMrX0loJyXbEtoCT+CVY4/YFVrMSX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjIyFr21DHmm1RJSg8zwiFfT3XvcWnhlxwWyhmNDL0jFc1l9jFxqnIwlVUibtRPyc
         OXWlG3VQGJISV84XATNigAFeq4eVZAB904X0e7NhOnVcDe+qFBc32UZKb+NxA646rn
         AabAFl/tgq1DTWye0qBGVO8c8DwI3J/P8uA/9/bo=
Date:   Thu, 21 Feb 2019 10:52:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
Message-ID: <20190221095250.GB26960@kroah.com>
References: <20190220110017.BFA344CE86@mail.steuer-voss.de>
 <20190220151138.12332-1-nv@vosn.de>
 <20190221090850.GE5054@kuha.fi.intel.com>
 <alpine.DEB.2.20.1902211040001.19936@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1902211040001.19936@fox.voss.local>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:42:07AM +0100, Nikolaus Voss wrote:
> On Thu, 21 Feb 2019, Heikki Krogerus wrote:
> > On Wed, Feb 20, 2019 at 04:11:38PM +0100, Nikolaus Voss wrote:
> > > From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > > 
> > > Commit 1a2f474d328f handles block _reads_ separately with plain-I2C
> > > adapters, but the problem described with regmap-i2c not handling
> > > SMBus block transfers (i.e. read and writes) correctly also exists
> > > with writes.
> > > 
> > > As workaround, this patch adds a block write function the same way
> > > 1a2f474d328f adds a block read function.
> > > 
> > > Fixes: 1a2f474d328f ("usb: typec: tps6598x: handle block reads separately with plain-I2C adapters")
> > > Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> > > Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > 
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Heikki,
> 
> shall I respin the patch with tags?

I can add it, thanks.

greg k-h
