Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72042C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A78222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405534AbfBNQI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:08:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387658AbfBNQI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:08:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E06E0A9719;
        Thu, 14 Feb 2019 16:08:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id EE0282656E;
        Thu, 14 Feb 2019 16:08:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 14 Feb 2019 17:08:24 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:08:21 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] exec: load_script: Allow interpreter argument truncation
Message-ID: <20190214160821.GB19102@redhat.com>
References: <20190214012754.GA17326@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214012754.GA17326@beast>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 14 Feb 2019 16:08:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13, Kees Cook wrote:
>
> While we want to make sure the kernel doesn't attempt to execute a
> truncated interpreter path, we must allow the interpreter arguments to
> be truncated. Perl, for example, will re-read the script itself to parse
> arguments correctly.

Heh. I still think that 8099b047ecc4 does the right thing.

But I can't argue with the fact that it caused the regression, so it should
be reverted.

> This documents the parsing steps, and will fail to exec if the string was
> truncated with neither an end-of-line nor any trailing whitespace.

You know, I have already spent 3 hours trying to write something simple and
clear, but failed. Still trying...

Nor I can really understand your fix ;) Will try to read it again, just one
question for now,

>  	for (cp = bprm->buf+2;; cp++) {
> -		if (cp >= bprm->buf + BINPRM_BUF_SIZE)
> -			return -ENOEXEC;
> -		if (!*cp || (*cp == '\n'))
> +		if (cp == bprm->buf + BINPRM_BUF_SIZE - 1) {
> +			truncated = true;

Off-by-one, no? "bprm->buf + BINPRM_BUF_SIZE - 1" is the very last char, it can
be '\n' or '\0', this should set end_of_interp.

>  			break;
> +		}
> +		if (!*cp || (*cp == '\n')) {
> +			end_of_interp = true;
> +			break;
> +		}

so unless I am totally confused you should move this block up before the
"bprm->buf + BINPRM_BUF_SIZE - 1" check or that check should use
"bprm->buf + BINPRM_BUF_SIZE".

No?

Oleg.

