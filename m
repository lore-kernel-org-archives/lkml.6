Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24776C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94F02086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94F02086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeKHQdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:33:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:54350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbeKHQdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:33:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70512ABCE;
        Thu,  8 Nov 2018 06:59:49 +0000 (UTC)
Date:   Wed, 7 Nov 2018 22:59:42 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "chouryzhou(??????)" <chouryzhou@tencent.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] binder: ipc namespace support for android binder
Message-ID: <20181108065942.6gnb675xb2wuerrl@linux-r8p5>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F6BB7D@EXMBX-SZMAIL022.tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F6BB7D@EXMBX-SZMAIL022.tencent.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018, chouryzhou(??????) wrote:
>@@ -63,6 +63,12 @@ struct ipc_namespace {
>        unsigned int    mq_msg_default;
>        unsigned int    mq_msgsize_default;
>
>+       /* next fields are for binder */
>+       struct mutex      binder_procs_lock;
>+       struct hlist_head binder_procs;
>+       struct mutex      binder_contexts_lock;
>+       struct hlist_head binder_contexts;

I don't think you want a mutex here protecting the binder_contexts list.
Afaict there is no concurrency going on: you only modify it in when doing
namespace init and exit (for which you have no serialization); do you even
need a lock here? Or at least I would think a more lightweight alternative
(rcu/spinlock/rwlock) would suffice.

Thanks,
Davidlohr
