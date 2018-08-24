Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 04:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38972156E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 04:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38972156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeHXIGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 04:06:16 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:43617 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726244AbeHXIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 04:06:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B3421837F252;
        Fri, 24 Aug 2018 04:33:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: leaf91_1d3596f189427
X-Filterd-Recvd-Size: 2019
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 Aug 2018 04:33:20 +0000 (UTC)
Message-ID: <d0ee04ea40bfc2aecd71b3ed1e1d388911b7d6cb.camel@perches.com>
Subject: Re: [PATCH] iwlwifi: d3: use struct_size() in kzalloc()
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Aug 2018 21:33:19 -0700
In-Reply-To: <CAGXu5jJxbFzKsV1=xHiKtcx+61QBsK0LYMrwo1vGNWgALzqakw@mail.gmail.com>
References: <20180824011540.GA25716@embeddedor.com>
         <CAGXu5jJxbFzKsV1=xHiKtcx+61QBsK0LYMrwo1vGNWgALzqakw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 20:03 -0700, Kees Cook wrote:
> On Thu, Aug 23, 2018 at 6:15 PM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> > 
> > struct foo {
> >         int stuff;
> >         void *entry[];
> > };

Question for Gustavo.

Did you find any existing instances that are miscalculated?

I believe there are some cases like:

	size = sizeof(struct foo) + count * sizeof(something);
	ptr = kmalloc(size);
	memset(ptr + sizeof(struct foo), 0, size - sizeof(struct foo));

where something could go wrong and not be detected.

