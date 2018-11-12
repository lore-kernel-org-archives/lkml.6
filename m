Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88253223B0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88253223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeKMJsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:48:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeKMJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:48:13 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13201A67;
        Mon, 12 Nov 2018 23:52:49 +0000 (UTC)
Date:   Mon, 12 Nov 2018 15:52:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-Id: <20181112155248.4dde2613979f4c176565629e@linux-foundation.org>
In-Reply-To: <20181112160956.GA28472@redhat.com>
References: <20181112160931.GA28463@redhat.com>
        <20181112160956.GA28472@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 17:09:56 +0100 Oleg Nesterov <oleg@redhat.com> wrote:

> Large enterprise clients often times run applications out of networked
> file systems where the IT mandated layout of project volumes can end up
> leading to paths that are longer than 128 characters. Bumping this up to
> the next order of two solves this problem in all but the most egregious
> case while still fitting into a 512b slab.
> 
> ...
>
> --- a/include/uapi/linux/binfmts.h
> +++ b/include/uapi/linux/binfmts.h
> @@ -16,6 +16,6 @@ struct pt_regs;
>  #define MAX_ARG_STRINGS 0x7FFFFFFF
>  
>  /* sizeof(linux_binprm->buf) */
> -#define BINPRM_BUF_SIZE 128
> +#define BINPRM_BUF_SIZE 256
>  
>  #endif /* _UAPI_LINUX_BINFMTS_H */

It does seem a rather silly restriction, and it's tempting to suggest
reworking the code so that linux_binprm.buf is dynamically sized to
accommodate even ludicrously large strings.

But obviously 128 bytes has been enough for all this time, so that's
going too far.  However it would be basically cost-free to increase
BINPRM_BUF_SIZE up to the point where sizeof(struct linux_binprm) ==
PAGE_SIZE?

