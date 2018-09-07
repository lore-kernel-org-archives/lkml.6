Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FE0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286C020645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0SUTw9D9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286C020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIHBLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeIHBLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:11:52 -0400
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com [209.85.216.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8B220879;
        Fri,  7 Sep 2018 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536352156;
        bh=qaTN1sLAoeF2hUo9r8Pc8zfcetm74aPR5ccLPi03ij0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0SUTw9D9BeFNMT5o0w5IOq9Qq4GPH8asGBAGCSdLD+82/wgI21oSiel29VgRO7o9r
         TFsXjXPpeSVNZrPUwwtffzR4uEBF6N0e3nhzggKjy3fb8AcNX6hRW8HnqH2TTyaKpG
         TuG9BaZggjEc1PCQ62qDD99KtyTZXb6C7kT18FJg=
Received: by mail-qt0-f181.google.com with SMTP id g44-v6so17556776qtb.12;
        Fri, 07 Sep 2018 13:29:15 -0700 (PDT)
X-Gm-Message-State: APzg51BB2CPqYNI69FvNjicNMdBlrAAc8hgHBvBCJbP8zHVCcNwv0c7R
        CZP/MB1I9OECtTcNQ4zAt9BUh2AaSbas2M5Qbw==
X-Google-Smtp-Source: ANB0Vdab3hT61u1M8M/lHOL0mWGQ/USdGai/hWOrTMd+yeGvnL96ZvpFeSxppjPt10TdKLI1ogg9PQzqaJMzE9dHMxc=
X-Received: by 2002:a0c:db87:: with SMTP id m7-v6mr7110948qvk.90.1536352155200;
 Fri, 07 Sep 2018 13:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180907185414.2630-1-paul.burton@mips.com>
In-Reply-To: <20180907185414.2630-1-paul.burton@mips.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 7 Sep 2018 15:29:03 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com>
Message-ID: <CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] of/fdt: Allow architectures to override
 CONFIG_CMDLINE logic
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 1:55 PM Paul Burton <paul.burton@mips.com> wrote:
>
> The CONFIG_CMDLINE-related logic in early_init_dt_scan_chosen() falls
> back to copying CONFIG_CMDLINE into boot_command_line/data if the DT has
> a /chosen node but that node has no bootargs property or a bootargs
> property of length zero.

The Risc-V guys found a similar issue if chosen is missing[1]. I
started a patch[2] to address that, but then looking at the different
arches wasn't sure if I'd break something. I don't recall for sure,
but it may have been MIPS that worried me.

> This is problematic for the MIPS architecture because we support
> concatenating arguments from either the DT or the bootloader with those
> from CONFIG_CMDLINE, but the behaviour of early_init_dt_scan_chosen()
> gives us no way of knowing whether boot_command_line contains arguments
> from DT or already contains CONFIG_CMDLINE. This can lead to us
> concatenating CONFIG_CMDLINE with itself, duplicating command line
> arguments which can be problematic (eg. for earlycon which will attempt
> to register the same console twice & warn about it).

If CONFIG_CMDLINE_EXTEND is set, you know it contains CONFIG_CMDLINE.
But I guess part of the problem is MIPS using its own kconfig options.

> Move the CONFIG_CMDLINE-related logic to a weak function that
> architectures can provide their own version of, such that we continue to
> use the existing logic for architectures where it's suitable but also
> allow MIPS to override this behaviour such that the architecture code
> knows when CONFIG_CMDLINE is used.

More arch specific functions is not what I want. Really, all the
cmdline manipulating logic doesn't belong in DT code, but it shouldn't
be in the arch specific code either IMO. Really it should be some
common kernel function which calls into the DT code to retrieve the DT
bootargs and that's it. Then you can skip calling that kernel function
if you really need non-standard handling.

Perhaps you should consider filling DT bootargs with the cmdline from
bootloader. IOW, make the legacy case look like the non-legacy case
early, and then the kernel doesn't have to deal with both cases later
on.

Rob

[1] https://lkml.org/lkml/2018/3/14/701
[2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/cmdline
