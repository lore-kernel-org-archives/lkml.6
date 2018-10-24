Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDBAC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 05:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877C3206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 05:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHam001B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877C3206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJXOUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:20:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51404 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXOUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:20:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so3951437wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 22:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8AYhBPynFCUOh6QKNUizhXb9/o/UCNU5+Ge+DkLqccA=;
        b=NHam001Bw+nAC4hm7JDAw6m3hMiW2g4sR/wp3LYFid/RJrk/i4dUafWlywq+j6+2PM
         YO3msFwevFZMOCs2IbGP9mrESsiKDlMrZh+jnJPKokMYazjDFNNhrpSiooDhpdJUlhZs
         bslpifL8IL+w5MHWgbr0U18EWrcHVqX78JPWX5ZuqFZjlqYtlnxTBDv5ZQi7s134nGE0
         8h72CmkCis8UssgN+xGH51gxqt50V2YT88r/Y8pczRGT485DpMjYfUYjPFsuQ4SmRwr7
         QSmslu7ipEg/59UIEn/eEcp5/QFZd86bpbtADwV5gMBbJyV1zfJWay2G6wm+H9QiTC0Q
         +bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8AYhBPynFCUOh6QKNUizhXb9/o/UCNU5+Ge+DkLqccA=;
        b=rnMWZhf9pAse21FdV1kqw3k4TcnHpmErQV6L3oOnjmR8SyqsJ2Yx2Ng2laF74bhchw
         9Cuk4FSyUYSKAxK+iiMSZk9FJXevB6FmGIycP6qZtAm+t9YkErAfqOyI5qGlQLfSet3V
         deQq+WxIjRKjkn1c9WV/IZ83kowGtWZz7BgKeYHq//3nNIV8m6GE1U9XwOXK20I+n2dJ
         3PCNao3KtuW9oTt61XQ6fs9W6YVc2n833qN/e9fP6/uSk0e4FelBEMRtUZz/3PugXCV4
         gUIVQaTbBdqmJGpsZAZ7KQjBqW+wJj9LEXit+EinZPamKaGeYEk01pbIG9O2+mrZYBmc
         f0Tg==
X-Gm-Message-State: AGRZ1gLA14dm2Qp1C8cpArD6jhNzAxC90YlADJTd++CDHdzoTS17EvuM
        02/u3ldNyt3W0pJQhcAgQOE=
X-Google-Smtp-Source: AJdET5evqsbTB8nXrt9eLZ+D/WLV/SIn9Rx9bRNexDwbSDBhN1spF1O5bQBMFTWIAYGoGjoCAnyQ3w==
X-Received: by 2002:a1c:3702:: with SMTP id e2-v6mr991535wma.89.1540360402879;
        Tue, 23 Oct 2018 22:53:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i13-v6sm3610651wrn.62.2018.10.23.22.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 22:53:22 -0700 (PDT)
Date:   Wed, 24 Oct 2018 07:53:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel-team@fb.com, songliubraving@fb.com, will.deacon@arm.com,
        hpa@zytor.com, luto@kernel.org, npiggin@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/7] x86/mm/tlb: make lazy TLB mode even lazier
Message-ID: <20181024055319.GA73309@gmail.com>
References: <20180924183759.23955-1-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924183759.23955-1-riel@surriel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@surriel.com> wrote:

> The big thing remaining is the reference count overhead of
> the lazy TLB mm_struct, but getting rid of that is rather a
> lot of code for a small performance gain. Not quite what
> Linus asked for :)

BTW., what would be the plan to improve scalability there,
is it even possible?

Also, it would be nice to integrate some of those workloads
into a simple 'perf bench mm' or 'perf bench tlb' subcommand,
see tools/perf/bench/ on how to add benchmarking modules.

Thanks,

	Ingo
