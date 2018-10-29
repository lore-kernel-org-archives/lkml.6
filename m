Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CF2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E192082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KplcaCOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E192082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeJ3C3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeJ3C3y (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:29:54 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A947A2082D;
        Mon, 29 Oct 2018 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540834817;
        bh=5Gk4TWeIstkbQbvCjVdBzGY3LMGB3js6Pqpg3WIVaSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KplcaCOE6HNbiCgklwWRoIulQSiM8sEJ0CAj7k/p2cP++hwTtvY6YMBQPVcePCipV
         7sl5mSEvVT0IjYh39iuh0IDBCePOZSkmL/ybf7ifht3uV9l3HaKiHy1cT6X4RsYkOg
         MxmrgTLxiJOjnoqRMfknVSd4KASSx4z5WHcO+4kE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 366D5142C5F; Mon, 29 Oct 2018 14:40:14 -0300 (-03)
Date:   Mon, 29 Oct 2018 14:40:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     jolsa@kernel.org, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf util: take pgoff into account when reporting elf to
 libdwfl
Message-ID: <20181029174014.GG21857@kernel.org>
References: <20181029141644.3907-1-milian.wolff@kdab.com>
 <3361238.noN1Jb7VD2@milian-kdab2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3361238.noN1Jb7VD2@milian-kdab2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 29, 2018 at 04:26:27PM +0100, Milian Wolff escreveu:
> On Monday, October 29, 2018 3:16:44 PM CET Milian Wolff wrote:
> > Libdwfl parses an ELF file itself and creates mappings for the
> > individual sections. Perf on the other hand sees raw mmap events which
> > represent individual sections. When we encounter an address pointing
> > into a mapping with pgoff != 0, we must take that into account and
> > report the file at the non-offset base address.
> > 
> > This fixes unwinding with libdwfl in some cases. E.g. for a file like:
> 
> <snip>
> 
> > Note that the backtrace is still stopping too early, when
> > compared to the nice results obtained via libunwind. It's
> > unclear so far what the reason for that is.
> 
> The remaining issue is due to a bug in elfutils:
> 
> https://sourceware.org/ml/elfutils-devel/2018-q4/msg00089.html
> 
> With both patches applied, libunwind and elfutils produce the same output for 
> the above scenario.

I'm updating the patch to remove:

"It's unclear so far what the reason for that is."

Adding:

"See https://sourceware.org/ml/elfutils-devel/2018-q4/msg00089.html for
a patch fixing that."

Ok? Or are you saying that that "unclear" part applies to both libunwind
and elfutils?

- Arnaldo
