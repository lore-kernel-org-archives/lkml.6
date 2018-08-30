Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417BE2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417BE2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeH3Obx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:31:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbeH3Obu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:31:50 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ec7GmZHc5xXZ; Thu, 30 Aug 2018 12:30:04 +0200 (CEST)
Received: from nazgul.tnic (46-10-68-224.ip.btc-net.bg [46.10.68.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CAA51EC0380;
        Thu, 30 Aug 2018 12:30:03 +0200 (CEST)
Date:   Thu, 30 Aug 2018 12:28:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     Tyler Baicar <baicar.tyler@gmail.com>,
        Tyler Baicar <tbaicar@codeaurora.org>, wufan@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        harba@qti.qualcomm.com, mchehab@kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
Message-ID: <20180830102815.GB20005@nazgul.tnic>
References: <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <20180824120102.GB29751@nazgul.tnic>
 <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
 <20180829073804.GA6843@nazgul.tnic>
 <2e7b984a-8f8f-dad7-4ee5-043dd236a9b1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e7b984a-8f8f-dad7-4ee5-043dd236a9b1@arm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 11:20:48AM +0100, James Morse wrote:
> Right. I'd like ghes-edac to work in the same way for both architectures.
> 
> I think this is best done by stuffing the dmi-handle in struct dimm_info during
> ghes_edac_dmidecode(), then populating the struct edac_raw_error_desc layers
> from the matching mci->dimms 'location'.
> 
> For EDAC_MC_LAYER_ALL_MEM this boils down to a flat index, so pointer arithmetic
> on mci->dimms is an appropriate short cut.

It all sounds nice on paper but you should try it on a couple of
machines first. See whether/how it actually works there.

Also, this probably would need to not change x86 unless you wanna fix it
there too. I'd think twice before I attempt such a thing though :)

> (We should probably 'FIXME: It shouldn't be hard to also fill the DIMM labels'
> at the same time so that no-one is tempted to interpret the edac:dimm-idx)

See above.

> > In an ideal world, I'd like to be able to query the SPD chips on the
> 
> (oh, that can be done?)

There was some talk initially and I've seen BIOS read SPD chips and
showing DIMM info but I've heard the word "proprietary" a couple of
times. Haven't dug any deeper though.

> I got educated by the people who look after specifications last time I touched
> this [0]. SMBIOS tables are required by Arm's 'Server Base Boot Requirements',
> It lists the memory-device and physical-memory-array as required.

It is always better to have certification on your side. Should make ARM
vendors dance.

> I will drop them a note that we will be depending on the handle, and it should
> go on the list too... if its not populated on today's systems we can fall back
> to !e->enable_per_layer_report as we do today.

Right.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
