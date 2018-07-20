Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A12EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084CC2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084CC2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbeGTKmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:42:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727167AbeGTKmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:42:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F5AE40776C2;
        Fri, 20 Jul 2018 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-74.pek2.redhat.com [10.72.12.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 625FE1C640;
        Fri, 20 Jul 2018 09:55:07 +0000 (UTC)
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
To:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Cc:     bhe@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com,
        joro@8bytes.org, thomas.lendacky@amd.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org
References: <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
 <20180713170857.GB17896@nazgul.tnic>
 <33453712-9b0b-e8b9-08a6-de09e0806dd6@redhat.com>
 <20180720052304.GA9146@dhcp-128-65.nay.redhat.com>
 <20180720073245.GA26926@nazgul.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <562d8611-750d-3624-1a1b-df21f39812d6@redhat.com>
Date:   Fri, 20 Jul 2018 17:55:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180720073245.GA26926@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 09:55:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 09:55:15 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年07月20日 15:32, Borislav Petkov 写道:
> On Fri, Jul 20, 2018 at 01:23:04PM +0800, Dave Young wrote:
>>> Here, it doesn't need to dump MMIO space of the previous kernel, when the
>>> kdump kernel boot, the MMIO address will be remapped in decryption manners,
>>> but the MMIO address don't belong to the range of the crash reserved memory,
>>> for the kdump kernel, the MMIO space(address) and IOMMU device table(address)
>>> are outside address, whereas, the IOMMU device table is encrypted in the first
>>> kernel, the kdump kernel will need to copy the content of IOMMU device table
>>> from the first kernel when the kdump kernel boot, so the IOMMU device table will
>>> be remapped in encryption manners.
> 
> -ENOFCKINGPARSE
> 
> I believe you're the only one who understands that humongous sentence.Sorry for this.

> How about using a fullstop from time to time. And WTF is "encryption
> manners"?
> 
>>> So some of them require to be remapped in encryption manners, and some(address)
>>> require to be remapped in decryption manners.
> 
>> There could be some misunderstanding here.
> 
> Hell yeah there's a misunderstanding!
> 
> Can you folks first relax, sit down and explain the whole problem in
> *plain* English using *simple* sentences. *Not* like the unparseable
> mess above. Use simple, declaratory sentences and don't even try to
> sound fancy:
> 
> "The first kernel boots. It's memory is encrypted... Now, the second
> kernel boots. It must do A because of B. In order to do A, it needs to
> do C. Because D..."
> 
> And so on. Explain what the problem is first. Then explain the proposed
> solution. Explain *why* it needs to be done this way.
> 
> When you've written your explanation, try to read it as someone who
> doesn't know kdump and *think* hard whether your explanation makes
> sense. If it doesn't, fix it and read it again. Rinse and repeat. Until
> it is clear to unenlightened readers too.
> 
Thanks for your advice, I will rewrite the log and send them again.

> It is about time this hurried throwing of half-baked patches at
> maintainers and seeing what sticks, stops!
> 
