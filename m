Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BEBC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BB12089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BB12089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeKORXQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:23:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33581 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKORXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 12:23:16 -0500
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gNBtE-0004rl-1E
        for linux-kernel@vger.kernel.org; Thu, 15 Nov 2018 07:16:36 +0000
Received: by mail-pg1-f199.google.com with SMTP id r16so12420769pgr.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 23:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2W7xYbcODO7ltm2wq3cZydoifQHDmmEc2h/HxX/70+A=;
        b=jRtG1N1pCVj+HuU7UKL/xFDpxFYWuCCs8VmYZA06qalcOYYv7zHGf3pKMpiyG1Hzn4
         D96bJFHtKX0TYFttVXEmJ3rcOIuoDnFlo48KEj/qg+0MLbjqI5Dra5Sp0Kx3GIixKxtg
         U2E2H6scqv8Jn/V3qrbfnio04IJT7sKFyrl0/9sLyA9K5li9YqjqPaSYQlOj13fmuPLy
         qMYDLZc+zAnqfJSiBhGc2D5rgkqfHtb+kbbYeGyhV69NO2lYexa5QvEboqfgLwyreLFf
         5IfQ2k1iQBKJuH5InaJfWr1KxLCOvN40x86OtvSSmaRH7AWPIlO24kUs2Fpf+ugnECSI
         JZrg==
X-Gm-Message-State: AGRZ1gKL7IPLpLYbDVfWwfEFWDGs4c83AlIsNFsgAsrbWBeiJLyhQF0T
        wWXvxlsB/LMvTZhqJ9+szOs0oRv3hLOGhNnFdXcuzvQaKVvWuxLS3JfKuvlEyLPSzzaXOvcEZm6
        e9RgzDXMN4u6k8RvPdccnJDjHJTeWCyQiDUlXoPumig==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr4792082pgf.58.1542266194499;
        Wed, 14 Nov 2018 23:16:34 -0800 (PST)
X-Google-Smtp-Source: AJdET5fZhgr3auFnuUaMfiazUNBSd+dXndU9K7QKdnL/0H0IMlSb4jsRoEcJLDYax67Y469H7uNIUQ==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr4792060pgf.58.1542266194107;
        Wed, 14 Nov 2018 23:16:34 -0800 (PST)
Received: from 2001-b011-380f-15ec-3d1a-6b7c-0c8c-d051.dynamic-ip6.hinet.net (2001-b011-380f-15ec-3d1a-6b7c-0c8c-d051.dynamic-ip6.hinet.net. [2001:b011:380f:15ec:3d1a:6b7c:c8c:d051])
        by smtp.gmail.com with ESMTPSA id u13-v6sm23556095pgp.18.2018.11.14.23.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 23:16:33 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20181109002157.GK41183@google.com>
Date:   Thu, 15 Nov 2018 15:16:29 +0800
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com>
References: <20181106071214.12745-1-acelan.kao@canonical.com>
 <20181109002157.GK41183@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Nov 9, 2018, at 08:21, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Tue, Nov 06, 2018 at 03:12:13PM +0800, AceLan Kao wrote:
>> It leads to the power consumption raises to 2.2W during s2idle, while
>> it consumes less than 1W during long idle if put SK hynix nvme to D3
>> and then enter s2idle.
>> From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
>> APST feature to do the power management.
>> To leverage its APST feature during s2idle, we can't disable nvme
>> device while suspending, too.

We have a new Intel NVMe [8086:f1a6] that has this “new” behavior.

> 
> I don't know how APST works, but it sounds like you want to disable D3
> if you're using APST.  But that's not what this patch does; this
> disables it always.

Ok, will work on a new patch that only disables D3 when APST is enabled.

> 
> I'm not sure we want a quirk for this at all, since as Christoph
> points out, it doesn't fix a functional issue as the other uses of
> quirk_no_ata_d3() do.
> 
> From your emails with Christoph, it sounds like this quirk is a
> workaround for a firmware defect.  If we *do* end up wanting a quirk,
> the changelog should at least mention the firmware defect and maybe
> check whether it has been fixed.

According to SK Hynix folks and new evidence on the new Intel NVMe
we have, this is something we are going to see more often.

Kai-Heng

> 
>> BTW, prevent it from entering D3 will increase the power consumtion around
>> 0.13W ~ 0.15W during short/long idle, and the power consumption during
>> s2idle becomes 0.77W.
>> 
>> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>> ---
>> drivers/pci/quirks.c    | 1 +
>> include/linux/pci_ids.h | 2 ++
>> 2 files changed, 3 insertions(+)
>> 
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 4700d24e5d55..b7e6492e8311 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1332,6 +1332,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
>>    occur when mode detecting */
>> DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
>> 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SK_HYNIX, 0x1527, quirk_no_ata_d3);
>> 
>> /*
>>  * This was originally an Alpha-specific thing, but it really fits here.
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 69f0abe1ba1a..5f5adda07de0 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -3090,4 +3090,6 @@
>> 
>> #define PCI_VENDOR_ID_NCUBE		0x10ff
>> 
>> +#define PCI_VENDOR_ID_SK_HYNIX		0x1c5c
>> +
>> #endif /* _LINUX_PCI_IDS_H */
>> -- 
>> 2.17.1
>> 
>> 
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme

