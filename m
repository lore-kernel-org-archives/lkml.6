Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B41C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5736020856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5736020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeJ0QeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 12:34:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45818 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeJ0QeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 12:34:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGJPp-0005AH-2E; Sat, 27 Oct 2018 07:53:49 +0000
Date:   Sat, 27 Oct 2018 08:53:49 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Ed Maste <emaste@freebsd.org>,
        David Drysdale <drysdale@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181027075348.GN32577@ZenIV.linux.org.uk>
References: <20181009065300.11053-3-cyphar@cyphar.com>
 <20181027014114.GA52393@freebsd.org>
 <20181027071729.xbnvfii6iwdwymrn@ryuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027071729.xbnvfii6iwdwymrn@ryuk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 06:17:29PM +1100, Aleksa Sarai wrote:

> I'm going to send out a v4 "soon" but I would like to know what folks
> think about having resolveat(2) (or similar) to separate the scoping O_*
> flags and produce an O_PATH -- since unsupported O_* flags are ignored
> by older kernels userspace will have to do some plenty of checking after
> each path operation.
> 
> Personally, I believe this (along with AT_EMPTY_PATH for openat(2))
> would help with some other O_PATH issues.

The trouble with resolveat(2) is that for anything directory-modifying
you really want directory locked before the lookup for last component.
IOW, funlink(2) et.al. are hopeless.  You can, of course, do O_PATH
open for everything sans the last component, and do unlinkat() with
the base being the result of that open and the last component for
relative pathname, but that takes more work on the userland side than
you probably want to bother with.

IOW, pathname resolution for directory entry is seriously different from
that for fs object.  And you obviously don't want to return from a syscall
with directory locked.
