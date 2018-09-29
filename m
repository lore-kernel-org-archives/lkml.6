Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A61C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAC22064E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAC22064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeI2O61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:58:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:52108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbeI2O61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:58:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7ADFFAF99;
        Sat, 29 Sep 2018 08:30:52 +0000 (UTC)
Date:   Sat, 29 Sep 2018 10:30:52 +0200
From:   Borislav Petkov <bp@suse.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v7 RESEND 4/4] kdump/vmcore: support encrypted old memory
 with SME enabled
Message-ID: <20180929083052.GA13786@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-5-lijiang@redhat.com>
 <20180928083852.GA21895@zn.tnic>
 <1c27b9a9-ae93-011a-b003-a50ecc22ccc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c27b9a9-ae93-011a-b003-a50ecc22ccc5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 02:24:52PM +0800, lijiang wrote:
> At first, i added an input parameter for read_from_oldmem() because of encryption(SME). But
> for avoiding to also add the same parameter for copy_oldmem_page(), so i added a new function
> copy_oldmem_page_encrypted(). Maybe you had noticed that these functions were very similar.

If you have two very similar functions, you add a *static* workhorse function:

static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize, unsigned long offset,
				  int userbuf, bool encrypted)

and you define two wrappers:

copy_oldmem_page()
copy_oldmem_page_encrypted()

which both call __copy_oldmem_page() with the appropriate parameters.

But you do *not* do a separate compilation unit just because. None of
the reasons you've mentioned warrant having a separate compilation
unit while you already have *the* perfect place to put everything -
arch/x86/kernel/crash_dump_64.c

> So sorry, here "oldmem encrypted" means the "old memory is encrypted".

I know what it means - I'm trying to explain to you to write it out
in plain english and not use some strange constructs like "oldmem
encrypted".

A reader would wonder: why is this thing semi-abbreviated and in
quotation marks? Does that mean anything special?

Our comments should not be write-only. So after you've written it, try
to read it as someone who sees the code for the first time and think
hard whether she/he will understand it.

Do you catch my drift now?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
