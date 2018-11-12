Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BBEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5262245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5262245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbeKMEY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:24:57 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:54555 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKMEY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:24:57 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gMGym-0002Sy-1F; Mon, 12 Nov 2018 11:30:32 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gMGyl-0005jW-2g; Mon, 12 Nov 2018 11:30:31 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20181112171144.GI3645@cisco>
Date:   Mon, 12 Nov 2018 12:30:25 -0600
In-Reply-To: <20181112171144.GI3645@cisco> (Tycho Andersen's message of "Mon,
        12 Nov 2018 10:11:44 -0700")
Message-ID: <87efbqi1xa.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gMGyl-0005jW-2g;;;mid=<87efbqi1xa.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18H2nkmPl5PiWGFUOdV+DY4jJJn4dYivog=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: siginfo pid not populated from ptrace?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tycho Andersen <tycho@tycho.ws> writes:

> Hi Oleg,
>
> I've been running some tests on my seccomp series, and in one of the
> tests on v4.20-rc2, I noticed,
>
> [ RUN      ] global.syscall_restart
> seccomp_bpf.c:2784:global.syscall_restart:Expected getpid() (1492) == info._sifields._kill.si_pid (0)
> global.syscall_restart: Test failed at step #22
>
> which seems unrelated to my series (the kernel was stock v4.20 with my
> patches on top).
>
> I've been running a lot of tests, and only seen this once, so it seems
> like a fairly rare race. I tried to look through the code but didn't
> see anything obvious. Thoughts?

My guess would be pid namespaces, or stopping for a signal other than
SIGSTOP.

If you can get this to reproduce at all it would be interesting to see
si_signo and si_code.  So that we can see just which signal is in info,
and how it should be decoded. 

I see this test at line 2736 in 4.20-rc1 so there are almost 50 lines of
change in your version of seccomp_bpf.c.  So I hope I am reading the
proper test.

Eric
