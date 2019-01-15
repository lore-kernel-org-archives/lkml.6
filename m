Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3530EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0709F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfAOHZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:25:31 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:51442 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfAOHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:25:31 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gjJ6H-00079H-OK; Tue, 15 Jan 2019 00:25:29 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gjJ6G-0003YL-0R; Tue, 15 Jan 2019 00:25:29 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Robert O'Callahan" <robert@ocallahan.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAOp6jLa8rRw2ZQN9yWYZv_USrZw98D+U2rnk9V7M2EVY7O=VpQ@mail.gmail.com>
Date:   Tue, 15 Jan 2019 01:25:03 -0600
In-Reply-To: <CAOp6jLa8rRw2ZQN9yWYZv_USrZw98D+U2rnk9V7M2EVY7O=VpQ@mail.gmail.com>
        (Robert O'Callahan's message of "Tue, 15 Jan 2019 18:27:00 +1300")
Message-ID: <87won67580.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gjJ6G-0003YL-0R;;;mid=<87won67580.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ql09Zv7Njv6JJZZgjOBcubpUOrniLzZ0=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Regression in 32-bit-compat TIOCGPTPEER ioctl due to 311fc65c9fb9c966bca8e6f3ff8132ce57344ab9
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert O'Callahan" <robert@ocallahan.org> writes:

> This commit refactored the implementation of TIOCGPTPEER, moving "case
> TIOCGPTPEER" from pty_unix98_ioctl() to tty_ioctl().
> pty_unix98_ioctl() is called by pty_unix98_compat_ioctl(), so before
> the commit, TIOCGPTPEER worked for 32-bit userspace. Unfortunately
> tty_compat_ioctl() does not call tty_ioctl() so after the commit,
> TIOCGPTPEER from 32-bit userspace fails with ENOTTY.
>
> Testcase in https://bugzilla.kernel.org/show_bug.cgi?id=202271.
>
> I found this bug running the rr test suite.

Can you confirm this fixes it for you?

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index bfe9ad85b362..1b0847976b28 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2815,6 +2815,7 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
        case TCXONC:
        case TIOCMIWAIT:
        case TIOCSERCONFIG:
+       case TIOCGPTPEER:
                return tty_ioctl(file, cmd, arg);
        }


Thank you,
Eric Biederman
