Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FCFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC262088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC262088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeH1VCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:02:04 -0400
Received: from foss.arm.com ([217.140.101.70]:42694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1VCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:02:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3896480D;
        Tue, 28 Aug 2018 10:09:28 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.Emea.Arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD3C73F5BD;
        Tue, 28 Aug 2018 10:09:26 -0700 (PDT)
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
From:   James Morse <james.morse@arm.com>
Message-ID: <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
Date:   Tue, 28 Aug 2018 18:09:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824120102.GB29751@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 24/08/18 13:01, Borislav Petkov wrote:
> On Fri, Aug 24, 2018 at 10:48:24AM +0100, James Morse wrote:
>> so edac_raw_mc_handle_error() has no clue where the error happened. (I haven't
>> read what it does with this information yet).
> 
> See edac_inc_ce_error(), for example - it uses the layers which are not
> negative (-1) to increment the error counts of the respective layer. It
> all depends on what granularity of the hardware part you're reporting
> the error for: is it a DIMM rank, a whole DIMM or for a channel which
> can span multiple DIMM ranks. And so on...
> 
> Look at some of the drivers and how they're doing that layering. It all
> depends on whether you can get the precise info from the hw.

Hmmm, in this example we need the information from firmware, as that is where
ghes-edac gets its information from.

We already count the module/device/dimms in the smbios table, memory is
described as 'EDAC_MC_LAYER_ALL_MEM' with num_dimms. I think all we're missing
is which dimm in ghes_edac_report_mem_error(). We have the handle, we just need
a number between 1 and num_dimms.

If it turns out firmware doesn't populate the handles in its cper records, then
we can keep e->enable_per_layer_report false when calling
edac_raw_mc_handle_error().

(I suggest we ignore 'card', and just do this for the device/dimms).


>> Naively I thought we could generate some index during ghes_edac_count_dimms(),
>> and use this as e->${whichever}_layer. I hoped there would be something we could
>> already use as the index, but I can't spot it, so this will be more than the
>> one-liner I was hoping for!
> 
> If you can get that info from the hardware and injecting an error into
> a DIMM gives you the correct DIMM number so that we can increment the
> proper counter, then you're golden. I don't think that works reliably on
> x86, though, therefore the lumping together.

... 'correct DIMM number' ...

Does x86 have another source of memory-topology information it needs to
correlate smbios with?

For arm there is nothing else describing the memory-topology, so as long as we
can correlate the smbios table and ghes:cper records through the handles, we can
get this working for all systems.


Thanks,

James
