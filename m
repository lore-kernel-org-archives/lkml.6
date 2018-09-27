Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD76C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3D520833
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O0Ibmek5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3D520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeI0Qb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:31:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeI0Qb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aiYjMJcOoisqKPs4mk5Os4vN294MVEzAtC4JMKtGjjg=; b=O0Ibmek5dldeGt5EKe9P961uQ
        ECW30pfWu0A2ovGKVPNWALasMkIaFeD/AWMAhbbZQ6ZeuqcuIDjnU+L4eK6jx/hr4HtmuSzvHwODW
        gwsYSf0gbPJUSJpP4SOrhEeP2a5+c2MJtwbxP3Pl788U9QnbT8DoKXeCifrDzgzp2Y57ztaVXEltm
        76TjLakh21oqcHaTrwwZ8eBxf3RUw2VrAbORGstKmxHtGofTfo6Ra8zt/O9cbPGg8rTnf24SUK1v8
        ylXTZv7af6U54FpUw0cmJLbTAmAWjo9rVUR7F5Gl0cjMsViIQmTuVEsR3amjmx/xnih5yQL34csnc
        Gr2pykaYQ==;
Received: from 177.41.129.251.dynamic.adsl.gvt.net.br ([177.41.129.251] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5TIc-0006Ks-Td; Thu, 27 Sep 2018 10:13:55 +0000
Date:   Thu, 27 Sep 2018 07:13:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/2] media: intel-ipu3: allow the media graph to be used
 even if a subdev fails
Message-ID: <20180927071330.1fa3cfdd@coco.lan>
In-Reply-To: <0e31ae40-276e-22be-c6aa-b62f8dbea79e@xs4all.nl>
References: <20180904113018.14428-1-javierm@redhat.com>
        <0e31ae40-276e-22be-c6aa-b62f8dbea79e@xs4all.nl>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 27 Sep 2018 11:52:35 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> Hi Javier,
>=20
> On 09/04/2018 01:30 PM, Javier Martinez Canillas wrote:
> > Hello,
> >=20
> > This series allows the ipu3-cio2 driver to properly expose a subset of =
the
> > media graph even if some drivers for the pending subdevices fail to pro=
be.
> >=20
> > Currently the driver exposes a non-functional graph since the pad links=
 are
> > created and the subdev dev nodes are registered in the v4l2 async .comp=
lete
> > callback. Instead, these operations should be done in the .bound callba=
ck.
> >=20
> > Patch #1 just adds a v4l2_device_register_subdev_node() function to all=
ow
> > registering a single device node for a subdev of a v4l2 device.
> >=20
> > Patch #2 moves the logic of the ipu3-cio2 .complete callback to the .bo=
und
> > callback. The .complete callback is just removed since is empy after th=
at. =20
>=20
> Sorry, I missed this series until you pointed to it on irc just now :-)
>=20
> I have discussed this topic before with Sakari and Laurent. My main probl=
em
> with this is how an application can discover that not everything is onlin=
e?
> And which parts are offline?

Via the media controller? It should be possible for an application to see
if a videonode is missing using it.

> Perhaps a car with 10 cameras can function with 9, but not with 8. How wo=
uld
> userspace know?

I guess this is not the only case where someone submitted a patch for
a driver that would keep working if some device node registration fails.

It could be just d=C3=A9j=C3=A0 vu, but I have a vague sensation that I mer=
ged something=20
similar to it in the past on another driver, but I can't remember any detai=
ls.

>=20
> I completely agree that we need to support these advanced scenarios (incl=
uding
> what happens when a camera suddenly fails), but it is the userspace aspec=
ts
> for which I would like to see an RFC first before you can do these things.

Dynamic runtime fails should likely rise some signal. Perhaps a sort of
media controller event?

>=20
> Regards,
>=20
> 	Hans
>=20
> >=20
> > Best regards,
> > Javier
> >=20
> >=20
> > Javier Martinez Canillas (2):
> >   [media] v4l: allow to register dev nodes for individual v4l2 subdevs
> >   media: intel-ipu3: create pad links and register subdev nodes at bound
> >     time
> >=20
> >  drivers/media/pci/intel/ipu3/ipu3-cio2.c | 66 ++++++-----------
> >  drivers/media/v4l2-core/v4l2-device.c    | 90 ++++++++++++++----------
> >  include/media/v4l2-device.h              | 10 +++
> >  3 files changed, 85 insertions(+), 81 deletions(-)
> >  =20
>=20



Thanks,
Mauro
