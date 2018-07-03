Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F373DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3F5208A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3F5208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeGCLow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:44:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752185AbeGCLov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2801972634;
        Tue,  3 Jul 2018 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-173.pek2.redhat.com [10.72.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D63A111AF02;
        Tue,  3 Jul 2018 11:44:43 +0000 (UTC)
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, dyoung@redhat.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org,
        bhe@redhat.com
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com> <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
Date:   Tue, 3 Jul 2018 19:44:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180703111428.GB5748@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 11:44:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 11:44:51 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年07月03日 19:14, Borislav Petkov 写道:
> On Tue, Jul 03, 2018 at 06:58:14PM +0800, lijiang wrote:
>> For kdump, the elf header finally use the crash kernel reserved memory, it is not an old memory.
> 
> Lamme repeat my suggestion:
> 
> So beef up the logic in __ioremap_caller() to figure out based on the
> address whether to access the memory encrypted or not. In general, you
> can deduce, based on the region you're mapping, whether you need to map
> in encrypted or decrypted.
> 
> For example:
> 
>         addr = elfcorehdr_addr;
> 
>         /* Read Elf header */
>         rc = elfcorehdr_read((char *)&ehdr, sizeof(Elf64_Ehdr), &addr);
>         if (rc < 0)
>                 return rc;
> 
> elfcorehdr_addr has that elfcorehdr address. So you can check which address
> you're mapping and do:
> 
> __ioremap_caller:
> 
> ...
> 	prot = __ioremap_compute_prot(...);
> 
> and that __ioremap_compute_prot() function which you will add will have
> all that logic to determine encrypted or not by comparing addresses etc.
> 
> Does that make more sense?
> 
Thank you, Boris. Good idea, I will rethink about this issue and post it again.

Regards,
Lianbo
