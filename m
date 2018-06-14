Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A488CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606F2208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606F2208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755301AbeFNNcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:32:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754972AbeFNNcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:32:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6CC6818BAFD;
        Thu, 14 Jun 2018 13:32:21 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-97.ams2.redhat.com [10.36.117.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A8657C49;
        Thu, 14 Jun 2018 13:32:18 +0000 (UTC)
Subject: Re: Restartable Sequences system call merged into Linux
To:     Pavel Machek <pavel@ucw.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
 <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
 <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com>
 <091061df-3482-8762-30e4-feaf3417be11@redhat.com>
 <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
 <20180614122759.GB8798@amd>
 <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com>
 <20180614132557.GA15201@amd>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <1110f198-88c2-544d-6836-f901b8e90f98@redhat.com>
Date:   Thu, 14 Jun 2018 15:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614132557.GA15201@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 14 Jun 2018 13:32:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 14 Jun 2018 13:32:21 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 03:25 PM, Pavel Machek wrote:

> But the proposal wanted to add a syscall to thread creation, right?
> And I believe that may be noticeable.

We already call set_robust_list, so we could just pass a larger area to 
that and the kernel could use it.  Then no additional system call would 
be needed in the common case (new kernel which recognizes the new area 
size).

But then we cannot use an initial-exec thread local variable for it 
(although the offset from the thread pointer will still be constant, of 
course).

Thanks,
Florian
