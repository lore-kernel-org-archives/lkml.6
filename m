Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C69C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4714A2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4714A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeLAAtq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:49:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeLAAtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:49:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64998C025011;
        Fri, 30 Nov 2018 13:40:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com [10.33.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CCEB1057065;
        Fri, 30 Nov 2018 13:40:23 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     =?utf-8?Q?J=C3=BCrg?= Billeter <j@bitron.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] prctl: add PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT
References: <20181127225408.7553-2-j@bitron.ch>
        <20181130080004.23635-1-j@bitron.ch>
        <20181130080004.23635-2-j@bitron.ch>
Date:   Fri, 30 Nov 2018 14:40:14 +0100
In-Reply-To: <20181130080004.23635-2-j@bitron.ch> (=?utf-8?Q?=22J=C3=BCrg?=
 Billeter"'s message
        of "Fri, 30 Nov 2018 08:00:04 +0000")
Message-ID: <87bm66u1j5.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 30 Nov 2018 13:40:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jürg Billeter:

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

So this is inherited across regular execve?  I'm not sure that's a good
idea.

> Descendants that are orphaned and reparented to an ancestor of the
> current process before the current process exits, will not be killed.
> PR_SET_CHILD_SUBREAPER can be used to contain orphaned processes.

For double- or triple-forking daemons, the reparenting will be racy, if
I understand things correctly.

Thanks,
Florian
