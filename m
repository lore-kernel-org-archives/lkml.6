Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59335C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E74D2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G6CsaDdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfBEW2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:28:49 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:36857 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfBEW2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1549405728; x=1580941728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rr6CC+Hrts3G9hUS+X5B8K994y9vEmdnUo7Xt/xUcf4=;
  b=G6CsaDdblpe+Z3Qby/bvfuw3iLl9AEVUpeXfiLxtbRpMyQQF7GORkmyx
   gDOcnxBUjO12vo5lmwqtVGCPHt5SXmpO9f2if0oFPaKmQUbI/J6C9sAAM
   TlSY+J3YqBpAldt9/MLmNWXrU8TKZK2DoJYuv9Nu2v9PSu1vQLsX01hht
   U=;
X-IronPort-AV: E=Sophos;i="5.58,337,1544486400"; 
   d="scan'208";a="785870197"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 Feb 2019 22:28:46 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id A4DC5A2487;
        Tue,  5 Feb 2019 22:28:45 +0000 (UTC)
Received: from EX13D07UWA001.ant.amazon.com (10.43.160.145) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 5 Feb 2019 22:28:45 +0000
Received: from EX13D07UWA001.ant.amazon.com (10.43.160.145) by
 EX13D07UWA001.ant.amazon.com (10.43.160.145) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 5 Feb 2019 22:28:44 +0000
Received: from EX13D07UWA001.ant.amazon.com ([10.43.160.145]) by
 EX13D07UWA001.ant.amazon.com ([10.43.160.145]) with mapi id 15.00.1367.000;
 Tue, 5 Feb 2019 22:28:44 +0000
From:   "Sobon, Przemyslaw" <psobon@amazon.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Liu Jian <liujian56@huawei.com>,
        "ikegami@allied-telesis.co.jp" <ikegami@allied-telesis.co.jp>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "joakim.tjernlund@infinera.com" <joakim.tjernlund@infinera.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Thread-Topic: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Thread-Index: AQHUu5pgPuG2fN5WMEykck2gQhFtIaXNv4mAgAQNLxA=
Date:   Tue, 5 Feb 2019 22:28:44 +0000
Message-ID: <acd16b85676e4d1d89f3acfbeda30107@EX13D07UWA001.ant.amazon.com>
References: <1548977439-318904-1-git-send-email-liujian56@huawei.com>
        <20190203092645.18d1495b@bbrezillon> <20190203093509.269bf1e1@bbrezillon>
In-Reply-To: <20190203093509.269bf1e1@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Boris Brezillon <bbrezillon@kernel.org>=20
> Sent: Sunday, February 3, 2019 12:35 AM
> > +Przemyslaw
> >=20
> > On Fri, 1 Feb 2019 07:30:39 +0800
> > Liu Jian <liujian56@huawei.com> wrote:
> >=20
> > > In function do_write_buffer(), in the for loop, there is a case
> > > chip_ready() returns 1 while chip_good() returns 0, so it never=20
> > > break the loop.
> > > To fix this, chip_good() is enough and it should timeout if it stay=20
> > > bad for a while.
> >=20
> > Looks like Przemyslaw reported and fixed the same problem.
> >=20
> > >=20
> > > Fixes: dfeae1073583(mtd: cfi_cmdset_0002: Change write buffer to=20
> > > check correct value)
> >=20
> > Can you put the Fixes tag on a single, and the format is
> >=20
> > Fixes: <hash> ("message")
> >=20
> > > Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> > > Signed-off-by: Liu Jian <liujian56@huawei.com>
> >=20
> > [1]http://patchwork.ozlabs.org/patch/1025566/
> >=20
> > > ---
> > >  drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c=20
> > > b/drivers/mtd/chips/cfi_cmdset_0002.c
> > > index 72428b6..818e94b 100644
> > > --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> > > +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> > > @@ -1876,14 +1876,14 @@ static int __xipram do_write_buffer(struct ma=
p_info *map, struct flchip *chip,
> > >  			continue;
> > >  		}
> > > =20
> > > -		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
> > > -			break;
> > > -
> > >  		if (chip_good(map, adr, datum)) {
> > >  			xip_enable(map, chip, adr);
> > >  			goto op_done;
> > >  		}
> > > =20
> > > +		if (time_after(jiffies, timeo))
> > > +			break;
> > > +
> > >  		/* Latency issues. Drop the lock, wait a while and retry */
> > >  		UDELAY(map, chip, adr, 1);
> > >  	}
> >=20
>=20
> BTW, the patch itself looks good to me. Ikegami, can you confirm it does =
the right thing?
>=20
> Thanks,
>=20
> Boris
>=20

One comment to this patch. If value is written incorrectly quickly we will =
be
stuck in the loop even though nothing is going to change. For example a val=
ue was
written incorrectly after 1us, the loop was set to 1ms, function will retur=
n
after 1ms, this solution is not optimized for performance. I considered sam=
e
when working on this change and decided to do it different way.

Regards,
Przemek
