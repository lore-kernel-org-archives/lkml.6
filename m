Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD1C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 18:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF70F20882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 18:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF70F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeJHBWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 21:22:54 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:52539 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeJHBWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 21:22:54 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6827C101C04AD;
        Sun,  7 Oct 2018 20:14:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 19A3AAEB0; Sun,  7 Oct 2018 20:14:44 +0200 (CEST)
Date:   Sun, 7 Oct 2018 20:14:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     =?iso-8859-1?B?Smk/P+0gUO1ya28=?= <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
Message-ID: <20181007181444.wohudtigexv56b77@wunner.de>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006065819.GD3061@nanopsycho.orion>
 <CAHmME9pKvUOaAHhe7gb3yH4jdkdTtLv+gUqdnh3bJZcN776UWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pKvUOaAHhe7gb3yH4jdkdTtLv+gUqdnh3bJZcN776UWQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 07:26:47PM +0200, Jason A. Donenfeld wrote:
> On Sat, Oct 6, 2018 at 9:03 AM Jiri Pirko <jiri@resnulli.us> wrote:
> > >+      wg->incoming_handshakes_worker =
> > >+              wg_packet_alloc_percpu_multicore_worker(
> > >+                              wg_packet_handshake_receive_worker, wg);
> > >+      if (!wg->incoming_handshakes_worker)
> > >+              goto error_2;
> >
> >
> > Please consider renaming the label to "what went wrong". In this case,
> > it would be "err_alloc_worker".

Dan Carpenter, who has probably become the world expert on error paths
in the kernel due to his work on smatch, recommends naming the labels
not "what went wrong" but rather what the error path is going to do,
in this case "err_free_incoming_handshakes_worker" (abbreviate to
"err_free_incoming" or some such):

https://lkml.org/lkml/2016/8/22/374


> > >+      pr_debug("%s: Interface created\n", dev->name);
> > >+      return ret;
> > >+
> > >+error_9:
> > >+      wg_ratelimiter_uninit();
> > >+error_8:
> > >+      wg_packet_queue_free(&wg->decrypt_queue, true);
> > >+error_7:
> > >+      wg_packet_queue_free(&wg->encrypt_queue, true);
> > >+error_6:
> > >+      destroy_workqueue(wg->packet_crypt_wq);
> > >+error_5:
> > >+      destroy_workqueue(wg->handshake_send_wq);
> > >+error_4:
> > >+      destroy_workqueue(wg->handshake_receive_wq);
> > >+error_3:
> > >+      free_percpu(wg->incoming_handshakes_worker);
> > >+error_2:
> > >+      free_percpu(dev->tstats);
> > >+error_1:
> > >+      return ret;
> > >+}
> 
> I'll change away from using error_9,8,7,6,5,4,3,2,1 because of your
> suggestion -- and because it's the norm in the kernel to use real
> names. But, I would be interested in your opinion on the numerical
> errors' reasoning for existing in the first place. The idea was that
> with so many different failure cases that need to cascade in the
> correct order, it's much easier to visually inspect that it's been
> done right by observing up top 1,2,3,4,5,6,7,8,9 and at the bottom
> 9,8,7,6,5,4,3,2,1, rather than having to store in my brain's limited
> stack space what each name pertains to and keep track of the ordering
> and such. In light of that, do you still think that following the
> convention of textual error labels is a good match here? Again, I'm
> changing this for v8, but I am nonetheless curious about what you
> think.

Apart from Dan's clarity argument, what if you need to insert another
step to create the interface, thereby necessitating another step in
the error path?  Are you going to call it 4a, 4b, ...?  Because you
don't want to inflate that future patch by renaming every single
label.

Thanks,

Lukas
