Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ADAC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC76206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC76206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeI2ApV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:45:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeI2ApU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:45:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41B16E3E18;
        Fri, 28 Sep 2018 18:20:21 +0000 (UTC)
Received: from [10.40.204.119] (ovpn-204-119.brq.redhat.com [10.40.204.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 444A11852A;
        Fri, 28 Sep 2018 18:20:14 +0000 (UTC)
Subject: Re: [RFC 01/20] ns: Introduce Time Namespace
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.api
References: <20180919205037.9574-1-dima@arista.com>
 <20180919205037.9574-2-dima@arista.com>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <2087cf9b-89a1-e591-4dcd-4d98767a1be6@redhat.com>
Date:   Fri, 28 Sep 2018 20:20:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180919205037.9574-2-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 28 Sep 2018 18:20:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2018 22:50, Dmitry Safonov wrote:
> From: Andrei Vagin <avagin@openvz.org>
> 
> Time Namespace isolates clock values.
> 
> The kernel provides access to several clocks CLOCK_REALTIME,
> CLOCK_MONOTONIC, CLOCK_BOOTTIME, etc.
> 
> CLOCK_REALTIME
>       System-wide  clock  that  measures real (i.e., wall-clock) time.
> 
> CLOCK_MONOTONIC
>       Clock that cannot be set and represents monotonic time since
>       some  unspecified starting point.
> 
> CLOCK_BOOTTIME
>       Identical  to  CLOCK_MONOTONIC, except it also includes any time
>       that the system is suspended.
> 
> For many users, the time namespace means the ability to changes time in
> a container (CLOCK_REALTIME).
> 
> But in a context of the checkpoint/restore functionality, monotonic and
> bootime clocks become interesting. Both clocks are monotonic with
> unspecified staring points. These clocks are widely used to measure time
> slices, set timers. After restoring or migrating processes, we have to
> guarantee that they never go backward. In an ideal case, the behavior of
> these clocks should be the same as for a case when a whole system is
> suspended. All this means that we need to be able to set CLOCK_MONOTONIC
> and CLOCK_BOOTTIME clocks, what can be done by adding per-namespace
> offsets for clocks.
> 
> Link: https://criu.org/Time_namespace
> Link: https://lists.openvz.org/pipermail/criu/2018-June/041504.html
> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> Co-developed-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  fs/proc/namespaces.c           |   3 +
>  include/linux/nsproxy.h        |   1 +
>  include/linux/proc_ns.h        |   1 +
>  include/linux/time_namespace.h |  59 ++++++++++++++
>  include/linux/user_namespace.h |   1 +
>  include/uapi/linux/sched.h     |   1 +
>  init/Kconfig                   |   7 ++
>  kernel/Makefile                |   1 +
>  kernel/fork.c                  |   3 +-
>  kernel/nsproxy.c               |  19 ++++-
>  kernel/time_namespace.c        | 169 +++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 262 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/time_namespace.h
>  create mode 100644 kernel/time_namespace.c
> 
...
> diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
> new file mode 100644
> index 000000000000..902cd9c22159
> --- /dev/null
> +++ b/kernel/time_namespace.c
...
> +
> +struct time_namespace init_time_ns = {
> +	.kref = KREF_INIT(2),
> +	.user_ns = &init_user_ns,
> +	.ns.inum = PROC_UTS_INIT_INO,

Do you mean PROC_TIME_INIT_INO?

> +#ifdef CONFIG_UTS_NS
> +	.ns.ops = &timens_operations,
> +#endif

Do you mean CONFIG_TIME_NS?

Thanks,
Laurent
