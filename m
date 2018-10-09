Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6475FC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250BD214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PLYDvCx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250BD214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJJA3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:29:35 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60049 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbeJJA3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:29:35 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2018 20:29:34 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id F2AA22A3A;
        Tue,  9 Oct 2018 13:05:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 09 Oct 2018 13:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+qPo7Q
        LEySgnCu7BYF3Si6QdJDTci+4v1Ud7yUISl+M=; b=PLYDvCx3BEJP2X4ynoNd3n
        5MEfh21gVOrZqDHmQDxuzgVMaUKQpnldVyND3poQMN6yftENeIDIxn3+eqY7DoMV
        3/rmdUj5792qFt/mhM/AbB4lGFmPU936IVYXN7ZkkBqahzWpcxp6LZG69yrq8KJs
        VAjrHFtGpN4nBbEQx0JapFCABGBNiAJUpEd8z6TMNsMNf4L0SDCDTZySbo4rlFsU
        T0s9HdhauDc7ancaMmPwolgJ/YIDX8qFROQxlFBC4Q/QriCGMbLharOIZO+XFZog
        2PSutfyzpu/0yMuc7gNcWWJz3l/F5ckZaWyv7T5h/ROhNokOQ7uX1yJbeFpCL4Lg
        ==
X-ME-Sender: <xms:0d-8W5_ZLU3JehUsNFbO7eAEK8-khchftLKRoH7eVn_KDj9WLzJ0uw>
X-ME-Proxy: <xmx:0d-8W-PF5RY_rzz5-uU2cLTGLDJgL27ia1i9oKJWq9V4CSobFwKNsw>
    <xmx:0d-8W8PU39WeVBS5F6llUvcEciQU96IOZa65JAb3zJAJx9OiOw0MRw>
    <xmx:0d-8WxdemaWK3uuHFH7G233MGhNa8HG5EUODrWIMlJ4_7S3q58OgZQ>
    <xmx:0d-8W5fy-pfnO6j4eruilVNjNaW-l-3BLEfBHSHsXREws8zwmNSq8A>
    <xmx:0d-8W5egRb5C6l1o7i7ehDHD2OsYrlkqN8GmRPTMX2y4OS6JUA9bgw>
    <xmx:1N-8W0bqXHGmXv-CChvuyS5sLEFgindkPbEuO9m-7pjRhwf2JroyEQ>
Received: from localhost (bzq-79-182-130-87.red.bezeqint.net [79.182.130.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id D6182102F0;
        Tue,  9 Oct 2018 13:05:20 -0400 (EDT)
Date:   Tue, 9 Oct 2018 20:05:17 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, aneesh.kumar@linux.ibm.com,
        syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com
Subject: Re: general protection fault in __handle_mm_fault
Message-ID: <20181009170517.GA2821@splinter>
References: <0000000000009d47b2057782bab4@google.com>
 <CAF=yD-+7NxN37Ez=3WXG0+2i6j30uSV8u9D7oJXEhp+SxzYCpA@mail.gmail.com>
 <CAF=yD-+Qh5f9kqmYLY5EyUwNPuyhMpBxz6dh_kfzFZsgE3UijQ@mail.gmail.com>
 <87va6bwlfg.fsf@linux.ibm.com>
 <48d891dd-3f45-c03c-a55b-bb153080881a@gmail.com>
 <CAF=yD-K3BeuUWf_2RhWoC6fx=+A49Nt1TOFOfzdwKfOdsv=TiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-K3BeuUWf_2RhWoC6fx=+A49Nt1TOFOfzdwKfOdsv=TiQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 12:02:58PM -0400, Willem de Bruijn wrote:
> On Tue, Oct 9, 2018 at 11:00 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > Well, this is a C repro, you can test this yourself instead of asking Willem who
> > already did a painful bisection.
> 
> Thanks Eric. It does take some effort to get the syzkaller environment
> up and running [1] and I happen to have it ready, so I don't mind testing
> a few patches.

It is possible to ask syzbot to test the patch. I sent a couple of
patches and got a response in 20-30 minutes. Very convenient.

It is mentioned at the bottom of the report:

"
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
"
