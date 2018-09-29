Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E3BC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317AC206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317AC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeI2QEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 12:04:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeI2QEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 12:04:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E3C130001EF;
        Sat, 29 Sep 2018 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 319FB5C1A1;
        Sat, 29 Sep 2018 09:36:07 +0000 (UTC)
Subject: Re: [PATCH v7 RESEND 4/4] kdump/vmcore: support encrypted old memory
 with SME enabled
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-5-lijiang@redhat.com> <20180928083852.GA21895@zn.tnic>
 <1c27b9a9-ae93-011a-b003-a50ecc22ccc5@redhat.com>
 <20180929083052.GA13786@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <76d9d338-2fc1-a8a5-8f12-c25d2ad092f3@redhat.com>
Date:   Sat, 29 Sep 2018 17:36:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180929083052.GA13786@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sat, 29 Sep 2018 09:36:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月29日 16:30, Borislav Petkov 写道:
> On Sat, Sep 29, 2018 at 02:24:52PM +0800, lijiang wrote:
>> At first, i added an input parameter for read_from_oldmem() because of encryption(SME). But
>> for avoiding to also add the same parameter for copy_oldmem_page(), so i added a new function
>> copy_oldmem_page_encrypted(). Maybe you had noticed that these functions were very similar.
> 
> If you have two very similar functions, you add a *static* workhorse function:
> 
> static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize, unsigned long offset,
> 				  int userbuf, bool encrypted)
> 
> and you define two wrappers:
> 
> copy_oldmem_page()
> copy_oldmem_page_encrypted()
> 
> which both call __copy_oldmem_page() with the appropriate parameters.
> 

Great! Previously i was afraid that the maintainer might disagree with
rewriting the function copy_oldmem_page().

That's really great. I will modify this patch and post the series again.

Thanks.
Lianbo
> But you do *not* do a separate compilation unit just because. None of
> the reasons you've mentioned warrant having a separate compilation
> unit while you already have *the* perfect place to put everything -
> arch/x86/kernel/crash_dump_64.c
> 
>> So sorry, here "oldmem encrypted" means the "old memory is encrypted".
> 
> I know what it means - I'm trying to explain to you to write it out
> in plain english and not use some strange constructs like "oldmem
> encrypted".
> 
> A reader would wonder: why is this thing semi-abbreviated and in
> quotation marks? Does that mean anything special?
> 
> Our comments should not be write-only. So after you've written it, try
> to read it as someone who sees the code for the first time and think
> hard whether she/he will understand it.
> 
> Do you catch my drift now?
> 
Yes, got it. Thanks for your valuable time and patience.

Regards,
Lianbo
