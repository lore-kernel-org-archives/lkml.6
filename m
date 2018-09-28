Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3FAC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BBA21754
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BBA21754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeI1OTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:19:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59958 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbeI1OTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:19:41 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YGZO4WlCcvF9; Fri, 28 Sep 2018 09:57:10 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA5700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:5700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 079CC1EC032B;
        Fri, 28 Sep 2018 09:57:09 +0200 (CEST)
Date:   Fri, 28 Sep 2018 09:57:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v7 RESEND 2/4] kexec: allocate unencrypted control pages
 for kdump in case SME is enabled
Message-ID: <20180928075654.GA20768@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-3-lijiang@redhat.com>
 <20180927165323.GC19779@zn.tnic>
 <ef91c6cd-03dd-1a72-eea8-97d05d0ad370@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef91c6cd-03dd-1a72-eea8-97d05d0ad370@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:52:21AM +0800, lijiang wrote:
> There are two functions that are usually called in pairs, they are:
> arch_kexec_post_alloc_pages() and arch_kexec_pre_free_pages().
> 
> One marks the pages as decrypted, another one marks the pages as encrypted.
> 
> But for the crash control pages, no need to call arch_kexec_pre_free_pages(),
> there are three reasons:
> 1. Crash pages are reserved in memblock, these pages are only used by kdump,
>    no other people uses these pages;
> 
> 2. Whenever crash pages are allocated, these pages are always marked as
>    decrypted(when SME is active);
> 
> 3. If we plan to call the arch_kexe_pre_free_pages(), we have to store these
> pages to somewhere, which will have more code changes.

I don't think any of that answers the question *why* control pages do
not need to be marked encrypted again. And I think the reason is simple:
because you don't really need to, because once the crash kernel is done,
you reboot the box.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
