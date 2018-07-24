Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A23C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDA520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WpCXnxbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDA520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbeGXPI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:08:59 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53598 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbeGXPI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z2tZ8NjMLqL1IfRruu18r+B4Jzakw6G2F73Jlj503h8=; b=WpCXnxbdKhoWc2zfLXmNyIsil
        TmLOYUD//L8FdwF9wuzTba8/isyRGVPvQ5QlY0Tow84+rWF1ucqPoGynnbGq+D0xEqfAsrSTAH440
        N0TpXSEYdZSlR9W+p0U6m3AWUma96fD5WDbqI+ZVDPd/lheud9CHZ83eU5fFFiX1S3cI0=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:57031)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fhxtH-0000iX-Ro; Tue, 24 Jul 2018 15:02:15 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fhxtB-000700-De; Tue, 24 Jul 2018 15:02:09 +0100
Date:   Tue, 24 Jul 2018 15:02:04 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Alexei Colin <acolin@isi.edu>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Bounine <alex.bou9@gmail.com>,
        Barry Wood <barry.wood@idt.com>,
        John Paul Walters <jwalters@isi.edu>
Subject: Re: [PATCH] arm: enable RapidIO config options in Kconfig
Message-ID: <20180724140203.GV17271@n2100.armlinux.org.uk>
References: <20180724134122.86718-1-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724134122.86718-1-acolin@isi.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:41:26AM -0400, Alexei Colin wrote:
> ARM SoCs with a PCI bus offer the RapiodIO config menu; SoCs with
> RapidIO IP blocks but without a PCI bus, need to add "select
> HAS_RAPIDIO" to the Kconfig entry for that SoC (e.g. ARCH_*).
> 
> HAS_RAPIDIO was chosen over HAVE_RAPIDIO to be consistent with
> other architectures which already define this flag (powerpc).

Is there any reason we can't have the RAPIDIO and HAS_RAPIDIO config
blocks in drivers/rapidio/Kconfig (maybe without the || PCI - see
below), and then have architecture Kconfig files do:

config (ARM or PPC)
	select HAS_RAPIDIO if PCI

or in the case of MIPS:

config MIPS
	...
	select HAS_RAPIDIO

That would avoid duplicating almost identical RAPIDIO and HAS_RAPIDIO
config blocks in architecture Kconfig files.

Why should rapidio be available just because we have PCI selected?  If
it behaves as a PCI add-in card, then why isn't this available for any
architecture with PCI?

What about build coverage - shouldn't RAPIDIO be selectable for (eg)
other architectures via COMPILE_TEST if it's supposed to be generic?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
