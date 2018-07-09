Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A2BC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C5320857
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C5320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeGIJfu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:35:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932366AbeGIJfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:35:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24BEC83207;
        Mon,  9 Jul 2018 09:35:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C719111E3E8;
        Mon,  9 Jul 2018 09:35:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <10670.1531128774@warthog.procyon.org.uk>
References: <10670.1531128774@warthog.procyon.org.uk> <20180708210154.10423-4-ebiggers3@gmail.com> <20180708210154.10423-1-ebiggers3@gmail.com>
Cc:     dhowells@redhat.com, Eric Biggers <ebiggers3@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 03/18] fs_context: fix detecting full log buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10921.1531128946.1@warthog.procyon.org.uk>
Date:   Mon, 09 Jul 2018 10:35:46 +0100
Message-ID: <10922.1531128946@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 09 Jul 2018 09:35:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 09 Jul 2018 09:35:48 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > When 'head' and 'tail' wrap around, 'log->head - log->tail' will be
> > something like '4 - 252 = -248', and comparing that directly to the
> > array size is wrong.  Fix by casting to 'u8'.
> 
> I think a better fix is to use CIRC_CNT() or CIRC_SPACE().

Or it would be - if CIRC_CNT() and CIRC_SPACE() didn't leave a hole in the
buffer - but that's unnecessary if the head and tail counters can hold 2x the
ring size or more.

David
