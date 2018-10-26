Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC200C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75DB2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75DB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJZQxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:53:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46149 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeJZQxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:53:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id a193-v6so139859qkc.13;
        Fri, 26 Oct 2018 01:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YI2b6qELD4rjQUy+r1IhFw3nCwGv9w1RJjFBfLQiPIY=;
        b=Xa+pgyBK09W9PnhCT74KnPH60uCeyM+1VT+VZ+Jm+9f/a5apG7G1lxQDu/Asp93eCF
         9D31SrTHodKvzwjkYdmStv+Fea6ZVLAwpkIjX+3IQ660A1WaNIDojstvPv7QIWfIi5Lx
         jhbjlGEi1cbATxck95ndEZbsLAJiu8k6vrwv8fR3yKZAI/66BRYY6hpEUf+cDRjA5dtV
         8xCCuzSe46HA06K2s6Nrz0uYfpN9V3xpOABcA/pSyIKPjLtQ6sDG42l5X07UoM6LTPk4
         2fR6CY+Tpbv9helJvFiHN5vm1MBGUjDk9jtBRLEBQPeJbLGgx2TaV8O6Qi6CorQF39Bk
         ezWA==
X-Gm-Message-State: AGRZ1gJQNzn/yyUV6ZdFqu2K8AcbWTKzq9TYuZvN/PhGrI1gSNuvpdOo
        ZyW83C9jjcMlEVh/RtqdQ7lL+bSM2mtnWL008Yci0D62
X-Google-Smtp-Source: AJdET5d1nhh9Ucgg6rJibxY6RxUyudjsDi5qs9uRuv4A7ZywPCOTvodTzDKq4p2e7W2uDBmco1L5ZldZ7dVTeB00/WU=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr2115435qki.330.1540541830557;
 Fri, 26 Oct 2018 01:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <1540378751.3008.59.camel@HansenPartnership.com>
In-Reply-To: <1540378751.3008.59.camel@HansenPartnership.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Oct 2018 10:16:54 +0200
Message-ID: <CAK8P3a2R+5kLx=Fo2GTRagAk+4dPP-8GDfH9X7gCtQ7R8=bK_g@mail.gmail.com>
Subject: scsi: myrs: warning fix, was: [GIT PULL] first round of SCSI updates
 for the 4.19+ merge window
To:     James.Bottomley@hansenpartnership.com,
        Hannes Reinecke <hare@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:00 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> James Bottomley (1):
>       scsi: myrs: fix build failure on 32 bit

Hi James and Hannes,

Since James mentioned 32-bit compiles during the kernel summit,
I'd like to confirm that I hit this on my randconfig builder now,
with some latency since the last linux-next tree I tested before
flying to Edinburgh did not have the bug, and the latest
linux-next tree that is available now (dated last Friday) does, and
I see your tree is fixed. During normal times, I should catch these
within a short time of the patch getting into scsi-next.

However, while looking at this bug, I found two more issues related
to the specific computation:

percent_complete = ldev_info->rbld_lba * 100 /  ldev_info->cfg_devsize;

I see that both rbld_lba and cfg_devsize are reported by the
device, but only the former is 64 bit but the latter is 32 bit and
also intended to be the larger of the two. I suspect this is a
bug, and the same is also present in the old DAC960.c.
cfg_devsize is followed by four reserved bytes in the header,
so I suppose it was meant to be 64-bit?
If you divide two 64-bit numbers, you also have to use div_u64_64()
instead of do_div().

On top of that, I see we get those values from the device but
never do any endianess conversion on them. It seems likely
that they are all little-endian and require a le32_to_cpu()
conversion to also work on big-endian kernel builds. Alternatively
we could make the Kconfig symbol as
'depends on !CPU_BIG_ENDIAN || COMPILE_TEST'.

        Arnd
