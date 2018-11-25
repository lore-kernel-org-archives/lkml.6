Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF175C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 00:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A556C2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 00:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A556C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeKYLcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 06:32:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeKYLcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 06:32:15 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 680105A8;
        Sun, 25 Nov 2018 00:42:30 +0000 (UTC)
Date:   Sat, 24 Nov 2018 16:42:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        marcandre.lureau@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH -next 1/2] mm/memfd: make F_SEAL_FUTURE_WRITE seal more
 robust
Message-Id: <20181124164229.89c670b6e7a3530ef7b0a40c@linux-foundation.org>
In-Reply-To: <20181122230906.GA198127@google.com>
References: <20181120052137.74317-1-joel@joelfernandes.org>
        <CALCETrXgBENat=5=7EuU-ttQ-YSXT+ifjLGc=hpJ=unRgSsndw@mail.gmail.com>
        <20181120183926.GA124387@google.com>
        <20181121070658.011d576d@canb.auug.org.au>
        <469B80CB-D982-4802-A81D-95AC493D7E87@amacapital.net>
        <20181120204710.GB22801@google.com>
        <F8E28229-C99E-4711-982B-5B5DE0F70F16@amacapital.net>
        <20181120211335.GC22801@google.com>
        <20181121182701.0d8a775fda6af1f8d2be8f25@linux-foundation.org>
        <CALCETrUGyhqi+M3cTdqJNNOPfTWn-R-ekM_R5heq2mbdVqPUAw@mail.gmail.com>
        <20181122230906.GA198127@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 15:09:06 -0800 Joel Fernandes <joel@joelfernandes.org> wrote:

> Android uses ashmem for sharing memory regions.  We are looking forward to
> migrating all usecases of ashmem to memfd so that we can possibly remove
> the ashmem driver in the future from staging while also benefiting from
> using memfd and contributing to it.  Note staging drivers are also not ABI
> and generally can be removed at anytime.
> 
> One of the main usecases Android has is the ability to create a region and
> mmap it as writeable, then add protection against making any "future"
> writes while keeping the existing already mmap'ed writeable-region active.
> This allows us to implement a usecase where receivers of the shared
> memory buffer can get a read-only view, while the sender continues to
> write to the buffer.  See CursorWindow documentation in Android for more
> details:
> https://developer.android.com/reference/android/database/CursorWindow
> 
> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> which prevents any future mmap and write syscalls from succeeding while
> keeping the existing mmap active.
> 
> A better way to do F_SEAL_FUTURE_WRITE seal was discussed [1] last week
> where we don't need to modify core VFS structures to get the same
> behavior of the seal. This solves several side-effects pointed by Andy.
> self-tests are provided in later patch to verify the expected semantics.
> 
> [1] https://lore.kernel.org/lkml/20181111173650.GA256781@google.com/

This changelog doesn't have the nifty test case code which was in
earlier versions?

