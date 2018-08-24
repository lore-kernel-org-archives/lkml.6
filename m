Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E468C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01E8208CC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01E8208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeHYCGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:06:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35658 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeHYCGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:06:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1ftKa7-0007zf-EQ; Fri, 24 Aug 2018 22:29:27 +0000
Date:   Fri, 24 Aug 2018 23:29:27 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andreas Christoforou <andreaschristofo@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/mqueue: Only perform resource calculation if user
 valid
Message-ID: <20180824222927.GO6515@ZenIV.linux.org.uk>
References: <20180824215439.GA46785@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824215439.GA46785@beast>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:54:39PM -0700, Kees Cook wrote:

> The overflow was real, but the results went unused, so while the flaw
> is harmless, it's noisy for kernel fuzzers, and the fix makes things
> technically more efficient.

yes, yes, yes, yes and no.  Compiler is quite capable of noticing
that targets of assignments are unused outside of that if (user), so
any mentioning of "technically more efficient" is somewhat ridiculous...

Just make that something along the lines of "results of these assignments
are only used under if (user).  Moreover, in case if info->user is NULL
they might yield an integer overflow, confusing the fuzzers.  The odds
of any compiler letting nasal demons fly on that are pretty much nil,
but it's cleaner to move these under if (user) anyway."
