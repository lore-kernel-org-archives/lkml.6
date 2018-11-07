Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563832081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563832081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeKGTFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:05:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeKGTFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:05:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32489A4055;
        Wed,  7 Nov 2018 09:35:48 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-74.pek2.redhat.com [10.72.12.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FC031711B;
        Wed,  7 Nov 2018 09:35:44 +0000 (UTC)
Date:   Wed, 7 Nov 2018 17:35:40 +0800
From:   Dave Young <dyoung@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org
Subject: Re: [PATCH 2/2 v5] x86/kexec_file: add reserved e820 ranges to kdump
 kernel e820 table
Message-ID: <20181107093540.GA8521@dhcp-128-65.nay.redhat.com>
References: <20181107050019.6663-1-lijiang@redhat.com>
 <20181107050019.6663-3-lijiang@redhat.com>
 <20181107052345.GQ27491@MiWiFi-R3L-srv>
 <cc579d02-19e9-8749-ea48-3ff0fbf6461d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc579d02-19e9-8749-ea48-3ff0fbf6461d@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 07 Nov 2018 09:35:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/18 at 05:10pm, lijiang wrote:
> 在 2018年11月07日 13:23, Baoquan He 写道:
> > On 11/07/18 at 01:00pm, Lianbo Jiang wrote:
> >> E820 reserved ranges is useful in kdump kernel, it has been added in
> >> kexec-tools code.
> >>
> >> One reason is PCI mmconf (extended mode) requires reserved region otherwise
> >> it falls back to legacy mode, and also outputs the following kernel log.
> > 
> > OK, it falls back to legacy mode, and also output kernel log, except of
> > these, does it crash kernel? kdump kernel hang? Can we leave it if it
> > only ouptut kernel log?
> > 
> >>
> >> Example:
> >> ......
> >> [   19.798354] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> >> [   19.800653] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> >> [   19.800995] PCI: not using MMCONFIG
> >> ......
> >>
> >> The correct kernel log is like this:
> >> ......
> >> [    0.082649] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> >> [    0.083610] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
> >> ......
> >>
> >> Furthermore, when AMD SME kdump support, it needs to map dmi table area
> >> as decrypted. For normal boot, these ranges sit in e820 reserved ranges,
> >> thus the early ioremap code naturally map them as decrypted. If it also
> >> has same e820 reserve setup in kdump kernel then it will just work like
> >> normal kernel.
> > 
> > Why do we care? If don't fix, what's happening?
> > 
> > Lianbo, for a bug fix, please describe the problems. Then give out the
> > analysis about root cause. 
> > 
> 
> Thanks for your comment in detail.
> 
> In fact, these patches are really simple. As the subject mentioned, this patch
> [PATCH 2/2] adds the reserved e820 ranges to kdump kernel e820 table, and the
> first patch [PATCH 1/2] helps to exactly add the e820(E820_TYPE_RESERVED) type
> to kdump kernel e820 table, that is to say, it will filter out some unnecessary
> type(E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE_RESERVED_KERN).
> 
> At present, when we use the kexec to load the kernel image and initramfs(for
> example: kexec -s -p xxxx), the latest kernel does not pass the e820 reserved
> ranges to the second kernel, which might produce two problems:
> 
> The first one is the MMCONFIG issue, although which does not make the system
> crash or hang, this issue is still a potential risk, because my test can't
> cover all cases due to resource constraints(Machine), and i'm not sure what
> it will happen on other machine.

If a device is plugged in pci domain 1 then this device can not be
recognized in kdump kernel in your case.  For example if one want to
dump to a network target, but the net card can not be recognized then
vmcore can not be saved successfully

Thanks
Dave
