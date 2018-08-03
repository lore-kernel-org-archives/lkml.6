Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF74CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7403321763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7403321763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeHCPqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:46:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729985AbeHCPqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC08F401DE61;
        Fri,  3 Aug 2018 13:49:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1DA21D080;
        Fri,  3 Aug 2018 13:49:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180722110519.23917-1-tomasbortoli@gmail.com>
References: <20180722110519.23917-1-tomasbortoli@gmail.com>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH] fscache: fscache_set_key() - align alloc and usage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17156.1533304170.1@warthog.procyon.org.uk>
Date:   Fri, 03 Aug 2018 14:49:30 +0100
Message-ID: <17157.1533304170@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 13:49:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 13:49:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli <tomasbortoli@gmail.com> wrote:

> The fscache_set_key() function allocates the buf pointer if index_key_len >
> sizeof(cookie->inline_key).  In such cases the allocated space might not be
> aligned with the pointer type.  This may result in an out-of-bound in the
> for-loop later in the same function, as the counter is rounded up.

Yeah, it's good idea anyway since I should tell the allocator everything that
I expect to use - though kmalloc() will effectively rounds up the size to a
multiple of 8 anyway (ie. the smallest allocation granule is 8 bytes).

David
