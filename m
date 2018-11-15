Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A65EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6F42146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx9p3jrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6F42146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeKPJER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:04:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeKPJER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:04:17 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1484E2087A;
        Thu, 15 Nov 2018 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542322468;
        bh=513lJT3+D3TEhbepbnqBXvyewmlNkqoZFXXgi6AlAgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qx9p3jrWzQqZrHP5jUsSbO1eOwQSVcYcpjZMs8i7IvVhfH+F5282h3Jxk6nVcQ1+q
         w7Spf6i5YGtvOwYZIVVCBrtvFOqqU6Rr0nEPwOLSASpzVQh+gSFKqr4Uuk9JtSlolk
         9XRXXaJuXa7l6ZfIY3BQFdjVL0WwxOiWxVnyeg7U=
Date:   Thu, 15 Nov 2018 14:54:27 -0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     chouryzhou <chouryzhou@tencent.com>,
        "tkjos@google.com" <tkjos@google.com>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] binder: ipc namespace support for android binder
Message-ID: <20181115225427.GA25874@kroah.com>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F8FA41@EXMBX-SZMAIL022.tencent.com>
 <20181115143349.44e1942213b61a4818bcbf02@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181115143349.44e1942213b61a4818bcbf02@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 02:33:49PM -0800, Andrew Morton wrote:
> On Mon, 12 Nov 2018 09:37:51 +0000 chouryzhou(周威) <chouryzhou@tencent.com> wrote:
> 
> > Currently android's binder is not isolated by ipc namespace. Since binder 
> > is a form of IPC and therefore should be tied to ipc namespace. With this 
> > patch, we can run multiple instances of  android container on one host.
> > 
> > This patch move "binder_procs" and "binder_context" into ipc_namespace,
> > driver will find the context from it when opening. For debugfs, binder_proc
> > is namespace-aware, but not for binder dead nodes, binder_stats and 
> > binder_transaction_log_entry (we added ipc inum to trace it).
> > 
> > ...
> >
> >  drivers/android/binder.c      | 133 ++++++++++++++++++++++++++++++++----------
> >  include/linux/ipc_namespace.h |  15 +++++
> >  ipc/namespace.c               |  10 +++-
> >  3 files changed, 125 insertions(+), 33 deletions(-)
> 
> Well, it's mainly an android patch so I suggest this be taken via the
> android tree.
> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> 

A number of us have talked about this in the plumbers Android track, and
a different proposal for how to solve this has been made that should be
much more resiliant.  So I will drop this patch from my queue and wait
for the patches based on the discussions we had there.

I think there's some notes/slides on the discussion online somewhere,
but it hasn't been published as the conference is still happening,
otherwise I would link to it here...

thanks,

greg k-h
