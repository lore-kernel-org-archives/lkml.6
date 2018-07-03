Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68451C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F92C219EE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F92C219EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeGCLOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:14:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753048AbeGCLOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:14:36 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iYgjWA9L0CLD; Tue,  3 Jul 2018 13:14:34 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC6E00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:6e00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1FA51EC00EA;
        Tue,  3 Jul 2018 13:14:34 +0200 (CEST)
Date:   Tue, 3 Jul 2018 13:14:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, dyoung@redhat.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org,
        bhe@redhat.com
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Message-ID: <20180703111428.GB5748@zn.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com>
 <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 06:58:14PM +0800, lijiang wrote:
> For kdump, the elf header finally use the crash kernel reserved memory, it is not an old memory.

Lamme repeat my suggestion:

So beef up the logic in __ioremap_caller() to figure out based on the
address whether to access the memory encrypted or not. In general, you
can deduce, based on the region you're mapping, whether you need to map
in encrypted or decrypted.

For example:

        addr = elfcorehdr_addr;

        /* Read Elf header */
        rc = elfcorehdr_read((char *)&ehdr, sizeof(Elf64_Ehdr), &addr);
        if (rc < 0)
                return rc;

elfcorehdr_addr has that elfcorehdr address. So you can check which address
you're mapping and do:

__ioremap_caller:

...
	prot = __ioremap_compute_prot(...);

and that __ioremap_compute_prot() function which you will add will have
all that logic to determine encrypted or not by comparing addresses etc.

Does that make more sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
