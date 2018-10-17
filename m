Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47616ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1606521526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1606521526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJQX2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:28:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49781 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbeJQX2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:28:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1045D356D5;
        Wed, 17 Oct 2018 15:32:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A32E7842C;
        Wed, 17 Oct 2018 15:32:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181017151134.GA8966@andrea>
References: <20181017151134.GA8966@andrea> <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk> <153978621809.8478.2198040871218302573.stgit@warthog.procyon.org.uk>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     dhowells@redhat.com, gregkh@linux-foundation.org,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        viro@zeniv.linux.org.uk, sandeen@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fscache: Fix race in fscache_op_complete() due to split atomic_sub & read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14407.1539790333.1@warthog.procyon.org.uk>
Date:   Wed, 17 Oct 2018 16:32:13 +0100
Message-ID: <14408.1539790333@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 17 Oct 2018 15:32:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <andrea.parri@amarulasolutions.com> wrote:

> > Fix this by using atomic_sub_return() instead of two calls.
> 
> Seems a case for atomic_sub_return_relaxed()... why not?

Ummm...  In that case, should it be atomic_sub_return_release()?

David
