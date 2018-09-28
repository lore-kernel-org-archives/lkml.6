Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8047FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494B321748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494B321748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbeI1Qc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:32:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeI1Qc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:32:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E53D308124B;
        Fri, 28 Sep 2018 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF84F5E1BF;
        Fri, 28 Sep 2018 10:09:08 +0000 (UTC)
Subject: Re: [PATCH v7 RESEND 2/4] kexec: allocate unencrypted control pages
 for kdump in case SME is enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-3-lijiang@redhat.com> <20180927165323.GC19779@zn.tnic>
 <ef91c6cd-03dd-1a72-eea8-97d05d0ad370@redhat.com>
 <20180928075654.GA20768@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <2c5000d8-9f20-cc85-6d41-d6ece314c6ba@redhat.com>
Date:   Fri, 28 Sep 2018 18:09:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928075654.GA20768@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 28 Sep 2018 10:09:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月28日 15:57, Borislav Petkov 写道:
> On Fri, Sep 28, 2018 at 11:52:21AM +0800, lijiang wrote:
>> There are two functions that are usually called in pairs, they are:
>> arch_kexec_post_alloc_pages() and arch_kexec_pre_free_pages().
>>
>> One marks the pages as decrypted, another one marks the pages as encrypted.
>>
>> But for the crash control pages, no need to call arch_kexec_pre_free_pages(),
>> there are three reasons:
>> 1. Crash pages are reserved in memblock, these pages are only used by kdump,
>>    no other people uses these pages;
>>
>> 2. Whenever crash pages are allocated, these pages are always marked as
>>    decrypted(when SME is active);
>>
>> 3. If we plan to call the arch_kexe_pre_free_pages(), we have to store these
>> pages to somewhere, which will have more code changes.
> 
> I don't think any of that answers the question *why* control pages do
> not need to be marked encrypted again. And I think the reason is simple:
> because you don't really need to, because once the crash kernel is done,
> you reboot the box.
> 
Thanks for your comment, your explanation is very good.

But there are another cases, we might load or unload the crash kernel image and
initrafms, maybe again and again for test or debug, we don't reboot at once. For
example, repeat the following steps:

systemctl start kdump.service
...
systemctl stop kdump.service

But we always mark these pages as decrypted whenever these control pages are
allocated, because other people can't use these pages(reserved memory), which
are only used by kdump, so no need to mark these pages as encrypted again.

Regards,
Lianbo
