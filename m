Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F21C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CD120851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx2ECFPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CD120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeKUBnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbeKUBnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:43:08 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E950213A2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542726811;
        bh=6RUUP+ioVJ3a0zmsvHsmZ7WZbYsyYvbepgXrG9jahKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lx2ECFPHzaa/saPZpXvXfzspmooK+ptc781HRs1HVmrRND8ohdGd4qRpXJtA6yjJI
         s4JlAOei3DU8wNVQJK+Jff/OSy4bX5inmllGzSiEGZItJqC73iOHcRADWCt0hDSeqA
         eEXqs68EC7L/OjdJ78WXkmTnk7nOlp4WQIDalJAw=
Received: by mail-wm1-f49.google.com with SMTP id s11so2642610wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 07:13:31 -0800 (PST)
X-Gm-Message-State: AA+aEWa4AwDmfiYHNTjW5XaJlTWNWx3QeILDFGkNHff4dutJsJsF4lLV
        ekYvSbWkw6E+LOK7cwjCuPq9WI/HhN+G/RDs+3KsOg==
X-Google-Smtp-Source: AJdET5cw/zm+H+oDGGrjSUKn8scO77h56DZ9bhCsUUDdPTDfSlLSh2uKYZEE8bC+XdttSkgwdFS7DNe07/1sSHzdb80=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr1903932wmf.32.1542726809572;
 Tue, 20 Nov 2018 07:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20181120052137.74317-1-joel@joelfernandes.org>
In-Reply-To: <20181120052137.74317-1-joel@joelfernandes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 20 Nov 2018 07:13:17 -0800
X-Gmail-Original-Message-ID: <CALCETrXgBENat=5=7EuU-ttQ-YSXT+ifjLGc=hpJ=unRgSsndw@mail.gmail.com>
Message-ID: <CALCETrXgBENat=5=7EuU-ttQ-YSXT+ifjLGc=hpJ=unRgSsndw@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] mm/memfd: make F_SEAL_FUTURE_WRITE seal more robust
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        marcandre.lureau@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 9:21 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> A better way to do F_SEAL_FUTURE_WRITE seal was discussed [1] last week
> where we don't need to modify core VFS structures to get the same
> behavior of the seal. This solves several side-effects pointed out by
> Andy [2].
>
> [1] https://lore.kernel.org/lkml/20181111173650.GA256781@google.com/
> [2] https://lore.kernel.org/lkml/69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net/
>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Fixes: 5e653c2923fd ("mm: Add an F_SEAL_FUTURE_WRITE seal to memfd")

What tree is that commit in?  Can we not just fold this in?
