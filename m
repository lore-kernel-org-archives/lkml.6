Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE853C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFB120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFB120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeKABf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:35:56 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51325 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeKABf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:35:56 -0400
Received: by mail-wm1-f54.google.com with SMTP id w7-v6so4733210wmc.1;
        Wed, 31 Oct 2018 09:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BGouQSWUxdGCNnACo8L9A+1W7R0WvPoqvQSS0Mb1sDw=;
        b=JKRGTMPppGBbz2i0tSzzsLmcGwVZNX29vtQdHQJp+UF0CorJo4r37BKVSqfF1v1dtp
         aK+R8SqRlq9z8IR6Prr+EnTNnbx4c9zLGW2o+T1XoR1szsAiVx8sRSNkJ4M+PP+A9egn
         MHjphV0n546xUVx7xThzfiN1RXcKNcm22sddTIFNJ+laQZGJCv2jPc6pTbYMw19ippGH
         QbLcE0tkSgviGqov6NIR0cuZosr5QTzqWwrArF+GHvCuAvC7adcMiVTUxKtpwPFi3JAG
         uBn/+Ih5wpMr5FuEXXdLB9YeI364xBtBVtbaptaqp9f5zaHJn/+KPQtKzCCMKdeUtrLI
         QKrA==
X-Gm-Message-State: AGRZ1gJqQFYKyww2Fh7BGCiMUZve4PDAlWYGDlxW72RwONxF/IdDXjII
        o1ohKWkJibwnd+yN/3c13QBz99cw
X-Google-Smtp-Source: AJdET5fc4vwv1LgDybiO3ueH6U/UYCwXXVEpNuODczsHUJxxvEBz3b/eFOASF/EXz6H9nM7UXIhdFA==
X-Received: by 2002:a1c:f514:: with SMTP id t20-v6mr2974007wmh.129.1541003828747;
        Wed, 31 Oct 2018 09:37:08 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id i7-v6sm33000152wmd.41.2018.10.31.09.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 09:37:06 -0700 (PDT)
Subject: Re: remove exofs and the T10 OSD code V2
To:     Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
References: <20181027082019.20838-1-hch@lst.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <c9740eeb-6b96-35b6-a436-7537669da1a9@electrozaur.com>
Date:   Wed, 31 Oct 2018 18:34:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181027082019.20838-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/18 11:20, Christoph Hellwig wrote:
> The only real user of the T10 OSD protocol, the pNFS object layout
> driver never went to the point of having shipping products, and we
> removed it 1.5 years ago.  Exofs is just a simple example without
> real life users.
> 
> The code has been mostly unmaintained for years and is getting in the
> way of block / SCSI changes, so I think it's finally time to drop it.
> 
> Quote from Boaz:
> 
> "As I said then. It is used in Universities for studies and experiments.
> Every once in a while. I get an email with questions and reports.
> 
> But yes feel free to remove the all thing!!
> 

I think I'm changing my mind about this.

Because of two reasons:

One: I see 3 thousands bit-rots in the Kernel and particularly SCSI drivers
that are much older and fat-and-ugliness consuming then the clean osd
stack. For example the all ISA bus and ZONE_DMA stuff.

Two: I have offered many many times, every time this came up. That if
anyone has a major (or even minor) change to the block and/or scsi layers
that he/she has done. And that now breaks the compilation/run time of
OSD or exofs.
  I'm personally willing to spend my weekends and fix it myself. Send me
  a URL of the tree with the work done, and I will send the patches needed
  to revitalize OSD/exofs as part of that change set.

I have never received any such requests to date.

So I would please like to protest on two of Christoph's statements above.

"The code has been mostly unmaintained for years and is getting in the
 way of block / SCSI changes"

1. What does "maintained" means? I have for all these years been immediately
   responsive to any inquiries and patches to the code in question.
   And am listed as MAINTAINER of this code.
2. I have regularly, for ever, every kernel release around the RC3-RC4
   time frame, compiled and ran my almost automatic setup and made sure
   the things still run as expected (No regressions).

So Yes the code has not seen any new fixtures for years. But it is regularly
tested and proven to work, on latest kernel. So it fails the definition 
of a "bit rot"

Christoph you've been saying for so long "getting in the way of block/SCSI
changes". And every time and again this time please tell me, you never answered
before. What are these changes you want to make? can I please help?

Send me any tree where exofs/osd compilation is broken and I will personally
fix it in "ONE WEEK" time.

(If compilation is fine but you know runtime will break, its nice to have an
 heads up, but if not my automatic system will detect it anyway)

Lets say that if in the FUTURE a change-set is submitted that breaks OSD/EXOFS
compilation, and I failed to respond with a fix within "ONE WEEK". Then
this goes in as part of that change-set. And not with the argument of
"Not used, not maintained" - But as "Breaks compilation of the following changes"
I promise I will gladly ACK it then.

So for now. A personal NACK from me on the grounds that. You never told me
why / what this is braking.

Thanks
Boaz

> I guess I can put it up on github. In a public tree.
> 
> Just that I will need to forward port it myself, til now you guys
> been doing this for me ;-)"
> 

