Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A37C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA5820870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA5820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbeKTOEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 09:04:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbeKTOEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 09:04:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39FF83001709;
        Tue, 20 Nov 2018 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30ABC10021B6;
        Tue, 20 Nov 2018 03:37:32 +0000 (UTC)
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
To:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, akpm@linux-foundation.org, bhe@redhat.com
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com> <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <20181119095515.GC14045@dhcp-128-65.nay.redhat.com>
 <20181119102812.GA14688@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <a1c58bb8-390b-e249-599f-c973d575e1ca@redhat.com>
Date:   Tue, 20 Nov 2018 11:37:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181119102812.GA14688@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 20 Nov 2018 03:37:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月19日 18:28, Borislav Petkov 写道:
> On Mon, Nov 19, 2018 at 05:55:15PM +0800, Dave Young wrote:
>> Another thing is it is not worth to get the exact info, the 1st kernel
>> reserved part is just fine to be reserved as well in 2nd kernel, no 
>> side effects.  Actually there might be some obscure use cases we
>> do not find which rely those reserved memory ranges so it is better to
>> have.
> 
> That makes sense as an argument. The cleaner thing would be to figure
> out only *which* ranges we're going to need but that is probably harder
> than simply exporting what the first kernel sees. But why we're doing
> it, needs to be in the commit message so that it is clear when bug
> hunting later.
> 
> ...
> 
>> The basic problem is that this device is in PCI segment 1 and
>> the kernel PCI probing cannot find it without all the e820 i/o
>> reservations being present in the e820 table. And the crash kernel
>> does not have those reservations because the kexec command does not
>> pass i/o reservation via the memmap= command line option. (This
>> problem does not show up for other vendors, as SGI is apparently the
>> only one using extended PCI. The lookup of devices in PCI segment 0
>> actually fails for everyone, but devices in segment 0 are then found
>> by some legacy lookup method.) The workaround for this is to fix kexec
>> to pass i/o reserved areas to the crash kernel.
> 
> Yap, this is the *why* I'm looking for. Lianbo, in your next submission,
> please add Dave's explanations to your commit messages.
> Ok. Thank you, Dave and Boris. I will add Dave's explanations to patch log.

BTW: Boris has mentioned the solution which adds the new descriptor 'IORES_DESC_RESERVED'.

Which solution do you prefer? Add the new I/O resource descriptor 'IORES_DESC_RESERVED'(patch v7)
or exactly comparing a string(patch v6)?

These two solutions are good to me. 

Thanks.
Lianbo
> If it says "we need to do X" in the commit message, without a reason
> given *why* we need to, then there's no way for us to know *why* we did
> it, when looking at this months from now. And we absolutely need the
> *why* when staring at the code and fixing the next bug/issue.
> 
> Thx.
> 
