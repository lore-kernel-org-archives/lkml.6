Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D17C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA4320883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA4320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbeGXSpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:45:19 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37462 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388427AbeGXSpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:45:19 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fi1Fj-0002XE-AN; Tue, 24 Jul 2018 11:37:40 -0600
To:     Allen Hubbe <allenbh@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com,
        Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
References: <20180720180034.3964-1-logang@deltatee.com>
 <20180720180034.3964-5-logang@deltatee.com>
 <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
 <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com>
 <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8809f02e-93de-f81a-31e0-90f2c1983b70@deltatee.com>
Date:   Tue, 24 Jul 2018 11:37:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
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



On 24/07/18 11:26 AM, Allen Hubbe wrote:
> On Mon, Jul 23, 2018 at 12:08 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>> I don't think you'll ever have a case where two peers have the same
>> index, as the index is really an abstract concept the hardware doesn't
>> really know about.
> 
> That is the point of index, that there should never be two peers with
> the same index, and also that the range of index values is bounded.

Yes, I think we are making the same point.

> Port numbers are problematic, so I'm worried about the change to use
> port number in the client drivers instead of using index.  For
> example, this change assumes that the index value is < bits per long
> long, because the value is used in BIT_ULL(port number).

Huh?, I'm not making that change... We still use the index to refer to
the peer, but the resource we are using is based on the port number,
just as it was before my changes. Perhaps you can point out in my
patches what change you are worried about?

> Maybe I'm missing something...  In the crosslink case, there is
> another doorbell register on the other side of the crosslink.  Whether
> to use the nearby or via-crosslink doorbell depends on the peer
> index... making assumptions about the hw driver, but is that about
> right? 

Not really. Given that we know there are only two peers, we always use
the other side's doorbell register. You'd only use the nearby doorbell
register if you wanted to trigger your own interrupt -- that would be
weird and we don't really have the API sophistication to do that.

If we wanted to support multiple peers with some number in crosslink
then we'd need to revamp things _significantly_. In this case we'd have
multiple doorbell registers which each apply to a different subset of
peers. This gets _very_ complicated and hurts my head. But as I said,
I'm not trying to add new functionality for multi-peer crosslink or
anything like that. I'm just trying to fix the 2 crosslink peer case so
it works like it did when it was originally merged.

Logan
