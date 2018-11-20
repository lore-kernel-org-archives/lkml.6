Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A085BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689B520870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jcHbIDVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689B520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeKTLO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:14:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35049 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbeKTLO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:14:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id v1-v6so108298plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gyn6gFow0MKRF0ysKpduDTR/xiD6n6UxxkLJuvi/WtU=;
        b=jcHbIDVyMH5/sM17UChOWiyCYGg9fqrKV3+Syqz13xN5NHwzJqLmCPCCm1QaPt5Gx2
         Lzx8S0bAbR2yJKfgOQb8adRUd3lnS2ZdzL7X+AXsD5MRAi1wiB0EIYpUZPfZ1Pqo8v0Z
         N4dqEjHE04i9/qEizB2NbEE77BDkxpXwsEWPqCdO1bYBkg7EwSelN+stgHX7CeOeZwOI
         VF61S5Jk7vKM1UCDAv3px3oWOeXUXkhvmQxEIwsBHgGqSC89O2pq3I31VO8ha7DBbsQ1
         SRkZEBTywtzHeCcnf42ka74mbYbv1RrzB+6RVYX/B5DO5ME+Hf9j98q7JJ/JXGpNoS6q
         FSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gyn6gFow0MKRF0ysKpduDTR/xiD6n6UxxkLJuvi/WtU=;
        b=AsfqBWItxPadMcvOhh8RgGwFRR88LIvJlq/sczevMuHkFQHeQNn2fTxUENTnUaEPzw
         fYR2/3sec0hwam2IZgjN78HGYXlYoxt8pcM4ziM0aISkQXiNkK1Sd6m2+zXx7BnFQNcI
         tyskBQbmRlkx57bmWiJR1gdpA8c+yYoI38APhH1LXlMnf1UqWuZaof+gIl5/R7vTab2G
         RcCJTGYuo3zA3janCOi2hYRFu4XiY7O4OZG99i1em1uIZQJSLtHvsxy4gVMJWk9HZv0r
         UyJ2fzqZWUX9nDxsKISIdWUoO06gaCdgozlkNCYyMkhRzfyfsYOqYK2I8O9H2bGYmP7z
         Q1jA==
X-Gm-Message-State: AA+aEWaNhrf91Yn0rm+8fg48UA9AOSneLUpJuHPv700qvL99qCYsGY6i
        YmRhrRcEKk3bwDMK/6Wh0xk4Yg==
X-Google-Smtp-Source: AFSGD/UXAP8NEve4cbqy8GP2/ttTy9OfV22j07VMLGvrP06QQe0OH+hpmgegtTOmYWq5skEIjr5dkw==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60mr4738641plc.211.1542674883440;
        Mon, 19 Nov 2018 16:48:03 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y29sm48936484pga.59.2018.11.19.16.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:48:02 -0800 (PST)
Date:   Mon, 19 Nov 2018 16:48:02 -0800 (PST)
X-Google-Original-Date: Mon, 19 Nov 2018 15:54:02 PST (-0800)
Subject:     Re: [PATCH 2/2] arch: switch the default on ARCH_HAS_SG_CHAIN
In-Reply-To: <20181119135852.GA16428@lst.de>
CC:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-bc691596-d40e-4dd5-b162-b767e550b92e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 05:58:52 PST (-0800), Christoph Hellwig wrote:
> On Fri, Nov 16, 2018 at 08:52:14AM -0800, Palmer Dabbelt wrote:
>> As far as I can tell, it looks like m68k, mips, and powerpc mention an
>> IOMMU in their ports, don't set ARCH_HAS_SG_CHAIN, and with this patch set
>> won't set ARCH_NO_SG_CHAIN.
>
> m68k has no iommu, and not operations that operate on a scatterlist.
>
> mips has a trivial iommu driver (jazzdma), but I wrote the current
> instance of it, nad it is fine.
>
> powerpc has various iommu, but actually enables ARCH_HAS_SG_CHAIN
> unconditionally.
>
>> The issue is that I'm not sure how to
>> determine what constitutes a horrible legacy IOMMU, at least with respect
>> to not being able to use scatterlist chaining.
>
> It basically means someone is iterating using manual pointer arithmetics
> over a multi-element scatterlist instead of using the sg_next and
> for_each_sg helpers.

Ah, OK.  In that case, feel free to drop a

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

in there, if you think it helps any.

Thanks for the help!
