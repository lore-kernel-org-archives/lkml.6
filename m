Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC755C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A11D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfA3NB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:01:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731060AbfA3NB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:01:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8759A04A0;
        Wed, 30 Jan 2019 13:01:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-128.rdu2.redhat.com [10.10.120.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0851D5C2EE;
        Wed, 30 Jan 2019 13:01:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190130120654.q5zqcexquca7u337@ws.net.home>
References: <20190130120654.q5zqcexquca7u337@ws.net.home> <87va2716mh.fsf@xmission.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     dhowells@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        util-linux@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFD] A mount api that notices previous mounts
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9870.1548853314.1@warthog.procyon.org.uk>
Date:   Wed, 30 Jan 2019 13:01:54 +0000
Message-ID: <9871.1548853314@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 30 Jan 2019 13:01:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Zak <kzak@redhat.com> wrote:

> It seems more elegant is to ask for Nth option as expected by fsinfo().

More elegant yes, but there's an issue with atomiticity[*].  I'm in the
process of switching to something that returns you a single buffer with all
the options in, but each key and each value is preceded by a length count.

The reasons for not using separator characters are:

 (1) There's no separator char that cannot validly occur within an option[**].

 (2) Makes it possible to return binary values if we need to.

David

[*] Atomic with respect to remount calls, that is.

[**] Oh, and look at cifs where you can *change* the separator char during
     option parsing ("sep=<char>").
