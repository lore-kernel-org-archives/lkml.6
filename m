Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B43EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC392175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC392175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeHCNOl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:14:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbeHCNOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:14:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D89A340287F7;
        Fri,  3 Aug 2018 11:18:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35A9A2026D65;
        Fri,  3 Aug 2018 11:18:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <8347.1533292272@warthog.procyon.org.uk>
References: <8347.1533292272@warthog.procyon.org.uk> <47c34fad-5d11-53b0-4386-61be890163c5@virtuozzo.com> <153320759911.18959.8842396230157677671.stgit@localhost.localdomain> <20180802134723.ecdd540c7c9338f98ee1a2c6@linux-foundation.org>
Cc:     dhowells@redhat.com, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        mhocko@suse.com, aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, willy@infradead.org,
        shakeelb@google.com, jbacik@fb.com, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to do_shrink_slab()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12713.1533295125.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 03 Aug 2018 12:18:45 +0100
Message-ID: <12714.1533295125@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 11:18:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 11:18:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> But!  I'm not sure why the reproducer works at all because the umount2() call
> is *after* the chroot, so should fail on ENOENT before it even gets that
> far.

No, it shouldn't.  It did chroot() not chdir().

> In fact, umount2() can be called multiple times, apparently successfully, and
> doesn't actually unmount anything.

Okay, because it chroot'd into the directory.  Should it return EBUSY though?

David
