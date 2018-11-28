Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0171C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C3A20851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d573jxsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C3A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeK1LWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:22:43 -0500
Received: from m12-17.163.com ([220.181.12.17]:44092 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeK1LWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=UrLL+
        9QTj8uhVVoUAxVSxOzu5I9ezaM0pm9Gx/ykTvo=; b=d573jxsirO70Eqn81c4Fw
        n9idpvBjlSLd4gqYAUF96RzwsccvQgOrCx2SA0oKiAeA+cwZ7YAKaiwpeC8+PX6j
        h+V2evMagXfYGbx7B/z3e6IQyWpFWzKdIv5lRclwstp0JlZ56gAuRT7WucHCNKaf
        RzkYFkcdkpGmKAU/xFKY6A=
Received: from bp (unknown [106.120.213.96])
        by smtp13 (Coremail) with SMTP id EcCowABHp3ff3_1bmZmeBw--.48468S2;
        Wed, 28 Nov 2018 08:22:55 +0800 (CST)
Date:   Wed, 28 Nov 2018 08:22:57 +0800
From:   PanBian <bianpan2016@163.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] libceph: fix use after free
Message-ID: <20181128002257.GA38329@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1543310472-31861-1-git-send-email-bianpan2016@163.com>
 <CAOi1vP8Ff9HLF_v93RwyW4LwQ5jYPWPaZhqBgx9FsxmXH6M4AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP8Ff9HLF_v93RwyW4LwQ5jYPWPaZhqBgx9FsxmXH6M4AQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: EcCowABHp3ff3_1bmZmeBw--.48468S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1ktr4kWF18Aw15tr1DWrg_yoW8Gw17pF
        Z5GF1jkay7u3WxWanFyFsYqF18CwsxtF47Wr4UCF1rKF98Wr1rXFW0ka90gFy3ur4xJF1v
        yrWxtay5XF15AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bUtC7UUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQBMNclSIYU1-ZwAAsE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:17:26AM +0100, Ilya Dryomov wrote:
> On Tue, Nov 27, 2018 at 10:22 AM Pan Bian <bianpan2016@163.com> wrote:
> >
> > The function ceph_monc_handle_map calls kfree(old) to free the old
> > monitor map, old points to monc->monmap. However, after that, it reads
> > monc->monmap->epoch and passes it to __ceph_monc_got_map. This will
> > result in a use-after-free bug. The patch moves the free operation after
> > the call to __ceph_monc_got_map.
> >
> > Fixes: 82dcabad750 ("libceph: revamp subs code, switch to SUBSCRIBE2 protocol")
> >
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
> > V2: correct the format of the tag Fixes
> > ---
> >  net/ceph/mon_client.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > index 18deb3d..05ef5aa 100644
> > --- a/net/ceph/mon_client.c
> > +++ b/net/ceph/mon_client.c
> > @@ -478,9 +478,10 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
> >         }
> >
> >         client->monc.monmap = monmap;
> 
> monc->monmap is assigned here.  It's not obvious, but monc->monmap and
> client->monc.monmap is the same pointer.
> 
> > -       kfree(old);
> >
> >         __ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
> 
> ceph_monmap_decode() returns the new map, kfree() frees the old map.
> I don't see a use-after-free here.

Got it. Thank you!

Pan

> 
> Thanks,
> 
>                 Ilya

