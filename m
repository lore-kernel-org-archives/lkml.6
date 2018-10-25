Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF62C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0492084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0492084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeJZIZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:25:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:53124 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbeJZIZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:25:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 16:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,425,1534834800"; 
   d="scan'208";a="84227049"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2018 16:51:02 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D3CAD301B82; Thu, 25 Oct 2018 16:51:02 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:51:02 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/microcode: Handle negative microcode revisions
Message-ID: <20181025235102.GK6218@tassilo.jf.intel.com>
References: <20181020144158.6261-1-andi@firstfloor.org>
 <20181020174109.GE28301@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020174109.GE28301@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 07:41:36PM +0200, Borislav Petkov wrote:
> Dropping stable.
> 
> On Sat, Oct 20, 2018 at 07:41:58AM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The Intel microcode revision space is unsigned. Inside Intel there are special
> > microcodes that have the highest bit set, and they are considered to have
> > a higher revision than any microcodes that don't have this bit set.
> > 
> > The function comparing the microcode revision in the Linux driver compares
> > u32 with int, which ends up being signed extended to long on 64bit
> > systems. This results in these highest bit set microcode revision not loading
> > because their revision appears negative and smaller than the
> > existing microcode.
> > 
> > Change the comparison to unsigned. With that the loading works
> > as expected.
> > 
> > Cc: stable@vger.kernel.org # Any supported stable
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > --
> > v2: White space changes.
> > ---
> >  arch/x86/kernel/cpu/microcode/intel.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> > index 16936a24795c..e54d402500d3 100644
> > --- a/arch/x86/kernel/cpu/microcode/intel.c
> > +++ b/arch/x86/kernel/cpu/microcode/intel.c
> > @@ -93,7 +93,8 @@ static int find_matching_signature(void *mc, unsigned int csig, int cpf)
> >  /*
> >   * Returns 1 if update has been found, 0 otherwise.
> >   */
> > -static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
> > +static int has_newer_microcode(void *mc, unsigned int csig, int cpf,
> > +			       unsigned new_rev)
> >  {
> >  	struct microcode_header_intel *mc_hdr = mc;
> >  
> > -- 
> 
> Please incorporate all review comments before sending a new version of
> your patch.

I replaced one more microcodes with microcodes revisions if that is
what you meant.

-Andi
