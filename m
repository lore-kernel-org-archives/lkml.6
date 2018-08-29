Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA434C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB812083C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB812083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeH2ORD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:17:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51730 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbeH2ORD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:17:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BD2F80D;
        Wed, 29 Aug 2018 03:20:51 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.Emea.Arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA6B23F5BD;
        Wed, 29 Aug 2018 03:20:49 -0700 (PDT)
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tyler Baicar <baicar.tyler@gmail.com>,
        Tyler Baicar <tbaicar@codeaurora.org>, wufan@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        harba@qti.qualcomm.com, mchehab@kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <20180824120102.GB29751@nazgul.tnic>
 <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
 <20180829073804.GA6843@nazgul.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <2e7b984a-8f8f-dad7-4ee5-043dd236a9b1@arm.com>
Date:   Wed, 29 Aug 2018 11:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829073804.GA6843@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 29/08/18 08:38, Borislav Petkov wrote:
> On Tue, Aug 28, 2018 at 06:09:24PM +0100, James Morse wrote:
>> Does x86 have another source of memory-topology information it needs to
>> correlate smbios with?
> 
> Bah, pinpointing the DIMM on x86 is a mess. There's no reliable way to
> say which DIMM it is in certain cases (interleaving, mirrorring, ...)
> and it is all platform-dependent. So we do the layers to dump a memory
> location (node, memory controller, ....) so that we can at least limit
> the number of DIMMs the user needs to replace/try.

Right. I'd like ghes-edac to work in the same way for both architectures.

I think this is best done by stuffing the dmi-handle in struct dimm_info during
ghes_edac_dmidecode(), then populating the struct edac_raw_error_desc layers
from the matching mci->dimms 'location'.

For EDAC_MC_LAYER_ALL_MEM this boils down to a flat index, so pointer arithmetic
on mci->dimms is an appropriate short cut.

(We should probably 'FIXME: It shouldn't be hard to also fill the DIMM labels'
at the same time so that no-one is tempted to interpret the edac:dimm-idx)


> In an ideal world, I'd like to be able to query the SPD chips on the

(oh, that can be done?)


> DIMMs and build the topology and then when an error happens to say,
> "error in DIMM <silkscreen>" where silkscreen is what is written on the
> motherboard under the DIMM socket.
> 
> But I don't see that happening any time soon...

>> For arm there is nothing else describing the memory-topology, so as long as we
>> can correlate the smbios table and ghes:cper records through the handles, we can
>> get this working for all systems.
> 
> And then make sure vendors fill in the proper info in smbios. Because that's
> also a mess on x86.

I got educated by the people who look after specifications last time I touched
this [0]. SMBIOS tables are required by Arm's 'Server Base Boot Requirements',
It lists the memory-device and physical-memory-array as required.

I will drop them a note that we will be depending on the handle, and it should
go on the list too... if its not populated on today's systems we can fall back
to !e->enable_per_layer_report as we do today.


Thanks,

James

[0] https://www.spinics.net/lists/arm-kernel/msg653133.html
