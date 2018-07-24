Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF2AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21F320875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21F320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbeGXTbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:31:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37802 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388463AbeGXTbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:31:06 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fi1xp-0003VV-Rp; Tue, 24 Jul 2018 12:23:14 -0600
To:     Allen Hubbe <allenbh@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com,
        Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
References: <20180720180034.3964-1-logang@deltatee.com>
 <20180720180034.3964-5-logang@deltatee.com>
 <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
 <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com>
 <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
 <8809f02e-93de-f81a-31e0-90f2c1983b70@deltatee.com>
 <CAJ80sauPtUBJ5q9iSGPArwvetBwEkjNaRmS_6adP5moK5ejLqg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8bc2ed4f-f032-c969-2e7f-f00135f567ec@deltatee.com>
Date:   Tue, 24 Jul 2018 12:23:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ80sauPtUBJ5q9iSGPArwvetBwEkjNaRmS_6adP5moK5ejLqg@mail.gmail.com>
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



On 24/07/18 12:12 PM, Allen Hubbe wrote:
> On Tue, Jul 24, 2018 at 1:37 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>> Not really. Given that we know there are only two peers, we always use
>> the other side's doorbell register. You'd only use the nearby doorbell
>> register if you wanted to trigger your own interrupt -- that would be
>> weird and we don't really have the API sophistication to do that.
>>
>> If we wanted to support multiple peers with some number in crosslink
>> then we'd need to revamp things _significantly_. In this case we'd have
>> multiple doorbell registers which each apply to a different subset of
>> peers. This gets _very_ complicated and hurts my head.
> 
> ...huh, looks like peer index was omitted from ntb_peer_db_set and
> friends.  Adding peer index there would make the interface consistent
> with other ntb_peer functions.  Peer index would allow the hw driver
> to select which doorbell register to use for each peer.  Adding a
> ntb_peer_db_valid_bits to that would allow a subset of bits in the
> shared register to be associated with each peer.

The way the switch hardware works (switchtec and I assume IDT) is that
there is only one doorbell register for all peers which can trigger any
peer that doesn't have the corresponding bit masked. So the way it was
designed without the index maxes sense except when we start to add
multi-peer crosslink insanity. I don't think adding a peer index would
be sufficient as the clients would need to know which peers share which
doorbells.

If I were to attempt something like this, I'd probably look at
introducing a segment index to the entire API. So that each switch in a
crosslink topology is it's own segment with it's own set of peers, peer
index space, doorbell registers, etc. But that's all very complicated
and messy and probably something I wouldn't even look at until we have
finished with traditional multi-host setups.

> I thought for sure ntb_peer_db_set already had peer index, and I was
> wrong.  Go ahead with the change as in your patch, I won't force the
> issue or that you to do that extra work and touch all the drivers
> again for this.  It can be addressed when there is renued interest in
> making things work more than one peer.
> 
> This patch, and the others in this series:
> Acked-by: Allen Hubbe <allenbh@gmail.com>

Thanks!

Logan

