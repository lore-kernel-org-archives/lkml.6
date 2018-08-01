Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23FE20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23FE20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389799AbeHARQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:16:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46624 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389476AbeHARQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:16:05 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1EQqhzoHO-ko; Wed,  1 Aug 2018 17:29:49 +0200 (CEST)
Received: from nazgul.tnic (95-42-131-245.ip.btc-net.bg [95.42.131.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55B6D1EC0591;
        Wed,  1 Aug 2018 17:29:49 +0200 (CEST)
Date:   Wed, 1 Aug 2018 17:29:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, sironi@amazon.de, tony.luck@intel.com
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
Message-ID: <20180801152926.GB13988@nazgul.tnic>
References: <d8ac835211e5649b5494141a0decc3bc@natalenko.name>
 <b84518d4-fc78-ca2a-7bde-ad6b5f6a7d83@redhat.com>
 <0a4c663887ecc1672d9927ed7256485b@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a4c663887ecc1672d9927ed7256485b@natalenko.name>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(drop stable@ from CC)

On Wed, Aug 01, 2018 at 04:16:42PM +0200, Oleksandr Natalenko wrote:
> Once the kernel log does not contain a printout regarding updated microcode
> anymore (because the log buffer is limited in size and can be overwritten)

There's no reliable way to get the old microcode revision which was
overwritten during the upgrade. If dmesg gets overwritten you lose, like
in all the other gazillion cases where you lose information due to that.
Sorry.

This becomes an even bigger problem if you have a long-running system
which upgrades microcode a couple of times before being rebooted again.
In that case, your only log which contains the microcode revisions being
upgraded is dmesg.

> once you have a vmcore, it is handy to use boot_cpu_data to compare
> the microcode version with the per-CPU value to find out that is was
> updated at all.

boot_cpu_data.microcode was never meant to contain the *previous*
microcode revision AFAICT - it just didn't get updated, which we're
fixing now.

> Or, maybe, that can be inspected in another way now?

Dunno, does kdump collect /proc/cpuinfo? If so:

$ grep microcode /proc/cpuinfo

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
