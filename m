Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DECECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CBD20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CBD20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbeGWRJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:09:54 -0400
Received: from ale.deltatee.com ([207.54.116.67]:57702 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388121AbeGWRJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:09:54 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fhdNI-0005it-JI; Mon, 23 Jul 2018 10:07:53 -0600
To:     Allen Hubbe <allenbh@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com,
        Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
References: <20180720180034.3964-1-logang@deltatee.com>
 <20180720180034.3964-5-logang@deltatee.com>
 <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com>
Date:   Mon, 23 Jul 2018 10:07:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dmeyer@gigaio.com, shuah@kernel.org, Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, allenbh@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 4/8] NTB: ntb_pingpong: Choose doorbells based on port
 number
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/07/18 08:01 AM, Allen Hubbe wrote:
> Does this solve the issue where two of the the port numbers are the
> same, because of symmetry over a crosslink?  I think the two ports
> with the "same" number should be identified as different peer index,
> even if the port numbers are the same.

I'm not sure if it's that general. It solves it for the case that both
peers have port numbers equal to zero. It doesn't solve it for the more
general case where you may have multiple partitions, including one or
more crosslink partitions. That is _much_ harder to solve and right now
I'm only focused on fixing the code to work as it did before. If someone
is interested in making a complex setup like that work, they'll have to
figure out how and post patches.

I don't think you'll ever have a case where two peers have the same
index, as the index is really an abstract concept the hardware doesn't
really know about.

> Maybe the port of any peer connected over the crosslink should be the
> local switch's crosslink port.  

Well, the switches could in theory be configured in any way. But the
whole point and benefit of crosslink is for both switches to be
configured to be identical. The logical configuration is to configure
both hosts to be on port 0 for both switches and there's really no
benefit to doing it differently.


> The local port number might be needed
> to configure translation tables in the local switch.  

It's not. The crosslink partition between the switches would typically
always be "port number" 1. (Though there may be instances where it's a
different port number, but that shouldn't effect anything and is handled
by the driver.)

> If a globally
> unique port number is needed, maybe encode a chip number in some high
> bits of the port number?  

With crosslink, we can't figure out a chip number for the same reasons
we can't figure out a port number.

> If a locally unique port number is needed,
> maybe encode a path, that could be useful for configuring address
> translations across multiple crosslinks.  Encoding a path, then each
> port will have a different number, depending on the perspective of the
> source port, which could be confusing (already, peer index is local
> perspective, so can cause the same kind of confusion).  

I don't follow this. Any path you might get will be exactly the same for
both hosts in a symmetric crosslink configuration. The only way to find
a locally unique port number would be for the two hosts to negotiate
somehow and that's cumbersome and would introduce some randomness (based
on which of two identical machines happened to be first) into the
process which I really don't want seeing that makes debugging much more
difficult.


>IMO port
> number can be anything useful for specific ntb driver and devices, or
> maybe just be informative, but peer index should be useful for ntb
> client drivers.

Yes, the port number is commonly used to decide which resource (MW, DB,
etc) will be used to point to another peer. This is how Serge has coded
the existing clients and makes sense. The problem comes with crosslink
which can not provide these port numbers but worked fine in the previous
two-host code. These patches fix the clients so that they support
crosslink (and other two host systems) in a very similar way to how they
were supported before. In theory, we could now rip out the ugly code for
the Intel and AMD drivers that assign port numbers based on
primary/secondary and such. But I have no interest in doing so.

Logan
