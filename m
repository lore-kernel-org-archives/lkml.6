Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A38C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89E92082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89E92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeLKHij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:38:39 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:51158 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeLKHij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:38:39 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1gWccb-00061P-5i; Tue, 11 Dec 2018 08:38:25 +0100
Date:   Tue, 11 Dec 2018 08:38:25 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thomas Graf <tgraf@suug.ch>,
        "David S. Miller" <davem@davemloft.net>,
        NeilBrown <neilb@suse.com>, Tom Herbert <tom@quantonium.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Blakey <paulb@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] test_rhashtable: remove semaphore usage
Message-ID: <20181211073825.GT30790@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, Thomas Graf <tgraf@suug.ch>,
        "David S. Miller" <davem@davemloft.net>, NeilBrown <neilb@suse.com>,
        Tom Herbert <tom@quantonium.net>, Kees Cook <keescook@chromium.org>,
        Paul Blakey <paulb@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181210211957.210189-1-arnd@arndb.de>
 <20181211054552.peone47xl5czpfar@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211054552.peone47xl5czpfar@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 11, 2018 at 01:45:52PM +0800, Herbert Xu wrote:
> On Mon, Dec 10, 2018 at 10:17:20PM +0100, Arnd Bergmann wrote:
> > This is one of only two files that initialize a semaphore to a negative
> > value. We don't really need the two semaphores here at all, but can do
> > the same thing in more conventional and more effient way, by using a
> > single waitqueue and an atomic thread counter.
> > 
> > This gets us a little bit closer to eliminating classic semaphores from
> > the kernel. It also fixes a corner case where we fail to continue after
> > one of the threads fails to start up.
> > 
> > An alternative would be to use a split kthread_create()+wake_up_process()
> > and completely eliminate the separate synchronization.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > This is part of a longer, untested, series to remove semaphores
> > from the kernel, please review as such before applying.
> > ---
> >  lib/test_rhashtable.c | 28 ++++++++++++++++------------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> This was created by Phil Sutter so I am adding him to the cc list.

Thanks, I would have missed it otherwise. Just a minor nit:

> > diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
> > index 18de5ff1255b..12bdea4f6c20 100644
> > --- a/lib/test_rhashtable.c
> > +++ b/lib/test_rhashtable.c
[...]
> > @@ -635,8 +636,9 @@ static int threadfunc(void *data)
> >  	int i, step, err = 0, insert_retries = 0;
> >  	struct thread_data *tdata = data;
> >  
> > -	up(&prestart_sem);
> > -	if (down_interruptible(&startup_sem))
> > +	if (atomic_dec_and_test(&startup_count))
> > +		wake_up(&startup_wait);
> > +	if (wait_event_interruptible(startup_wait, atomic_read(&startup_count) == -1))
> >  		pr_err("  thread[%d]: down_interruptible failed\n", tdata->id);

The error message should probably be adjusted as well. Apart from that:

Acked-by: Phil Sutter <phil@nwl.cc>

Thanks, Phil
