Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B54AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C3F21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T6rvqGMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAWT4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:56:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36628 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAWT4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:56:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so1553014pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 11:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:message-id:cc:from:to;
        bh=LJ25pbB87++OkAXSaku95tGIzIAJeOMtF0CaNNZmGGQ=;
        b=T6rvqGMnlGBV5rFuIGB47rTzaWPxdTdImm/2fq/e/eEuJ/wQGZwyqZcsRrFJWaPhKT
         GeYJAypLaj74UWlD/Nsg62qcf+Jg9seCOEXRYyqeArvWHyzHsSIHJeGMsCUUSllbtcFQ
         d6D36boxvl0Rg3IOTM7vJGsskxZwDiF1xKkh+Ja8/4RGSWFaFkSZHRq3QiYUnEQJLBe6
         Ck5aBnC+i718fM5S0lDiaWsXwBfbwYXf17EKfNc8IlX80jL7c95xap4Ec8aMDvffYN0I
         NOcTSwRL56J7mBeATAHtCBDN5plHbl32DpUIAlbvQ/YAPmHZ3FuZdeYYcuN+jUvwJFkK
         bSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:message-id:cc:from:to;
        bh=LJ25pbB87++OkAXSaku95tGIzIAJeOMtF0CaNNZmGGQ=;
        b=HhAI3JM4Li0e4AuRnAPaAm21cYwl58Df8cFYxEMTSVc73i1kM7eOOWtmjH2Q+7zdWg
         fgT0lbYlxsCXCF5MGDy9xKCvpdn/upQoqGxF2PNqkTRNa/8ZLZSTRcjnCHL5A43tR630
         jy193hFVWBuICq0czBYDoRLP0YKjbY+e4uupnOTIuFQTIvtw5R6TItAP7tDdEDcZmb00
         SETxGRfVs+/oYXFvEiInTHb6TgVTl8jX6AKaWax7ErOOwIAVhBdWN+TZleSCMAAwb2KT
         O5egEFo7u9bj/g22KPMnQeEibbJ+ztzBL2onu5O6fjiYLvLEVB7oA0M+2LccHjctwQIj
         paWQ==
X-Gm-Message-State: AJcUukc7TI6Bo0LfL48I+JJyqCrf5hAPW/GjzpZPKYrWkuHegwBbE4cR
        0XW0XFPHmsnTDKD/OkSAVHAhZw==
X-Google-Smtp-Source: ALg8bN71dKnL3Omroe5ymhsvwIjBN+lGADbEPWZ0qzBttg+gL8l1tnlWJuFwKi2IK+zYkm+C2ThKmw==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr3352108pfe.152.1548273362220;
        Wed, 23 Jan 2019 11:56:02 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c13sm39983597pfe.93.2019.01.23.11.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 11:56:01 -0800 (PST)
Date:   Wed, 23 Jan 2019 11:56:01 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 11:49:25 PST (-0800)
Subject:    Re: [PATCH v4 1/2] sh: mm: make use of new memblocks_present() helper
Message-ID: <mhng-96f28491-e123-459a-b09c-88732de06bbf@palmer-si-x1c4>
CC:     Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        dalias@libc.org, ysato@users.sourceforge.jp,
        linux-kernel@vger.kernel.org, sbates@raithlin.com,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        dan.j.williams@intel.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     logang@deltatee.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 09:30:44 PST (-0800), logang@deltatee.com wrote:
>
>
> On 2019-01-15 6:58 a.m., Christoph Hellwig wrote:
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Probably no need to keep this in a series with the RISC-V code, this can
>> be queued up by the sh folks independently.
>
> Oh, yeah, sorry, I obviously didn't pay enough attention to this when I
> resent it. I sent the similar Arm changes to the appropriate list and,
> yes, the sh ones should go to that maintainer.
>
> @Palmer: if you can just look at taking the second patch, I'll resubmit
> the first one to the appropriate list.

Works for me.  I'll queue the second patch into my staging branch, targeted for
the next merge window.
