Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA28ECDE46
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9C02082B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9C02082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeJ0Lgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 07:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbeJ0Lgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 07:36:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8923C307D992;
        Sat, 27 Oct 2018 02:57:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 647A56714C;
        Sat, 27 Oct 2018 02:57:12 +0000 (UTC)
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
To:     Borislav Petkov <bp@alien8.de>, Petr Tesarik <ptesarik@suse.cz>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <a4bae45c-e52a-7fbb-6b74-5de12ea47368@redhat.com>
Date:   Sat, 27 Oct 2018 10:57:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026222517.GB26927@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sat, 27 Oct 2018 02:57:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月27日 06:25, Borislav Petkov 写道:
> On Fri, Oct 26, 2018 at 06:24:40PM +0200, Petr Tesarik wrote:
>> But we need the MSR value from the panic kernel environment, not while
>> the production kernel is still running, right?
> 
> Actually, we need only the encryption bit number (and it should be 0
> otherwise to denote SME wasn't enabled).
> 

Thanks for your comment.
For this patch, it really needs only the encryption bit number. 

For the AMD machine with SME feature, the OS or HV sets bit 47 of a
physical address to 1 in the page table entry to indicate the page
should be encrypted.

Thanks.
Lianbo

> I guess something like
> 
> 	VMCOREINFO_NUMBER(sme_mask);
> 
> which gets written by the kexec-ed kernel.
> 
>> If so, then this reminds me that I have wanted for a long time to store
>> more of the hardware state in a vmcore NOTE after a kernel crash ...
>> control registers, MSRs and whatnot. Of course, this would be a
>> long-term project, but I wonder what other people think about it in
>> general.
> 
> I guess that sounds like a good idea - the more relevant hw info for
> debugging, the better. Determining the important MSRs to save would need
> a bit of a pondering over though. For example, some MSRs are per-core,
> some per-socket, etc...
> 
