Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18F625D88
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18F625D88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933296AbeFZROv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:14:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932150AbeFZROu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:14:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D300981A4EA4;
        Tue, 26 Jun 2018 17:14:49 +0000 (UTC)
Received: from ovpn-117-67.ams2.redhat.com (ovpn-117-67.ams2.redhat.com [10.36.117.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABEF821565E1;
        Tue, 26 Jun 2018 17:14:48 +0000 (UTC)
Message-ID: <a8343284adff3c743121a339035d5010347a3038.camel@redhat.com>
Subject: Re: [PATCH] add param that allows bootline control of hardened
 usercopy
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Date:   Tue, 26 Jun 2018 19:14:47 +0200
In-Reply-To: <CAGXu5jKHz=OaU1ejYEB=t-=Gs6gVoRywFbyQw8ThHk6WYG7Qxg@mail.gmail.com>
References: <CAGXu5jL=aEXHKr5ouVdSKwG-y7xSQFLi=x1nwSjFspYiyKL1Pw@mail.gmail.com>
         <64bf81fa-0363-4b46-d8da-94285b592caa@redhat.com>
         <a48538cf40c1645669326c92d9600fc98a13a260.camel@redhat.com>
         <CAGXu5jKHz=OaU1ejYEB=t-=Gs6gVoRywFbyQw8ThHk6WYG7Qxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 17:14:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 17:14:49 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pabeni@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[hopefully fixed the 'mm' recipient]

On Tue, 2018-06-26 at 09:54 -0700, Kees Cook wrote:
> On Tue, Jun 26, 2018 at 2:48 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> > With CONFIG_HARDENED_USERCOPY=y, perf shows ~6% of CPU time spent
> > cumulatively in __check_object_size (~4%) and __virt_addr_valid (~2%).
> 
> Are you able to see which network functions are making the
> __check_object_size() calls?

The call-chain is:

__GI___libc_recvfrom                                                   
entry_SYSCALL_64_after_hwframe                                         
do_syscall_64                                                          
__x64_sys_recvfrom                                                     
__sys_recvfrom                                                         
inet_recvmsg                                                           
udp_recvmsg                                                            
__check_object_size

udp_recvmsg() actually calls copy_to_iter() (inlined) and the latters
calls check_copy_size() (again, inlined).

Cheers,

Paolo

