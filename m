Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBE3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD712086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD712086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeH2Lfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:35:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbeH2Lfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:35:42 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CXm1YCnMwag3; Wed, 29 Aug 2018 09:39:50 +0200 (CEST)
Received: from nazgul.tnic (46-10-68-224.ip.btc-net.bg [46.10.68.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DFB761EC0330;
        Wed, 29 Aug 2018 09:39:49 +0200 (CEST)
Date:   Wed, 29 Aug 2018 09:38:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     Tyler Baicar <baicar.tyler@gmail.com>,
        Tyler Baicar <tbaicar@codeaurora.org>, wufan@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        harba@qti.qualcomm.com, mchehab@kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
Message-ID: <20180829073804.GA6843@nazgul.tnic>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <20180824120102.GB29751@nazgul.tnic>
 <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 06:09:24PM +0100, James Morse wrote:
> Does x86 have another source of memory-topology information it needs to
> correlate smbios with?

Bah, pinpointing the DIMM on x86 is a mess. There's no reliable way to
say which DIMM it is in certain cases (interleaving, mirrorring, ...)
and it is all platform-dependent. So we do the layers to dump a memory
location (node, memory controller, ....) so that we can at least limit
the number of DIMMs the user needs to replace/try.

In an ideal world, I'd like to be able to query the SPD chips on the
DIMMs and build the topology and then when an error happens to say,
"error in DIMM <silkscreen>" where silkscreen is what is written on the
motherboard under the DIMM socket.

But I don't see that happening any time soon...

> For arm there is nothing else describing the memory-topology, so as long as we
> can correlate the smbios table and ghes:cper records through the handles, we can
> get this working for all systems.

And then make sure vendors fill in the proper info in smbios. Because that's
also a mess on x86.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
