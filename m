Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BB22173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="sXz+0ItS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BB22173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cloudflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbeHNNqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:46:07 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32897 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeHNNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:46:07 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so32833615oip.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 03:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S1/MEc2EWEtzyF5jb4PohyzRqaV0OpMdAfnac0ugAQE=;
        b=sXz+0ItSxAeJJEykDdUUPml0pt59+xP8cw2yblfyjrA/UHVPL9ePDDHdglfNd9la93
         TLfwEdN4+KngydLWC27OuewQmFL94dzCJGKJK5o0po6KexRiqz2Upnmo3jH1sIaYexGi
         b5ppcr8QC1V+8wCmoOfrBTUGIqcaGy8zxfa8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S1/MEc2EWEtzyF5jb4PohyzRqaV0OpMdAfnac0ugAQE=;
        b=Ov9ORalrhBfxHxbeYoDzbIFK13w/AXS3ociDK21fmRVTqCg5+MpWlsH03PIdcPfacH
         Q14trGYJUUikdVnnRR43Qmv3K+gqSqFBf7u1kbYkG7sd+MtH4Ap44TPcLFACnlGLmLyk
         ICn/FuqvT0lUPmxFQM2LbSx8Fi6YBOaEk/oCoYB6SeRCLjLrjG7c/of5uXBorI/u0g+v
         /CCRp3DHAFh/47aWXXe3NYUsy/NRxXSQHOjkgMUDwGA4Q+qSZBT+c8irIR9ggFW9ZjHU
         SEsOnSXjFHAc2k5K2BuQOyUpqrastfAvK3xqBAXtdU0Rerhn694pKHzt+gR2d2QAwcdb
         RzYQ==
X-Gm-Message-State: AOUpUlEUkBPl2+cfgLt1wyIvtQRJhfHWoLxsjHCJzumPfB2sTRcBSj69
        gqPNYj+UbrYpCqYNIqJrAhZILLAqkICf0SAItx02cg==
X-Google-Smtp-Source: AA+uWPx0b9XtXZerd/nXZzmZOdhTkvzEGFheGqwezQHCI/STBjAxxvl2Lc8dSAnty+hANLXVQZhZnzU1GOQslKy8IWQ=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr20714269oih.311.1534244367657;
 Tue, 14 Aug 2018 03:59:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:16b8:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 03:59:27
 -0700 (PDT)
In-Reply-To: <c3907b6a-a7cd-0fda-27fd-9357cf63cfec@iogearbox.net>
References: <CACAyw9-TvamC2HMNv=WDk_aeAM=R7J_BgLiKjevY5+am71W6-A@mail.gmail.com>
 <c3907b6a-a7cd-0fda-27fd-9357cf63cfec@iogearbox.net>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 14 Aug 2018 11:59:27 +0100
Message-ID: <CACAyw99Gn9Zw5-y_vW8VQ+TtHE32cL=zx59wcZ-KfgDcC-iyAQ@mail.gmail.com>
Subject: Re: PROBLEM: Using BPF_PROG_TEST_RUN with data_out != NULL is unsafe
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply.

On 4 April 2018 at 11:01, Daniel Borkmann <daniel@iogearbox.net> wrote:

> In case you point data_in and data_out to the same address, then the total buffer size therefore has to be
> attr.test.data_size_in + 256 in order to not overrun anything while not being
> aware of the BPF test program. The XDP_PACKET_HEADROOM is exposed to user space
> in linux/bpf.h.

Would it be possible to extend the API of BPF_PROG_TEST_RUN to allow
user space to specify the
length of the output buffer? The kernel could then either clamp
output, or return an error.

The current API seems fundamentally hard to use, and unsafe. It leads
to kludges like [1] in a library
I'm maintaining.

1: https://github.com/newtools/ebpf/blob/f4398602ca2a37b99a1f29df9a7e8adcc57be680/prog.go#L200-L204

-- 
Lorenz Bauer  |  Systems Engineer
25 Lavington St., London SE1 0NZ

www.cloudflare.com
