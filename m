Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A022C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C082086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C082086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeKHIKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:10:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKHIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:10:14 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 71C1F891;
        Wed,  7 Nov 2018 22:37:45 +0000 (UTC)
Date:   Wed, 7 Nov 2018 14:37:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?UTF-8?B?Y2hvdXJ5emhvdQ==?= (=?UTF-8?B?5ZGo5aiB?=) 
        <chouryzhou@tencent.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] binder: ipc namespace support for android binder
Message-Id: <20181107143744.2dd91690aad06ab1d678dfe8@linux-foundation.org>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F816F8@EXMBX-SZMAIL022.tencent.com>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F816F8@EXMBX-SZMAIL022.tencent.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 01:48:12 +0000 chouryzhou(周威) <chouryzhou@tencent.com> wrote:

> > > --- a/ipc/namespace.c
> > > +++ b/ipc/namespace.c
> > > @@ -56,6 +56,9 @@ static struct ipc_namespace *create_ipc_ns(struct
> > user_namespace *user_ns,
> > >         ns->ucounts = ucounts;
> > >
> > >         err = mq_init_ns(ns);
> > > +       if (err)
> > > +               goto fail_put;
> > > +       err = binder_init_ns(ns);
> > >         if (err)
> > >                 goto fail_put;
> > >
> > 
> > Don't we need an mq_put_mnt() if binder_init_ns() fails?
> > 
> > free_ipc_ns() seems to have forgotten about that too.  In which case it
> > must be madly leaking mounts so probably I'm wrong.  Confused.
> > 
> 
> mq_init_ns will do clean job if it failed, and as do binder_init_ns. 

My point is that if mq_init_ns() succeeds and binder_init_ns() fails,
we don't undo the effects of mq_init_ns()?
