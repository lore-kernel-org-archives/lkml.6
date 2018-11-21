Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13BFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C474214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSCgqKVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C474214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbeKUXqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:46:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeKUXqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:46:19 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0D1214C4;
        Wed, 21 Nov 2018 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542805919;
        bh=pS5mD4w6EZEqbXDWqED6dE2MsKpQIlvbd5aV0iv8bdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSCgqKVeF6coAm9EG5jrsO1pxB/B8q20xRIjPSh/3IvgjALl1OmRIE/YChWDQPDmC
         Zyl2y+oLufCAiaTQiF5fCNYCjBe0h9YVW+wyYCxLxpytW7IfnytJ86jf8y9p/U+OKq
         ksGOPOalttNw8nDCk6vJ4tI7xQYhnECABY27svzg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 033501443D6; Wed, 21 Nov 2018 10:11:56 -0300 (-03)
Date:   Wed, 21 Nov 2018 10:11:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wang Nan <wangnan0@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: perf tools: remove option --tail-synthesize ?
Message-ID: <20181121131156.GG6248@kernel.org>
References: <89AC26A9-5A18-4608-8889-9C3C9C1C69D3@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89AC26A9-5A18-4608-8889-9C3C9C1C69D3@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 21, 2018 at 07:45:28AM +0000, Song Liu escreveu:
> Hi,
> 
> I found perf-record --tail-synthesize without --overwrite breaks symbols
> for perf-script, perf-report, etc. For example:
> 
> [root@]# ~/perf record -ag --tail-synthesize -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.129 MB perf.data (3531 samples) ]
> [root@]# ~/perf script | head
> swapper     0 [000] 1250675.051971:          1 cycles:ppp:
>         ffffffff81009e15 [unknown] ([unknown])
>         ffffffff81196b19 [unknown] ([unknown])
>         ffffffff81196579 [unknown] ([unknown])
>         ffffffff81110ca7 [unknown] ([unknown])
>         ffffffff81a01f4a [unknown] ([unknown])
>         ffffffff81a017bf [unknown] ([unknown])
>         ffffffff8180e17a [unknown] ([unknown])
> 
> perf-record with --overwrite does NOT have this issue.
> 
> After digging into this, I found this issue is introduced by commit
> a73e24d240bc136619d382b1268f34d75c9d25ce.
> 
> Reverting this commit does fix this issue. However, on a second thought,
> I feel it is probably better just drop --tail-synthesize, as it doesn't
> make much sense without --overwrite. All we need is to do tail_synthesize
> when --overwrite is set.
> 
> Thoughts?

Wang, wdyt?

- Arnaldo
