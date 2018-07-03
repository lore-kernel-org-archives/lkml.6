Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54089C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141B724BE1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141B724BE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbeGCLZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:25:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752596AbeGCLZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:25:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5110A72634;
        Tue,  3 Jul 2018 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-173.pek2.redhat.com [10.72.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EA4C2026D76;
        Tue,  3 Jul 2018 11:25:24 +0000 (UTC)
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
 <20180703093924.GA5748@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <55b86851-4978-9289-8a1f-012c6114ec9e@redhat.com>
Date:   Tue, 3 Jul 2018 19:25:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180703093924.GA5748@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 11:25:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 11:25:30 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年07月03日 17:39, Borislav Petkov 写道:
> On Tue, Jul 03, 2018 at 10:17:19AM +0800, lijiang wrote:
>> for example, the elfcorehdr. In fact, the elfcorehdr and notes
> 
> You mean this?
> 
>  ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
>  {
> -       return read_from_oldmem(buf, count, ppos, 0);
> +       return read_from_oldmem(buf, count, ppos, 0, sme_active());
> 
> That looks encrypted to me.
> 
The elf notes is an old memory, it is encrypted.

But the elf header is a crash kernel reserved memory, which is unencrypted.
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, false);
 }

They call the same function(read_from_oldmem->ioremap_cache), so it is hard to
properly remap the memory if we don't use the parameter to distinguish. 

Regards,
Lianbo
>> call the same function(read_from_oldmem->ioremap_cache), in this case,
>> it is very difficult to properly remap the memory if the caller don't
>> care whether the memory is encrypted.
> 
> So beef up the logic in __ioremap_caller() to figure out based on the
> address whether to access the memory encrypted or not. You can find out
> the elfcorehdr address in the capture kernel.
> 
