Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061702087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061702087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeKLLKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:10:22 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:33795 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeKLLKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:10:21 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gM0t6-0000zq-EH; Sun, 11 Nov 2018 18:19:36 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gM0t5-0007AX-ET; Sun, 11 Nov 2018 18:19:36 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Daniel Colascione' <dancol@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Christian Brauner" <christian.brauner@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20181029221037.87724-1-dancol@google.com>
        <20181031155912.45088-1-dancol@google.com>
        <20181031175448.GC2180@cisco>
        <CAKOZuevrFxWLY1J1DVPNGaEy8UbkD1r_M9T9FQTOtSrqp-G0qw@mail.gmail.com>
        <20181031181717.GD2180@cisco>
        <CAKOZuetdSK8jhD1snja8p4AQTNPrLOugQrVn642RCH8S4QBGFg@mail.gmail.com>
        <c49f552e34784e8dbb40a43015bed642@AcuMS.aculab.com>
Date:   Sun, 11 Nov 2018 19:19:30 -0600
In-Reply-To: <c49f552e34784e8dbb40a43015bed642@AcuMS.aculab.com> (David
        Laight's message of "Thu, 1 Nov 2018 11:33:29 +0000")
Message-ID: <87d0rbks7x.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gM0t5-0007AX-ET;;;mid=<87d0rbks7x.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+f9hP2PcpR7gGkNaAxwChOly4LZu7+WxM=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3] Implement /proc/pid/kill
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: Daniel Colascione
>> Sent: 31 October 2018 19:33
> ...
>> You can't do it today with kill. The idea that keeping a open file
>> descriptor to a /proc/pid or a file within it prevents PID reuse is
>> widespread, but incorrect.
>
> Is there a real good reason why that shouldn't be the case?
> ie Holding a reference on the 'struct pid' being enough to stop reuse.
>
> A patch to do that would be more generally useful.

Holding an open file descriptor to /proc/pid is enough to prevent pid
reuse problems.  If a pid number is reused a new 'struct pid' is
generated.  There is not 'struct pid' reuse.

So in solving this the kernel data structure you would need to hold onto
is a 'struct pid'.  It is just necessary to add an interface to sending
signals to that 'struct pid' and not looking up the 'struct pid' again
by number.

Eric
