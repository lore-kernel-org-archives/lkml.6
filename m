Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB35C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA75D20882
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA75D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933850AbeFZJsf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:48:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932206AbeFZJse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:48:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FDAD40201A2;
        Tue, 26 Jun 2018 09:48:33 +0000 (UTC)
Received: from ovpn-117-67.ams2.redhat.com (ovpn-117-67.ams2.redhat.com [10.36.117.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C7022026D6A;
        Tue, 26 Jun 2018 09:48:32 +0000 (UTC)
Message-ID: <a48538cf40c1645669326c92d9600fc98a13a260.camel@redhat.com>
Subject: Re: [PATCH] add param that allows bootline control of hardened
 usercopy
From:   Paolo Abeni <pabeni@redhat.com>
To:     crecklin@redhat.com, Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@vger.kernel.org
Date:   Tue, 26 Jun 2018 11:48:31 +0200
In-Reply-To: <64bf81fa-0363-4b46-d8da-94285b592caa@redhat.com>
References: <CAGXu5jL=aEXHKr5ouVdSKwG-y7xSQFLi=x1nwSjFspYiyKL1Pw@mail.gmail.com>
         <64bf81fa-0363-4b46-d8da-94285b592caa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 09:48:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 09:48:33 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pabeni@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Jun 2018 11:21:38 -0700 Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jun 25, 2018 at 8:08 AM, Chris von Recklinghausen
> <crecklin@redhat.com> wrote:
> > Enabling HARDENED_USER_COPY causes measurable regressions in the
> > networking performances, up to 8% under UDP flood.
> 
> Which function is "hot"? i.e. which copy*user() is taking up the time?
> Do you have a workload that at can be used to reproduce the problem?

I'm running an a small packet UDP flood using pktgen vs. an host b2b
connected. On the receiver side the UDP packets are processed by a
simple user space process that just read and drop them:

https://github.com/netoptimizer/network-testing/blob/master/src/udp_sink.c

Not very useful from a functional PoV, it helps mostly pin-pointing
bottle-neck in the networking stack.

When running a kernel with CONFIG_HARDENED_USERCOPY=y, I see a 5-8%
regression in the receive tput, compared to the same kernel without
such option.

With CONFIG_HARDENED_USERCOPY=y, perf shows ~6% of CPU time spent
cumulatively in __check_object_size (~4%) and __virt_addr_valid (~2%).

Cheers,

Paolo

