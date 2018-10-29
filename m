Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317BFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4722082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfMMt1b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4722082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJ2XIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:08:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40647 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJ2XIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:08:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so8149679wme.5;
        Mon, 29 Oct 2018 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wm+YO4y2x6I8wcQgWX4Hwp/BhN3mpV5wguc+3y7XATM=;
        b=AfMMt1b6wqny4kSfFiq81kaq4FvAm9K6TAz4esXbCenUCYUO8MmDX+aYcqUvyjTZvi
         CIee6F1f0JA8e2ykSP6F7qAPSFGTdcO6TsfR5U04DdvxxL4L3uJeNEi0E/vBqOPvAPg7
         5EFwZF4xVxF5VRwEq3ryODLrcpQmHqqqsRiZdCI3HA05Scca2YT20Bfus0HeEn/XnLtu
         L8JLUpF5KUuC0sz7bXqmZ3FhUu3QXqzgtMlCtI5GyhT5zSm7YQFCppmX5RjqqoH2GZ9x
         HuNa0SnO5aRStyoQrswZe1kI00Cpa4hKR0j/pdQuSbP1x9/HW76cm6F0aZeOansPfgR6
         r5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wm+YO4y2x6I8wcQgWX4Hwp/BhN3mpV5wguc+3y7XATM=;
        b=PpghIjNfk2VC+3aaxZAMab3IFb5H8R9o458lIh1unGXPFuSVrPmBjoFpTta5klnLF+
         CreMjUxy2g0P0W4ZVH72Hn3VbthtmIwTveNbSk+OWsqZleFUq1RtzQa/XJXf8umKQMW1
         TPJ54C50vj6tFmet09xjSMwFnDA7jOZiPkYtJZpqD4rASZSQ75g9pePfsvTafNRfI7if
         75nXro8fEW25qSU8dYZce5Mkh+5CSmCtCDKHiTa/jn/nZMutFSvFKFHhTb2t5ltG/1cm
         K0bCZkWMvEdeB/w9zs/ZuY6sIKVteuWrzKs8LBJqWTl6EaLVgH/woYAvh2LEcgy3H3TI
         hQvQ==
X-Gm-Message-State: AGRZ1gIMJ9YrvZa4jnDsmzsEVbPiLfQs0UdQ5tJV3/bRHXUGGvnZHncK
        xKyf7p/npSt88hU2EErp9DA=
X-Google-Smtp-Source: AJdET5dLoVDS4WRSIdrb/i/PjlkcF15EZprA4nK0vimHR7GDa+LCuueLm2Hlh8WlxbQ0AwahY5O8Hw==
X-Received: by 2002:a1c:8015:: with SMTP id b21-v6mr7006158wmd.60.1540822752401;
        Mon, 29 Oct 2018 07:19:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b8-v6sm12158099wme.1.2018.10.29.07.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 07:19:11 -0700 (PDT)
Date:   Mon, 29 Oct 2018 15:19:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: fix spelling mistake, EACCESS -> EACCES
Message-ID: <20181029141909.GB104261@gmail.com>
References: <20181026175839.4565-1-colin.king@canonical.com>
 <20181029122854.GB20813@kernel.org>
 <20181029123357.GA21857@kernel.org>
 <20181029123656.GB57235@gmail.com>
 <20181029132001.GD21857@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029132001.GD21857@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Ok, I'll put together a perf/urgent with those things resolved, may take
> a day or two as I'm working on addressing DaveM's reported issues and in
> fixing the regressions that that "remove fallback to kallsyms for
> userspace addresses" patch caused.

Sure thing, no rush!

Thanks,

	Ingo
