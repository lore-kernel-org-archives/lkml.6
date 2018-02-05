Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeBEMhe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:37:34 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:36889 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeBEMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:37:26 -0500
X-Google-Smtp-Source: AH8x225/XkJCRXWlxWFSJCQ490QtJKa72aYFTopGV50RRwUf5zap4LlF5+2qcs2g53Osdq3nSRFZhtEsbyDbOj5xDq4=
MIME-Version: 1.0
In-Reply-To: <1eddce614f604c518b9bf238a2f92e4b@AcuMS.aculab.com>
References: <20180202153240.1190361-1-arnd@arndb.de> <aa6e25c7-dc55-a5bf-39cb-8b9453604111@oracle.com>
 <1eddce614f604c518b9bf238a2f92e4b@AcuMS.aculab.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Feb 2018 13:37:25 +0100
X-Google-Sender-Auth: v95zlyGO3j8U8VrM8RPl5dd2VUo
Message-ID: <CAK8P3a0z72S6mY7Q7RBJ_EMCbF9DOi+RdVaUEsB_qo+rGurQ1g@mail.gmail.com>
Subject: Re: [PATCH] xen: hypercall: fix out-of-bounds memcpy
To: David Laight <David.Laight@aculab.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 1:11 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Boris Ostrovsky
>> Sent: 02 February 2018 23:34
> ...
>> >     switch (cmd) {
>> > +   case EVTCHNOP_bind_interdomain:
>> > +           len = sizeof(struct evtchn_bind_interdomain);
>> > +           break;
>> > +   case EVTCHNOP_bind_virq:
>> > +           len = sizeof(struct evtchn_bind_virq);
>> > +           break;
>> > +   case EVTCHNOP_bind_pirq:
>> > +           len = sizeof(struct evtchn_bind_pirq);
>> > +           break;
>> >     case EVTCHNOP_close:
>> > +           len = sizeof(struct evtchn_close);
>> > +           break;
>> >     case EVTCHNOP_send:
>> > +           len = sizeof(struct evtchn_send);
>> > +           break;
>> > +   case EVTCHNOP_alloc_unbound:
>> > +           len = sizeof(struct evtchn_alloc_unbound);
>> > +           break;
>> > +   case EVTCHNOP_bind_ipi:
>> > +           len = sizeof(struct evtchn_bind_ipi);
>> > +           break;
>> > +   case EVTCHNOP_status:
>> > +           len = sizeof(struct evtchn_status);
>> > +           break;
>> >     case EVTCHNOP_bind_vcpu:
>> > +           len = sizeof(struct evtchn_bind_vcpu);
>> > +           break;
>> >     case EVTCHNOP_unmask:
>> > -           /* no output */
>> > +           len = sizeof(struct evtchn_unmask);
>> >             break;
>
> Are the EVTCHNOP_xxx values dense?
> In which case an array is almost certainly better than the switch statement.

They are, yes. PHYSDEVOP_xxx are also consecutive by start at '4'.
Dan made the same comment earlier, and I replied that my I had
considered it but went for the more failsafe route. I also verified my
assumption now that gcc in fact is smart enough to turn this
into a table by itself:

xen_physdev_op_compat:
        pushq   %r13    #
        leal    -4(%rdi), %eax  #, _2
        pushq   %r12    #
        pushq   %rbp    #
        pushq   %rbx    #
        subq    $24, %rsp       #,
# /git/arm-soc/drivers/xen/fallback.c:59:       struct physdev_op op =
{ .cmd = cmd, };
        movq    $0, 4(%rsp)     #, MEM[(struct physdev_op *)&op + 4B]
        movq    $0, 12(%rsp)    #, MEM[(struct physdev_op *)&op + 4B]
        movl    $0, 20(%rsp)    #, MEM[(struct physdev_op *)&op + 4B]
        movl    %edi, (%rsp)    # cmd, op.cmd
        cmpl    $6, %eax        #, _2
        ja      .L8     #,
        movl    %eax, %edi      # _2, _2
# /git/arm-soc/drivers/xen/fallback.c:87:       memcpy(&op.u, arg, len);
        leaq    8(%rsp), %r12   #, tmp98
        movq    %rsi, %rbx      # arg, arg
        movq    CSWTCH.17(,%rdi,8), %r13        # CSWTCH.17, _5
        movq    %r12, %rdi      # tmp98,
        movq    %r13, %rdx      # _5,
        call    __memcpy        #
# /git/arm-soc/drivers/xen/fallback.c:88:       rc = _hypercall1(int,
physdev_op_compat, &op);
        movq    %rsp, %rdi      #, __arg1
#APP
# 88 "/git/arm-soc/drivers/xen/fallback.c" 1
        call hypercall_page+608 #


     Arnd
