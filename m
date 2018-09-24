Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C65ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648DD21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648DD21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbeIXTJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:09:37 -0400
Received: from thoth.sbs.de ([192.35.17.2]:51317 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbeIXTJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:09:37 -0400
X-Greylist: delayed 691 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Sep 2018 15:09:34 EDT
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w8OCu0aB030865
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 14:56:00 +0200
Received: from [167.87.12.89] ([167.87.12.89])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w8OCtxeg002243;
        Mon, 24 Sep 2018 14:55:59 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Jailhouse 0.10 released
To:     Jailhouse <jailhouse-dev@googlegroups.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mozilla-News-Host: news://news://news://blaine.gmane.org
Message-ID: <6b9ac0eb-653c-1d24-9126-6d138ed2edfd@siemens.com>
Date:   Mon, 24 Sep 2018 14:55:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O'zapft is, so better release before going to the Wiesn: We are happy to 
announce a new version of the partitioning hypervisor Jailhouse.

There is a similar amount of changes again, though some are more fundamental, 
namely the changes around per-cpu page tables: 174 commits, 248 files changed, 
4013 insertions, 8548 deletions. The code reduction is primarily related to the 
removal of the vexpress target from CI as well as internal code reuse in the 
Python tool extension.

- Removed targets:
    - VExpress (virtual ARMv7 target)
- Cross-arch changes:
    - use per-cpu page tables to hide private information of other cells
      while running in the hypervisor (AKA generic and fast Spectre/L1TF
      mitigation)
    - support for EFI framebuffer as UART alternative
    - removal of VGA support (substituted by EFI framebuffer)
    - provide pyjailhouse module, so far as internal Python API to
      Jailhouse functionality (will be extended step-wise to public API)
    - "jailhouse hardware check" no longer requires a system config
    - inmates: convert all build-time configurations into cell configs
      and runtime parameters (AKA comm region also for ARM)
    - plug race between guest-controlled relocation of intercepted MMIO
      regions and their access
    - fix split-up of hughpages a higher addresses
    - fix write to MSI-X registers during PCI device hand-over
- ARM / ARM64:
    - basic SMCCC moderation
    - fix GICv3 registers dispatching
    - support for more than 8 CPUs with GICv3
    - fix unreliable startup on ARM64 due to missing cache flush
    - fix for printk() of long long variables
    - proper GICv2 shutdown after setup error
    - inmates: save/restore registers in interrupt handlers
- x86:
    - harden non-present mappings against L1TF
    - CPU startup fix for slower targets
    - do no trap on writes to read-only APIC LVT bits
    - inmates: report SMI counter changes in apic-demo

You can download the new release from

     https://github.com/siemens/jailhouse/archive/v0.10.tar.gz

then follow the README.md for first steps on recommended evaluation
platforms and check the tutorial session from ELC-E 2016 [1][2]. To try
out Jailhouse in a virtual environment or on a few reference boards,
there is an image generator available [3]. It will soon be updated to
the new release as well. Drop us a note on the mailing list if you run
into trouble.

What's (probably) next? First of all, we are looking forward to a couple of 
IOMMU implementations for ARM64 targets. Still on my to-do list is enabling of 
the Ultra96 board that Xilinx kindly provided (primarily a jailhouse-images 
topic, but all preconditions are finally fulfilled). And the topic of inter-cell 
communication standardization is also not forgotten. The plan is now virtio over 
share memory transports, "just" needs a prototype and virtio spec extension 
proposals.

Thanks to all the contributors and supporters!

Jan

[1] 
https://events.linuxfoundation.org/sites/events/files/slides/ELCE2016-Jailhouse-Tutorial.pdf
[2] https://youtu.be/7fiJbwmhnRw?list=PLbzoR-pLrL6pRFP6SOywVJWdEHlmQE51q
[3] https://github.com/siemens/jailhouse-images

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
