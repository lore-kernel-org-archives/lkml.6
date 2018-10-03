Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA801C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB1720878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB1720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJCKou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 06:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeJCKou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 06:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B77F3082128;
        Wed,  3 Oct 2018 03:58:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB60F10001BC;
        Wed,  3 Oct 2018 03:58:03 +0000 (UTC)
Subject: Re: [PATCH v8 RESEND 0/4] Support kdump for AMD secure memory
 encryption(SME)
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
References: <20180930031033.22110-1-lijiang@redhat.com>
 <20181002114012.GB29859@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <43da68b1-fda0-c033-39e1-907d01f13354@redhat.com>
Date:   Wed, 3 Oct 2018 11:57:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002114012.GB29859@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 03 Oct 2018 03:58:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月02日 19:40, Borislav Petkov 写道:
> On Sun, Sep 30, 2018 at 11:10:29AM +0800, Lianbo Jiang wrote:
>> When SME is enabled on AMD machine, it also needs to support kdump. Because
> 
> Ok, I've cleaned them up heavily and pushed them here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git, branch rc6+0-sme-kdump
> 
> However, testing on my zen box doesn't go as planned. And this is even before
> your patches.
> 
> I load the kdump kernel with kexec-tools from the git-repo + the patch you
> mention:
> 
> # ~/bpetkov/bin/sbin/kexec -p /boot/vmlinuz-4.19.0-rc6+ --initrd /boot/initrd-4.19.0-rc6+ --command-line="root=/dev/mapper/ubuntu--010236012132--vg-leap15 splash=silent showopts console=ttyS5,115200 console=tty0 debug ignore_loglevel log_buf_len=16M 1 irqpoll maxcpus=1 reset_devices vga=normal"
> 
> verify that it has been loaded:
> 
> # grep . /sys/kernel/kexec_*
> /sys/kernel/kexec_crash_loaded:1
> /sys/kernel/kexec_crash_size:268435456
> /sys/kernel/kexec_loaded:0
> 
> and then trigger the panic:
> 
> # echo c > /proc/sysrq-trigger
> 
> and I see the panic happening in the serial console but then nothing.
> The box resets instead.
> 
> So something's still broken.
> 

Sorry for my late reply because of a holiday.

I noticed that your test was based on [patch v8 RESEND 4/4], could you please
test it based on [patch v9 4/4]? Because the [patch v8 RESEND 4/4] had a compile
error, and that had been fixed in [patch v9 4/4].

Or i improve patch log and comment in the code for [patch v9 4/4] based on your
comments, and post the series again, also provide my test result about the series. 
Do you think about?

Thanks.
Lianbo

> Trying the kexec -l/kexec -e game works - the second kernel gets kexeced
> properly.
> 
