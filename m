Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2BE20863
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfAaPOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:14:25 -0500
Received: from vrout30.yaziba.net ([185.56.204.33]:33328 "EHLO
        vrout30.yaziba.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:14:25 -0500
Received: from mtaout20.int.yaziba.net (mtaout20.int.yaziba.net [10.4.20.37])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by vrout30.yaziba.net (mx10.yaziba.net) with ESMTPS id D6ED952079;
        Thu, 31 Jan 2019 16:14:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaout20.int.yaziba.net (Postfix) with ESMTP id AF0DD160385;
        Thu, 31 Jan 2019 16:14:21 +0100 (CET)
Received: from mtaout20.int.yaziba.net ([127.0.0.1])
        by localhost (mtaout20.int.yaziba.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eEqP5E2SiWOb; Thu, 31 Jan 2019 16:14:21 +0100 (CET)
Received: from mail14.int.yaziba.net (mail14.int.yaziba.net [10.4.20.80])
        by mtaout20.int.yaziba.net (Postfix) with ESMTP id 803CB16037E;
        Thu, 31 Jan 2019 16:14:21 +0100 (CET)
Date:   Thu, 31 Jan 2019 16:14:20 +0100 (CET)
From:   Alexandre BESNARD <alexandre.besnard@softathome.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     davem@davemloft.net, amritha nambiar <amritha.nambiar@intel.com>,
        lirongqing@baidu.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        alexander h duyck <alexander.h.duyck@intel.com>,
        jiri@mellanox.com, petrm@mellanox.com, ecree@solarflare.com
Message-ID: <561703429.2347936.1548947660762.JavaMail.zimbra@softathome.com>
In-Reply-To: <8b654b17-f8b4-0c89-26b5-311aeb703f6d@virtuozzo.com>
References: <20190131132008.23161-1-alexandre.besnard@softathome.com> <8b654b17-f8b4-0c89-26b5-311aeb703f6d@virtuozzo.com>
Subject: Re: [PATCH] net: check negative value for signed refcnt
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.6.0_GA_1194 (ZimbraWebClient - GC70 (Linux)/8.6.0_GA_1194)
Thread-Topic: check negative value for signed refcnt
Thread-Index: 3KzVg7vew9zv0UIVA9M/skm6izA2Qg==
X-CLAMAV-SCAN: ok
X-VRSPAM-SCORE: -100
X-VRSPAM-STATE: legit
X-VRSPAM-CAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrjeeigdejhecutefuodetggdotefrucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffkjghfufggtgfgofhtsehtjegttdertdejnecuhfhrohhmpeetlhgvgigrnhgurhgvuceugffupfettfffuceorghlvgigrghnughrvgdrsggvshhnrghrugesshhofhhtrghthhhomhgvrdgtohhmqeenucfrrghrrghmpehmohguvgepshhmthhpohhuth
X-VRSPAM-EXTCAUSE: mhhouggvpehsmhhtphhouhht
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill, and thanks for your time,

On 31 Jan 19 14:49, Kirill Tkhai ktkhai@virtuozzo.com wrote :

> Hi, Alexandre,

> On 31.01.2019 16:20, alexandre.besnard@softathome.com wrote:
> > From: Alexandre Besnard <alexandre.besnard@softathome.com>

> > Device remaining references counter is get as a signed integer.

> > When unregistering network devices, the loop waiting for this counter
> > to decrement tests the 0 strict equality. Thus if an error occurs and
> > two references are given back by a protocol, we are stuck in the loop
> > forever, with a -1 value.

> > Robustness is added by checking a negative value: the device is then
> > considered free of references, and a warning is issued (it should not
> > happen, one should check that behavior)

> > Signed-off-by: Alexandre Besnard <alexandre.besnard@softathome.com>
> > ---
> > net/core/dev.c | 5 +++++
> > 1 file changed, 5 insertions(+)

> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index ddc551f..e4190ae 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -8687,6 +8687,11 @@ static void netdev_wait_allrefs(struct net_device *dev)
> > refcnt = netdev_refcnt_read(dev);

> > while (refcnt != 0) {
> > + if (refcnt < 0) {
> > + pr_warn("Device %s refcnt negative: device considered free, but it should not
> > happen\n",
> > + dev->name);
> > + break;
> > + }

> 1)I don't think this is a good approach. Negative value does not guarantee
> there is just a double put of device reference. Negative value is an indicator
> something goes wrong, and we definitely should not free device memory in
> this case.

> 2)Not related to your patch -- it looks like we have problem in existing
> code with this netdev_refcnt_read(). It does not imply a memory ordering
> or some guarantees about reading percpu values. For example, in generic
> code struct percpu_ref switches a counter into atomic mode before it checks
> for the last reference. But there is nothing in netdev_refcnt_read().

I agree with you, as it is not a full fix for a bad behavior of the refcnt: many
wrong things could happen here, and that's why I added a warning (short of a
more critical flag I could think of).

However, I think this is a good approach as a global workaround for any critical
situation caused by a negative refcnt, acting as a failsafe. What I try to avoid
here is not the bug, but a situation such as a deadlock keeping a system from
powering off, or way worse in the system life.
On the other hand, I can't think of a critical situation caused by freeing
the device memory. Processes or even systems may crash in some cases, but it
should be an expected behavior in such a case IMHO.

Actually, I think that with the current implementation, most of the systems
locked in the problem are powered off.

Do you think of any issue beyond this behavior ? 
