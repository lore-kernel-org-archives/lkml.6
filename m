Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22383ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54A020848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54A020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeJ0HDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:03:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42788 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbeJ0HDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:03:52 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Geu0eJYTX6VR; Sat, 27 Oct 2018 00:25:03 +0200 (CEST)
Received: from nazgul.tnic (unknown [185.30.24.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF2DF1EC05B0;
        Sat, 27 Oct 2018 00:25:03 +0200 (CEST)
Date:   Sat, 27 Oct 2018 00:25:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Petr Tesarik <ptesarik@suse.cz>
Cc:     lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org,
        mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181026222517.GB26927@nazgul.tnic>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181026182440.20a4b107@ezekiel.suse.cz>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 06:24:40PM +0200, Petr Tesarik wrote:
> But we need the MSR value from the panic kernel environment, not while
> the production kernel is still running, right?

Actually, we need only the encryption bit number (and it should be 0
otherwise to denote SME wasn't enabled).

I guess something like

	VMCOREINFO_NUMBER(sme_mask);

which gets written by the kexec-ed kernel.

> If so, then this reminds me that I have wanted for a long time to store
> more of the hardware state in a vmcore NOTE after a kernel crash ...
> control registers, MSRs and whatnot. Of course, this would be a
> long-term project, but I wonder what other people think about it in
> general.

I guess that sounds like a good idea - the more relevant hw info for
debugging, the better. Determining the important MSRs to save would need
a bit of a pondering over though. For example, some MSRs are per-core,
some per-socket, etc...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
