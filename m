Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7E0C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 02:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1A721746
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 02:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho9dZTH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1A721746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbeHSFeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 01:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725741AbeHSFeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 01:34:31 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3ED321737;
        Sun, 19 Aug 2018 02:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534645482;
        bh=A1B46vlfA7dsimYJDxjShA5tRftYC8uUYKw3uBwQv9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ho9dZTH53APNhdX8sV0gVhyfzZ6S6hHjxVvVJDOsmcLdjaywy+nqVJ/UhnKsDFBS9
         IOG+wmACVmqwA8nRBJQSuIYj13KKQ5n5xVHx1bCwZgsxHxJNJVcrukiMzCYacdEKAU
         Lr28L4aRWwr/FMZ3a/xZAP2cgkqQ0rDn2Rq2Fhoc=
Date:   Sat, 18 Aug 2018 21:24:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
Message-ID: <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-2-benh@kernel.crashing.org>
 <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
 <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 01:24:51PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2018-08-17 at 10:44 -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 17, 2018 at 02:48:57PM +1000, Benjamin Herrenschmidt wrote:
> > > This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.
> > 
> > Just to be clear, if I understand correctly, this is a pure revert of
> > 44bda4b7d26e and as such it reintroduces the problem solved by that
> > commit.
> > 
> > If your solution turns out to be better, that's great, but it would be
> > nice to avoid the bisection hole of reintroducing the problem, then
> > fixing it again later.
> 
> There is no way to do that other than merging the revert and the fix
> into one. That said, the race is sufficiently hard to hit that I
> wouldn't worry too much about it.

OK, then at least mention that in the changelog.

> > > The new pci state mutex provides a simpler way of addressing
> > > this race and avoids the relative includes added to the powerpc
> > > code.
> 
