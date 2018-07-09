Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DFCC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333AF2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333AF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeGINzt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:55:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932278AbeGINzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:55:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1D0340201A2;
        Mon,  9 Jul 2018 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 305DC111E406;
        Mon,  9 Jul 2018 13:55:38 +0000 (UTC)
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
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
Date:   Mon, 9 Jul 2018 21:55:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180709092901.GA22182@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 13:55:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 13:55:47 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年07月09日 17:29, Borislav Petkov 写道:
> On Mon, Jul 09, 2018 at 02:28:11PM +0800, lijiang wrote:
>> Last week, I had tried many ways to do this work, but it looks
>> like that the ways of deducing address is not suitable to another
>> scenarios, such as mapping some devices mmio space, which are
>> unencrypted, and the device mmio space is outside kdump kernel like
>> the old memory, but the old memory is encrypted, we can't find the
>> general rules to decide when to encrypt or not.
> 
> If we can't find the "general rules" how is the caller supposed to know
> how to access the memory?
> 
About this issue, i want to use an example to describe it.
/* drivers/iommu/amd_iommu_init.c */
static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
{
        if (!request_mem_region(address, end, "amd_iommu")) {
                pr_err("AMD-Vi: Can not reserve memory region %llx-%llx for mmio\n",
                        address, end);
                pr_err("AMD-Vi: This is a BIOS bug. Please contact your hardware vendor\n");
                return NULL;
        }

        return (u8 __iomem *)ioremap_nocache(address, end);
}

[root@hp-dl385g10-03 linux]# cat /proc/iomem |grep -i crash
  7fa000000-879ffffff : Crash kernel
[root@hp-dl385g10-03 linux]# cat /proc/iomem |grep amd_iommu
  9c800000-9c87ffff : amd_iommu
  a9800000-a987ffff : amd_iommu
  b6800000-b687ffff : amd_iommu
  c3800000-c387ffff : amd_iommu
  d0800000-d087ffff : amd_iommu
  dd800000-dd87ffff : amd_iommu
  ea800000-ea87ffff : amd_iommu
  fd800000-fd87ffff : amd_iommu

Obviously, the iommu mmio space is not encrypted, and the device mmio space is outside kdump
kernel. We know that the old memory is encrypted, and the old memory is also outside kdump
kernel. For the current case, e820__get_entry_type() and walk_iomem_res_desc() can't get the
desired result, so we can't also decide whether encryption or not according to this result(rules).
If we want to know whether encryption or not by deducing the address, we will need to read
the content of memory and have a reference value for comparison, then what's a reference value?
Sometimes we don't know that.

Regards,
Lianbo
