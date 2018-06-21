Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979582151B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkUaQyWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979582151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeFUQL3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:11:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35225 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFUQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:11:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id l8-v6so3804162wrr.2;
        Thu, 21 Jun 2018 09:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+54n0k7sEulwq3QZLnsCVyStIJliGZUVt+1mCsU/M8g=;
        b=AkUaQyWEaUBzJgKTiKat8/m8lfzRW6KMPcCP/pcHNF3B4wQH3kbHZ8iJQYYxpMkiex
         nR6wKzLROToQieLyqAHkmE+PKMmyXc8YF6vNgl0B99/S0sRx6cnKmO8GmMRYSyKzuvDa
         SmRjZCVwdK4C/MVCoVJ2MA7zPQgwiDfSFMaQyurukp1wVM1KKGVYJV2OvZxFRQB8fwew
         71Em2zRSsIyL0QmwO1DM2nYLfCdU5tSEOAQMVl6QM13B90MdmU5eMRJcOGGqBJI+vOgX
         1muQVqMhz8O3xOyw01d+RkTMSxLghSNMzbfA6WbsTQNsmhGcK09omYVZUEq/HC2wLWoZ
         7PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+54n0k7sEulwq3QZLnsCVyStIJliGZUVt+1mCsU/M8g=;
        b=Oonw53ytEKp+BFZESVFJb0ZpQEMRbtulQmw4/KVh2p0LEoC3NAsYoR8NGcRvxXg86n
         Gm4TQ44xyWdj1q4rWSy2T62JUUWneOoT++PXmbrEf6XbcD1P5CU0577H8vEbPXMb/sXG
         9hrFgvpuVssN3SFFzOFoc6OPopvLAalVPAGShAaiIdEyR/Cq4YO8L843lPHTrALNkT9/
         vhQp0ghEykDekwerPDsNR62wDsEPehQB8QFnk933b9HbzbZP/fxJs19e2UAfo63Dm78/
         Yp8iJEVQU4fk2W1YFFpjxNzN5Nb2C1OaO0Qjcvm1e845YLgrrGJIYu0S2hixOM8ZW4CG
         fHxA==
X-Gm-Message-State: APt69E1LkdlLvT/iP7yxkeKRg/o4aKTfLeY2gz6BjfYQyYpJDo2o3k+L
        a/8Soz9rCl3n/Q755WRoEyY=
X-Google-Smtp-Source: ADUXVKIfW7bxgprUqmruAnxufrvO03ohL36vzIOHakFCl6q3uGsgP+DEBHjPFn2topF0jRKiwyhoaw==
X-Received: by 2002:adf:fc05:: with SMTP id i5-v6mr22132658wrr.157.1529597484687;
        Thu, 21 Jun 2018 09:11:24 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q17-v6sm6807123wrs.5.2018.06.21.09.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 09:11:23 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:11:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Message-ID: <20180621161121.GB7222@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de>
 <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com>
 <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> Sure, no problem. Do you have an opinion on the question I raised in the
> first patch [1], i.e. whether we actually want this to be done this way in the
> kernel, or one of the other approaches I described there?

So this looks like the most forward looking variant:

> a) deprecate the wait4() and getrusage() system calls, and create
>    a set of kernel interfaces based around a newly defined structure that
>    could solve multiple problems at once, e.g. provide more fine-grained
>    timestamps. The C library could then implement the posix interfaces
>    on top of the new system calls.

... but given the pretty long propagation time of new ABIs, is this a good 
solution? What would the limitations/trade-offs be on old-ABI systems?

Thanks,

	Ingo
