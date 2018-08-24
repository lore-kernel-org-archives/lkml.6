Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F1AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65E62157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65E62157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeHXPft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:35:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeHXPft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:35:49 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uISBwQ4W370m; Fri, 24 Aug 2018 14:01:09 +0200 (CEST)
Received: from nazgul.tnic (79-100-101-223.ip.btc-net.bg [79.100.101.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1311D1EC0310;
        Fri, 24 Aug 2018 14:00:49 +0200 (CEST)
Date:   Fri, 24 Aug 2018 14:01:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     Tyler Baicar <baicar.tyler@gmail.com>,
        Tyler Baicar <tbaicar@codeaurora.org>, wufan@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        harba@qti.qualcomm.com, mchehab@kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
Message-ID: <20180824120102.GB29751@nazgul.tnic>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 10:48:24AM +0100, James Morse wrote:
> Why get avoid the layer stuff? Isn't counting DIMM/memory-devices what
> EDAC_MC_LAYER_SLOT is for?

Yap.

> so edac_raw_mc_handle_error() has no clue where the error happened. (I haven't
> read what it does with this information yet).

See edac_inc_ce_error(), for example - it uses the layers which are not
negative (-1) to increment the error counts of the respective layer. It
all depends on what granularity of the hardware part you're reporting
the error for: is it a DIMM rank, a whole DIMM or for a channel which
can span multiple DIMM ranks. And so on...

Look at some of the drivers and how they're doing that layering. It all
depends on whether you can get the precise info from the hw.

> ghes_edac_report_mem_error() does check CPER_MEM_VALID_MODULE_HANDLE, and if its
> set, it uses the handle to find the bank/device strings and prints them out.

Yap, and the error counts are lumped together into

  /sys/devices/system/edac/mc/mc*/ce_noinfo_count

> Naively I thought we could generate some index during ghes_edac_count_dimms(),
> and use this as e->${whichever}_layer. I hoped there would be something we could
> already use as the index, but I can't spot it, so this will be more than the
> one-liner I was hoping for!

If you can get that info from the hardware and injecting an error into
a DIMM gives you the correct DIMM number so that we can increment the
proper counter, then you're golden. I don't think that works reliably on
x86, though, therefore the lumping together.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
