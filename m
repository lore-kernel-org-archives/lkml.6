Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeBBQLL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:11:11 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36759 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBBQLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:11:03 -0500
X-Google-Smtp-Source: AH8x2245HD2j0vlWglGJ9HLt1J/YHOkf/i+Cb7fBdrqFfVJPD6Vrxwd8ozMVWJdMBnkPfjtkhYy6l+ZF7q+/B5ToAOw=
MIME-Version: 1.0
In-Reply-To: <20180202155309.2xg2gjcp7wb7bbpe@mwanda>
References: <20180202153240.1190361-1-arnd@arndb.de> <20180202155309.2xg2gjcp7wb7bbpe@mwanda>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 17:11:02 +0100
X-Google-Sender-Auth: V39I-YZ2b2Jxa7uik1TFdTwCfkw
Message-ID: <CAK8P3a0Z2PMP-=e2Ga8kw196vWeAz_HC02ABQmDB9W_0Cmmr-Q@mail.gmail.com>
Subject: Re: [PATCH] xen: hypercall: fix out-of-bounds memcpy
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>, Jan Beulich <jbeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 4:53 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Fri, Feb 02, 2018 at 04:32:31PM +0100, Arnd Bergmann wrote:

>> --- a/drivers/xen/fallback.c
>> +++ b/drivers/xen/fallback.c
>> @@ -7,75 +7,87 @@
>>
>>  int xen_event_channel_op_compat(int cmd, void *arg)
>>  {
>> -     struct evtchn_op op;
>> +     struct evtchn_op op = { .cmd = cmd, };
>> +     size_t len;
>>       int rc;
>>
>> -     op.cmd = cmd;
>> -     memcpy(&op.u, arg, sizeof(op.u));
>> -     rc = _hypercall1(int, event_channel_op_compat, &op);
>> -
>>       switch (cmd) {
>> +     case EVTCHNOP_bind_interdomain:
>> +             len = sizeof(struct evtchn_bind_interdomain);
>> +             break;
>
> This was in the original code, but I'm slightly surpprised that we're
> using a switch statement here instead of a table.  I would have thought
> this is a fast path but I don't know xen at all.

I thought about using a table, but figured the switch statement
had a lower risk of getting something slightly wrong during the
conversion.

I would expect gcc to turn this into a table lookup, since all the
constants are consecutive, but it should not really matter since
this is only the fallback path for ancient Xen releases. When Xen
guest support was first merged in 2007, it was already
deprecated.

      Arnd
