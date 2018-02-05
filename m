Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeBEPr1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:47:27 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:34026 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeBEPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:47:19 -0500
X-Google-Smtp-Source: AH8x227rmtZ0ppUyePhMMhlTsruWKsfbuLZXRTuT3/QhNna5VNRiQl19Dxp787FoPeAvrD3A4rdwxkA2A63XAQWb+hU=
MIME-Version: 1.0
In-Reply-To: <5A7882EA02000078001A552D@prv-mh.provo.novell.com>
References: <20180205150340.328921-1-arnd@arndb.de> <5A7882EA02000078001A552D@prv-mh.provo.novell.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Feb 2018 16:47:18 +0100
X-Google-Sender-Auth: i-u9ytppIXJy9_X_j47qfTxnXiU
Message-ID: <CAK8P3a3Lj_cEc40vAe9LiX3RwvvKVvCxxYsMPxxHn0BcenQt7Q@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] [v2] xen: hypercall: fix out-of-bounds memcpy
To: Jan Beulich <JBeulich@suse.com>
Cc: David Laight <David.Laight@aculab.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:14 PM, Jan Beulich <JBeulich@suse.com> wrote:
>>>> On 05.02.18 at 16:03, <arnd@arndb.de> wrote:
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
>> -     switch (cmd) {
>> -     case EVTCHNOP_close:
>> -     case EVTCHNOP_send:
>> -     case EVTCHNOP_bind_vcpu:
>> -     case EVTCHNOP_unmask:
>> -             /* no output */
>> -             break;
>> +     if (cmd > ARRAY_SIZE(evtchnop_len))
>> +             return -ENOSYS;
>
>>= perhaps?

Argh, of course. This is why I preferred the switch/case version, I knew
I'd screw this up somehow ;-)

       Arnd
