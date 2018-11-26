Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5830FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2431120664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2431120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeKZXRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:17:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeKZXRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:17:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15D068535D;
        Mon, 26 Nov 2018 12:23:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F70960BE8;
        Mon, 26 Nov 2018 12:23:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 26 Nov 2018 13:23:09 +0100 (CET)
Date:   Mon, 26 Nov 2018 13:23:07 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
Message-ID: <20181126122307.GA1660@redhat.com>
References: <20181112160910.GA28440@redhat.com>
 <20181123171720.GA18841@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123171720.GA18841@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 26 Nov 2018 12:23:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 11/23, Guenter Roeck wrote:
>
> On Mon, Nov 12, 2018 at 05:09:10PM +0100, Oleg Nesterov wrote:
> > get_arg_page() checks bprm->rlim_stack.rlim_cur and re-calculates the
> > "extra" size for argv/envp pointers every time, this is a bit ugly and
> > even not strictly correct: acct_arg_size() must not account this size.
> >
> > Remove all the rlimit code in get_arg_page(). Instead, add bprm->argmin
> > calculated once at the start of __do_execve_file() and change copy_strings
> > to check bprm->p >= bprm->argmin.
> >
> > The patch adds the new helper, prepare_arg_pages() which initializes
> > bprm->argc/envc and bprm->argmin.
> >
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
>
> This patch results in various qemu boot failures in -next. Bisect logs
> are attached. It looks like all nommu boots are failing.
                                  ^^^^^

Ah, thanks.

Yes, I forgot about the !CONFIG_MMU version of get_arg_page() which doesn't
check RLIMIT_STACK at all.

I'll send the trivial fix. Meanwile, could you test the patch below? to ensure
this is the only problem.

Oleg.

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -526,8 +526,10 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 		pos = bprm->p;
 		str += len;
 		bprm->p -= len;
+#ifdef CONFIG_MMU
 		if (bprm->p < bprm->argmin)
 			goto out;
+#endif
 
 		while (len > 0) {
 			int offset, bytes_to_copy;

