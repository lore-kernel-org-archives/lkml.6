Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5239C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CCA24D6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CCA24D6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933626AbeGCJjd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:39:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38426 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933358AbeGCJjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:39:32 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cD2ic_AphpCw; Tue,  3 Jul 2018 11:39:31 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC6E00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:6e00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA8B81EC03AD;
        Tue,  3 Jul 2018 11:39:30 +0200 (CEST)
Date:   Tue, 3 Jul 2018 11:39:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, dyoung@redhat.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org,
        bhe@redhat.com
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Message-ID: <20180703093924.GA5748@zn.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com>
 <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:17:19AM +0800, lijiang wrote:
> for example, the elfcorehdr. In fact, the elfcorehdr and notes

You mean this?

 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-       return read_from_oldmem(buf, count, ppos, 0);
+       return read_from_oldmem(buf, count, ppos, 0, sme_active());

That looks encrypted to me.

> call the same function(read_from_oldmem->ioremap_cache), in this case,
> it is very difficult to properly remap the memory if the caller don't
> care whether the memory is encrypted.

So beef up the logic in __ioremap_caller() to figure out based on the
address whether to access the memory encrypted or not. You can find out
the elfcorehdr address in the capture kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
