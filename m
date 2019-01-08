Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AC8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B120883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tbpmaNXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfAHU3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:29:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAHU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0rIiIIOb/sO6sVpZv2phZOg6LzeV/mUb8vKJncWZBmM=; b=tbpmaNXzp2r5ZzyFTzkY3zhTa
        0mtMujIsrR3hwMOjD8o5Nwg0AynYx4ZoOZgjPEI2rP8TkBQBxahDR616D4s7Im0Xv3NqdUBCMnzAR
        g1deFVb/cM4QyGwiYQFVdpQRL6l67omYHojrDyJ8VXV8POXNpYkJv2PP9MVvNCg0cd7+5v/mXIwqP
        NXjvtZCJjtwMYvR8A9lJ5XLphzwctZZxuk30aOb0jWEMN1IsvCF+hWfjYURutw5xsyI6OvQMS+0XA
        CDQqZfOnJftpTPNosreGJNpCgqKmNGZoirt2J/auT2exahsbTzH60xYdWsCtYCOc5fnxLuPG7WkBT
        53hYDmq1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggxzx-0000QY-4v; Tue, 08 Jan 2019 20:29:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35C8820274B53; Tue,  8 Jan 2019 21:29:15 +0100 (CET)
Date:   Tue, 8 Jan 2019 21:29:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20190108202915.GE30894@hirez.programming.kicks-ass.net>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220182904.4193196-4-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
> The following example shows kernel symbols for a BPF program with 7
> sub programs:
> 
>     ffffffffa0257cf9 t bpf_prog_b07ccb89267cf242_F
>     ffffffffa02592e1 t bpf_prog_2dcecc18072623fc_F
>     ffffffffa025b0e9 t bpf_prog_bb7a405ebaec5d5c_F
>     ffffffffa025dd2c t bpf_prog_a7540d4a39ec1fc7_F
>     ffffffffa025fcca t bpf_prog_05762d4ade0e3737_F
>     ffffffffa026108f t bpf_prog_db4bd11e35df90d4_F
>     ffffffffa0263f00 t bpf_prog_89d64e4abf0f0126_F
>     ffffffffa0257cf9 t bpf_prog_ae31629322c4b018__dummy_tracepoi

We should probably specify somewhere that the name can include a
'[module]' part just like normal kallsyms. Even though you don't
currently use that.
