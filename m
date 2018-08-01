Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7FCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1441208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1441208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbeHAMym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:54:42 -0400
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:36809 "EHLO
        5.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbeHAMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:54:42 -0400
Received: from player798.ha.ovh.net (unknown [10.109.160.226])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7ABB3117474
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 12:52:28 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player798.ha.ovh.net (Postfix) with ESMTPSA id CDD835400C5;
        Wed,  1 Aug 2018 12:52:23 +0200 (CEST)
Date:   Wed, 1 Aug 2018 12:52:22 +0200
From:   Greg Kurz <groug@kaod.org>
To:     piaojun <piaojun@huawei.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
Subject: Re: [PATCH] net/9p/trans_virtio.c: add a terminal char for mount
 tag
Message-ID: <20180801125222.3ba39416@bahia.lan>
In-Reply-To: <5B616E3B.4050205@huawei.com>
References: <5B6164F6.60004@huawei.com>
        <20180801081157.GA20127@nautica>
        <5B616E3B.4050205@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10442721637903210982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrledvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 16:24:27 +0800
piaojun <piaojun@huawei.com> wrote:

> Hi Dominique,
> 
> On 2018/8/1 16:11, Dominique Martinet wrote:
> > piaojun wrote on Wed, Aug 01, 2018:  
> >> chan->tag has no terminal char at last which will result in printing messy
> >> code when debugging code. So we should add '\0' for tag.  
> > 
> > 9p is full of non null-terminated string so I'm not sure how I feel
> > about it, is there anything wrong with how this is used or was this just
> > when you tried to printf it?  
> 

The mount tag isn't a 9P thingy actually. It is provided by the server
in the device config space, and it is never used in any 9P message.
It could have been a nul terminated string from the beginning. Not
sure why people opted to store it that way.

> There is nothing wrong at the places using tag, as they calculated the
> tag_len carefully. Adding '\0' for it will make the code more robust. And
> I'm glad to hear others' opinions.
> 

So this patch basically turns chan->tag into a nul terminated string,
which is indeed more convenient and robust. Maybe you can update the
rest of the code accordingly and drop chan->tag_len then ?

> Thanks,
> Jun
> 
> > 
> > If it's just for debugging I'd suggest using the printf format "%.*s"
> > with "chan->tag_len, chan->tag" arguments,

FWIW, 9P strings received from the client are also converted to
nul terminated strings:

static int
p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
	va_list ap)
{
[...]
		case 's':{
[...]
				*sptr = kmalloc(len + 1, GFP_NOFS);
[...]
					(*sptr)[len] = 0;
			}


Cheers,

--
Greg

> > 
> > 
> > That said it's not like this is costly, so I'll take it if someone else
> > thinks this is helpful
> >   
> >>
> >> Signed-off-by: Jun Piao <piaojun@huawei.com>
> >> ---
> >>  net/9p/trans_virtio.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> >> index d422bfc..49d71d6 100644
> >> --- a/net/9p/trans_virtio.c
> >> +++ b/net/9p/trans_virtio.c
> >> @@ -585,7 +585,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
> >>  		err = -EINVAL;
> >>  		goto out_free_vq;
> >>  	}
> >> -	tag = kmalloc(tag_len, GFP_KERNEL);
> >> +	tag = kzalloc(tag_len + 1, GFP_KERNEL);
> >>  	if (!tag) {
> >>  		err = -ENOMEM;
> >>  		goto out_free_vq;
> >> --   

