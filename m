Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B19ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852FC2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852FC2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeGRXNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:13:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbeGRXNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:13:30 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F51886D;
        Wed, 18 Jul 2018 22:33:27 +0000 (UTC)
Date:   Wed, 18 Jul 2018 15:33:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de,
        andy.shevchenko@gmail.com, patrik.r.jakobsson@gmail.com,
        airlied@linux.ie, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, dmitry.torokhov@gmail.com,
        frowand.list@gmail.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, tglx@linutronix.de, brijesh.singh@amd.com,
        jglisse@redhat.com, thomas.lendacky@amd.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, devel@linuxdriverproject.org,
        linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
        yinghai@kernel.org, monstr@monstr.eu, davem@davemloft.net,
        chris@zankel.net, jcmvbkbc@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v7 4/4] kexec_file: Load kernel at top of system RAM if
 required
Message-Id: <20180718153326.b795e9ea7835432a56cd7011@linux-foundation.org>
In-Reply-To: <20180718024944.577-5-bhe@redhat.com>
References: <20180718024944.577-1-bhe@redhat.com>
        <20180718024944.577-5-bhe@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 10:49:44 +0800 Baoquan He <bhe@redhat.com> wrote:

> For kexec_file loading, if kexec_buf.top_down is 'true', the memory which
> is used to load kernel/initrd/purgatory is supposed to be allocated from
> top to down. This is what we have been doing all along in the old kexec
> loading interface and the kexec loading is still default setting in some
> distributions. However, the current kexec_file loading interface doesn't
> do like this. The function arch_kexec_walk_mem() it calls ignores checking
> kexec_buf.top_down, but calls walk_system_ram_res() directly to go through
> all resources of System RAM from bottom to up, to try to find memory region
> which can contain the specific kexec buffer, then call locate_mem_hole_callback()
> to allocate memory in that found memory region from top to down. This brings
> confusion especially when KASLR is widely supported , users have to make clear
> why kexec/kdump kernel loading position is different between these two
> interfaces in order to exclude unnecessary noises. Hence these two interfaces
> need be unified on behaviour.

As far as I can tell, the above is the whole reason for the patchset,
yes?  To avoid confusing users.

Is that sufficient?  Can we instead simplify their lives by providing
better documentation or informative printks or better Kconfig text,
etc?

And who *are* the people who are performing this configuration?  Random
system administrators?  Linux distro engineers?  If the latter then
they presumably aren't easily confused!

In other words, I'm trying to understand how much benefit this patchset
will provide to our users as a whole.

