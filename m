Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DED7C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33172085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33172085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeJ0XdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 19:33:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39252 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbeJ0XdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 19:33:00 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BiYLkZVQrnPA; Sat, 27 Oct 2018 16:51:44 +0200 (CEST)
Received: from nazgul.tnic (x2f7f1ca.dyn.telefonica.de [2.247.241.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1855C1EC0496;
        Sat, 27 Oct 2018 16:51:43 +0200 (CEST)
Date:   Sat, 27 Oct 2018 16:51:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181027145151.GA7338@nazgul.tnic>
References: <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
 <20181027081343.GA1884@MiWiFi-R3L-srv>
 <20181027091007.GB1046@nazgul.tnic>
 <20181027093917.GA14493@MiWiFi-R3L-srv>
 <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 10:41:56PM +0800, lijiang wrote:
> Actually, the value of 'sme_me_mask' is 0x800000000000 when SME is
> enabled, otherwise it is 0. That is to say, if the bit 47 is set, the
> bit number is also 0x800000000000 (1 << 47UL);

Yes, and you can simply copy the mask into your variable and export
that. Thinking about it more, though, it might be better if you instead
export a smaller value - not an u64 - and construct the mask in
userspace. I.e., a u8 which should be enough for your current purposes.

I say current because if it turns out we need to export more SME-related
info to userspace, exporting an u64 and then OR-ing in more information
in it would allow that. u8 not so much. So doing something like:

[ misc	   ][ enc bit  ][ other misc SME info 				      ]
0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000
63   59   55   51   47   43   39   35   31   27   23   19   15   11   7    3

would allow for exporting that additional info.

Especially if we want to use VMCOREINFO for more than kexec things.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
