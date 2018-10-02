Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FDFC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCDB20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCDB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeJBSXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:23:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:53338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbeJBSXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:23:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21C50AEBB;
        Tue,  2 Oct 2018 11:40:12 +0000 (UTC)
Date:   Tue, 2 Oct 2018 13:40:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v8 RESEND 0/4] Support kdump for AMD secure memory
 encryption(SME)
Message-ID: <20181002114012.GB29859@zn.tnic>
References: <20180930031033.22110-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180930031033.22110-1-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 11:10:29AM +0800, Lianbo Jiang wrote:
> When SME is enabled on AMD machine, it also needs to support kdump. Because

Ok, I've cleaned them up heavily and pushed them here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git, branch rc6+0-sme-kdump

However, testing on my zen box doesn't go as planned. And this is even before
your patches.

I load the kdump kernel with kexec-tools from the git-repo + the patch you
mention:

# ~/bpetkov/bin/sbin/kexec -p /boot/vmlinuz-4.19.0-rc6+ --initrd /boot/initrd-4.19.0-rc6+ --command-line="root=/dev/mapper/ubuntu--010236012132--vg-leap15 splash=silent showopts console=ttyS5,115200 console=tty0 debug ignore_loglevel log_buf_len=16M 1 irqpoll maxcpus=1 reset_devices vga=normal"

verify that it has been loaded:

# grep . /sys/kernel/kexec_*
/sys/kernel/kexec_crash_loaded:1
/sys/kernel/kexec_crash_size:268435456
/sys/kernel/kexec_loaded:0

and then trigger the panic:

# echo c > /proc/sysrq-trigger

and I see the panic happening in the serial console but then nothing.
The box resets instead.

So something's still broken.

Trying the kexec -l/kexec -e game works - the second kernel gets kexeced
properly.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
