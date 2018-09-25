Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DC1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0951D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0951D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeIZAQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:16:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbeIZAQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:16:12 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ke0neSv0rauJ; Tue, 25 Sep 2018 20:07:29 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC69500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:9500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18E051EC0104;
        Tue, 25 Sep 2018 20:07:29 +0200 (CEST)
Date:   Tue, 25 Sep 2018 20:07:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180925180458.GG23986@zn.tnic>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
 <20180925152659.GE23986@zn.tnic>
 <20180925175023.GA16725@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180925175023.GA16725@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:50:23AM -0700, Luck, Tony wrote:
> There are way too many places where we use the identifier "bus"
> in the edac core and drivers. But I'm not sure that we need a
> static array mc_bus[EDAC_MAX_MCS].

That, of course, is another way of looking at it which I didn't think
of.

> Why can't we:
> 
> 
> -	mci->bus = &mc_bus[mci->mc_idx];
> +	mci->bus = kmalloc(sizeof *(mci->bus), GFP_KERNEL);
> 
> and then figure out where to kfree(mci->bus) on driver removal?

AFAICT, in _edac_mc_free(). We free there mci itself so kfree(mci->bus)
can happen directly before it.

> Do we every do arithmetic on different mci->bus pointers that
> assume they are all part of a single array?

AFAICT, we use that thing for the bus_reg/unreg functions and we hand it
back'n'forth in edac_mc_sysfs.c, see

$ git grep -E "mci.*bus" drivers/edac/
drivers/edac/edac_mc.c:763:     mci->bus = &mc_bus[mci->mc_idx];
drivers/edac/edac_mc_sysfs.c:408:       csrow->dev.bus = mci->bus;
drivers/edac/edac_mc_sysfs.c:639:       dimm->dev.bus = mci->bus;
drivers/edac/edac_mc_sysfs.c:928:       mci->bus->name = name;
drivers/edac/edac_mc_sysfs.c:930:       edac_dbg(0, "creating bus %s\n", mci->bus->name);
drivers/edac/edac_mc_sysfs.c:932:       err = bus_register(mci->bus);
drivers/edac/edac_mc_sysfs.c:943:       mci->dev.bus = mci->bus;
drivers/edac/edac_mc_sysfs.c:1002:      bus_unregister(mci->bus);
drivers/edac/edac_mc_sysfs.c:1035:      struct bus_type *bus = mci->bus;
drivers/edac/edac_mc_sysfs.c:1036:      const char *name = mci->bus->name;
drivers/edac/edac_mc_sysfs.c:1071:      mci_pdev->bus = edac_get_sysfs_subsys();
drivers/edac/i5100_edac.c:967:  priv->debugfs = edac_debugfs_create_dir_at(mci->bus->name, i5100_debugfs);
drivers/edac/i7core_edac.c:1170:        pvt->addrmatch_dev->bus = mci->dev.bus;
drivers/edac/i7core_edac.c:1191:                pvt->chancounts_dev->bus = mci->dev.bus;

HOWEVER, look at

  88d84ac97378 ("EDAC: Fix lockdep splat")

Now I remember. I did that for lockdep because it wants statically
allocated memory. I'll try to think of something tomorrow.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
