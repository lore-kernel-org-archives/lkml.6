Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B185C282CF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249F8214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfA2BXZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:23:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfA2BXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:23:24 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCD5B28DF;
        Tue, 29 Jan 2019 01:23:22 +0000 (UTC)
Date:   Mon, 28 Jan 2019 17:23:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 1/1] prctl: add
 PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT
Message-Id: <20190128172321.780e9b380dd40eb3e7c22daf@linux-foundation.org>
In-Reply-To: <20190118131130.42209-2-j@bitron.ch>
References: <20181127225408.7553-1-j@bitron.ch>
        <20190118131130.42209-1-j@bitron.ch>
        <20190118131130.42209-2-j@bitron.ch>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 14:11:30 +0100 Jürg Billeter <j@bitron.ch> wrote:

> This introduces a new thread group flag that can be set by calling
> 
>     prctl(PR_SET_KILL_DESCENDANTS_ON_EXIT, 1, 0, 0, 0)
> 
> When a thread group exits with this flag set, it will send SIGKILL to
> all descendant processes.  This can be used to prevent stray child
> processes.
> 
> This flag is cleared on privilege gaining execve(2) to ensure an
> unprivileged process cannot get a privileged process to send SIGKILL.
> 
> Descendants that are orphaned and reparented to an ancestor of the
> current process before the current process exits, will not be killed.
> PR_SET_CHILD_SUBREAPER can be used to contain orphaned processes.
> 
> If a descendant gained privileges, the current process may not be
> allowed to kill it, and the descendant process will survive.
> PR_SET_NO_NEW_PRIVS can be used to prevent descendant processes from
> gaining privileges.

I don't feel that I'm able to judge the usefulness of this.  It would
help to have a lot more words right here in this changelog which
communicate the value of this change to our users.  References are
useful, but please don't send people off to chase down mailing list and
bugzilla discussions as a substitute for properly describing the feature
and its justification.

Some test code in tools/testing/selftests/ would be helpful.

We'll need to update the prctl(2) manpage if we proceed with this.
