Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30120C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBA520827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBA520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeKJEIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:08:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:46354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728162AbeKJEIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:08:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B4CAB057;
        Fri,  9 Nov 2018 18:27:03 +0000 (UTC)
Date:   Fri, 9 Nov 2018 10:26:54 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "chouryzhou(??????)" <chouryzhou@tencent.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] binder: ipc namespace support for android binder
Message-ID: <20181109182654.ojzc7wae3jcivlup@linux-r8p5>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2018, chouryzhou(??????) wrote:

>+#ifdef CONFIG_ANDROID_BINDER_IPC
>+       /* next fields are for binder */
>+       struct mutex      binder_procs_lock;
>+       struct hlist_head binder_procs;
>+       struct hlist_head binder_contexts;
>+#endif

Now, I took a look at how the binder_procs list is used; and no, what
follows isn't really related to this patch, but a general observation.

I think that a mutex is also an overkill and you might wanna replace it
with a spinlock/rwlock. Can anything block while holding the binder_procs_lock?
I don't see anything... you mainly need it for consulting the hlist calling
print_binder_proc[_stat]() - which will take the proc->inner_lock anyway, so
no blocking there. Also, if this is perhaps because of long hold times, dunno,
the rb_first_cached primitive might reduce some of it, although I don't know
how big the rbtrees in binder can get and if it matters at all.

Anyway, that said and along with addressing Todd's comments, the ipc/ bits look
good. Feel free to add my:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Thanks,
Davidlohr
