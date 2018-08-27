Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372F0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CC2208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrJlO+Mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CC2208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeH0U3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeH0U3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:29:54 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A01A208D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535388154;
        bh=EkW0hiQZ5OKFev0lmyzLBkIAsN5gVSdA2fFIZnIfSR0=;
        h=From:Date:Subject:To:From;
        b=WrJlO+Mb4Rv0Gs5Drb2SJ6IvRpe3H6HFcqCa5y1O1XNKdajACzYOHMOY2+JTLxuBk
         4WnuBwG3T+6LITWgh5N+l+us4m/Tld5lGsIQSBIVYXh3os9edTGp7NNKe3KlXh8A23
         0pSid+9qfUwckpARTig2Fxkn2bp+XAFVlBJaxNG0=
Received: by mail-wm0-f53.google.com with SMTP id y139-v6so8663614wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 09:42:34 -0700 (PDT)
X-Gm-Message-State: APzg51BM3MPnmek9R2HuYxiias2bZV7J62ngYXxQCO8uM+nC2qGzIMO9
        7ShKClboLkzhuDBwuCSY0iDvCdSvwfjtiisAoxHgdw==
X-Google-Smtp-Source: ANB0VdbmQ+t/AHY8b51NjSuozOvQ5me8lRz9MVFoy3+EUTbZalki+Do+Z+wu0FJMVilgtChWlKx0MzhVXZgV1LuROdU=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr5798285wmd.144.1535388152587;
 Mon, 27 Aug 2018 09:42:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 09:42:12 -0700 (PDT)
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Aug 2018 09:42:12 -0700
X-Gmail-Original-Message-ID: <CALCETrWqg82HxGEa6Locag=M6ytgOamvRyG96dT+Hqm2QwZ3pg@mail.gmail.com>
Message-ID: <CALCETrWqg82HxGEa6Locag=M6ytgOamvRyG96dT+Hqm2QwZ3pg@mail.gmail.com>
Subject: Removing entry trampoline and associated reversions
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

We had an unfortunate conflict.  Adrian did all the plumbing to get
entry_trampoline to play nicelyh with kcore and perf.  Meanwhile, I
was working on getting rid of the entry trampoline.  Adrian's code is
merged and mine is finally in good shape, and there's an obvious
conflict.

So I did a bunch of reverts, all but one of which were clean.  The
series is here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/pti

and the messy revert is here:
