Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84133C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C342075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C342075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIELPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:15:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbeIELPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6343F4023351;
        Wed,  5 Sep 2018 06:47:08 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADAE5B27B4;
        Wed,  5 Sep 2018 06:47:02 +0000 (UTC)
Date:   Wed, 5 Sep 2018 14:46:58 +0800
From:   Dave Young <dyoung@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 2/5 V6] x86/ioremap: strengthen the logic in
 early_memremap_pgprot_adjust() to adjust encryption mask
Message-ID: <20180905064658.GA10310@dhcp-128-65.nay.redhat.com>
References: <20180831081930.31561-1-lijiang@redhat.com>
 <20180831081930.31561-3-lijiang@redhat.com>
 <20180903024512.GA2568@dhcp-128-65.nay.redhat.com>
 <d2229538-51d5-ead7-c7e5-f4afe5b53693@redhat.com>
 <20180904004417.GA9842@dhcp-128-65.nay.redhat.com>
 <20180904012902.GB9842@dhcp-128-65.nay.redhat.com>
 <20180904015131.GA10877@dhcp-128-65.nay.redhat.com>
 <3a9ae246-0c3a-753a-41e2-f2788a882c50@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9ae246-0c3a-753a-41e2-f2788a882c50@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 06:47:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 06:47:08 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> 
> As previously mentioned, there are also many differences between kexec and kdump. In general,
> kexec needs to look at all of available physical memory, but kdump doesn't need.
> 
> For kexec, kexec-tools will read /sys/firmware/memmap and recreate the e820 ranges for the 2nd
> kernel. If it fails, will use /proc/iomem.
> 
> For kdump, kexec-tools will read /proc/iomem and recreate the e820 ranges for kdump kernel.
> BTW: we can not get the range of persistent memory from /proc/iomem. So e820 ranges don't contain
> the persistent memory in kdump kernel, this is the real reason why i need to strengthen the logic
> of adjusting memory encryption mask.

"persistent memory" is different, I think you meant about some reserved
memory instead

> 
> If kexec-tools also use /sys/firmware/memmap for kdump(like kexec), kdump kernel can also work
> without a fix, but the kexec-tools will have to be modified. Are you sure that you want me to
> fix kexec-tools instead of kernel?

Yes, please fix kexec-tools to pass reserved ranges in e820, you will
not need this patch then.

Thanks
Dave
