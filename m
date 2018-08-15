Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1CBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C50214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C50214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeHOSrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:47:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32816 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbeHOSrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:47:45 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id clZifKvmhkFe; Wed, 15 Aug 2018 17:54:45 +0200 (CEST)
Received: from nazgul.tnic (95-42-132-194.ip.btc-net.bg [95.42.132.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D11F11EC0104;
        Wed, 15 Aug 2018 17:54:44 +0200 (CEST)
Date:   Wed, 15 Aug 2018 17:54:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Message-ID: <20180815155452.GB28669@nazgul.tnic>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
 <20180809140834.59264-2-Yazen.Ghannam@amd.com>
 <20180809161806.GB20928@nazgul.tnic>
 <BN7PR12MB259395675EBD74400D9FEBE5F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN7PR12MB259395675EBD74400D9FEBE5F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:46:26PM +0000, Ghannam, Yazen wrote:
> This patch makes it so that we don't fail init just because some banks don't
> have names. The data caching we do is useful even if we fail to create sysfs
> entries for some banks. The interrupt handler can work fine without a sysfs
> entry for every bank. It seems like overkill to deallocate all the structures
> and sysfs entries for all the banks just because we fail to create entries for
> some banks that don't have names.

Maybe I'm missing the big picture here but why, all of a sudden, are
some banks without names? This clearly is new because it wasn't like
that before, so what is it? Maybe you should explain the bigger picture
first.

And if banks don't have names, then we should generate some for them
instead. Because this code is already ugly and recursive - we certainly
don't want to add more conditionals to it because that thing is a mess
as it is now.

> In other words, I think we should decouple the interrupt handler from the
> sysfs interface. The interface is nice to have but not necessary for the HW
> and OS to handle threshold interrupts. If we do so, then new HW with new,
> unnamed types will work with older versions of Linux.

To tell you the truth, I'm not at all psyched about telling the future.
We can try to be future-proof to a certain degree but this should not be
the determining factor how we design things.

But the aspect of decoupling sysfs representation from handler makes
sense. It just needs to be done cleanly.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
