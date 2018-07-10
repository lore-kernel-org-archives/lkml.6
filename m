Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E16BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDB8208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDB8208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbeGJWJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:09:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:53852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732237AbeGJWJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:09:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03ADAAD0B;
        Tue, 10 Jul 2018 22:08:35 +0000 (UTC)
Date:   Tue, 10 Jul 2018 15:08:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 01/12] ipc: reorganize initialization of kern_ipc_perm.id
Message-ID: <20180710220830.pvdvq7aovja5nrmf@linux-r8p5>
References: <20180709151019.1336-1-manfred@colorfullife.com>
 <20180709151019.1336-2-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180709151019.1336-2-manfred@colorfullife.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jul 2018, Manfred Spraul wrote:

>ipc_addid() initializes kern_ipc_perm.id after having called
>ipc_idr_alloc().
>
>Thus a parallel semop() or msgrcv() that uses ipc_obtain_object_idr()
>may see an uninitialized value.
>
>The patch moves all accesses to kern_ipc_perm.id under the spin_lock().

Yeah this is a lot better than my kzalloc() idea. I was considering
completions to avoid these races with ->getnew(), but careful init beats
that idea for obvious reasons.

The only thing I would say is that the title should be more descriptive.
Unlike the next patch, this one isn't really reorganizing anything.
How about:

  ipc: compute kern_ipc_perm.id under the ipc lock for stat cmds

>
>The issues is related to the finding of
>syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com:
>syzbot found an issue with kern_ipc_perm.seq
>
>Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>Cc: Dmitry Vyukov <dvyukov@google.com>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
