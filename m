Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951CBC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B1820835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B1820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJLGxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:53:17 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:44737 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbeJLGxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:53:17 -0400
Received: from [192.168.0.3] (ip5f5bf16c.dynamic.kabel-deutschland.de [95.91.241.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 207302012D0DC1;
        Fri, 12 Oct 2018 01:23:44 +0200 (CEST)
Subject: Re: [PATCH] x86/mm: Do not warn about PCI BIOS W+X mappings
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <b1231b76-fd35-4304-8003-b2dccee1ba0d@molgen.mpg.de>
Date:   Fri, 12 Oct 2018 01:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thomas,


Am 08.10.2018 um 21:53 schrieb Thomas Gleixner:
> PCI BIOS requires the BIOS area 0x0A0000-0x0FFFFFF to be mapped W+X for
> various legacy reasons. When CONFIG_DEBUG_WX is enabled, this triggers the
> WX warning, but this is misleading because the mapping is required and is
> not a result of an accidental oversight.
> 
> Prevent the full warning when PCI BIOS is enabled and the detected WX
> mapping is in the BIOS area. Just emit a pr_warn() which denotes the
> fact. This is partially duplicating the info which the PCI BIOS code emits
> when it maps the area as executable, but that info is not in the context of
> the WX checking output.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   arch/x86/mm/dump_pagetables.c |   35 +++++++++++++++++++++++++++--------
>   1 file changed, 27 insertions(+), 8 deletions(-)

Thank you for the patch. I tested it on the ASRock E350M1 with coreboot 
and the SeaBIOS payload, and the insecure warning is gone.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>

Should this be tagged for the stable series?


Kind regards,

Paul
