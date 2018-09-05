Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C2C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059202077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059202077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeIESf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:35:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeIESf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:35:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99F747721E;
        Wed,  5 Sep 2018 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-65.pek2.redhat.com [10.72.12.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCE022027069;
        Wed,  5 Sep 2018 14:04:53 +0000 (UTC)
Subject: Re: [PATCH 2/5 V6] x86/ioremap: strengthen the logic in
 early_memremap_pgprot_adjust() to adjust encryption mask
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20180831081930.31561-1-lijiang@redhat.com>
 <20180831081930.31561-3-lijiang@redhat.com>
 <20180903024512.GA2568@dhcp-128-65.nay.redhat.com>
 <d2229538-51d5-ead7-c7e5-f4afe5b53693@redhat.com>
 <20180904004417.GA9842@dhcp-128-65.nay.redhat.com>
 <20180904012902.GB9842@dhcp-128-65.nay.redhat.com>
 <20180904015131.GA10877@dhcp-128-65.nay.redhat.com>
 <3a9ae246-0c3a-753a-41e2-f2788a882c50@redhat.com>
 <20180905064658.GA10310@dhcp-128-65.nay.redhat.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <a09a3a21-9156-ce96-b7ef-9f7e7cda12b3@redhat.com>
Date:   Wed, 5 Sep 2018 22:04:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905064658.GA10310@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 05 Sep 2018 14:05:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 05 Sep 2018 14:05:05 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月05日 14:46, Dave Young 写道:
> [snip]
>>
>> As previously mentioned, there are also many differences between kexec and kdump. In general,
>> kexec needs to look at all of available physical memory, but kdump doesn't need.
>>
>> For kexec, kexec-tools will read /sys/firmware/memmap and recreate the e820 ranges for the 2nd
>> kernel. If it fails, will use /proc/iomem.
>>
>> For kdump, kexec-tools will read /proc/iomem and recreate the e820 ranges for kdump kernel.
>> BTW: we can not get the range of persistent memory from /proc/iomem. So e820 ranges don't contain
>> the persistent memory in kdump kernel, this is the real reason why i need to strengthen the logic
>> of adjusting memory encryption mask.
> 
> "persistent memory" is different, I think you meant about some reserved
> memory instead
> 
>>
>> If kexec-tools also use /sys/firmware/memmap for kdump(like kexec), kdump kernel can also work
>> without a fix, but the kexec-tools will have to be modified. Are you sure that you want me to
>> fix kexec-tools instead of kernel?
> 
> Yes, please fix kexec-tools to pass reserved ranges in e820, you will
> not need this patch then.
> 

This might be a kexec-tools bug, i have posted a patch for kexec-tools(please check kexec@lists.infradead.org).
Thanks.

> Thanks
> Dave
> 
