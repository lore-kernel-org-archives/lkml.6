Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ACDC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE840217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfBEUSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:18:16 -0500
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:33641 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726547AbfBEUSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:18:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6FB16100E86C5;
        Tue,  5 Feb 2019 20:18:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: juice35_81a31fe1f8d49
X-Filterd-Recvd-Size: 1737
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Feb 2019 20:18:10 +0000 (UTC)
Message-ID: <4aea523a3bc5be0d944f7ed9fadac276b7115002.camel@perches.com>
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
From:   Joe Perches <joe@perches.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, thierry.reding@gmail.com
Cc:     hkallweit1@gmail.com, andrew@lunn.ch, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Feb 2019 12:18:09 -0800
In-Reply-To: <ca6ca816-af03-e1f9-739a-a06cc4837b80@gmail.com>
References: <20190204164213.30727-1-thierry.reding@gmail.com>
         <20190204164213.30727-2-thierry.reding@gmail.com>
         <20190204.192040.1074738183781998611.davem@davemloft.net>
         <8553086eaec167846992f1cff12aa388cee81767.camel@perches.com>
         <ca6ca816-af03-e1f9-739a-a06cc4837b80@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 12:04 -0800, Eric Dumazet wrote:
> 
> On 02/05/2019 10:42 AM, Joe Perches wrote:
> > It's declared after a pointer so it is already is 2 byte aligned.
> > 
> > A lot of drivers wouldn't work otherwise.
> 
> Maybe these drivers are only used on arches where this does not matter.

Possible.

I had only grepped through the sources looking for
declarations using:

$ git grep -B1 '\[ETH_ALEN\];' -- '*.c' | grep -A1 '\*'

It's quite a few files in net/ too btw.

I still think adding __align(<even#>) is unnecessary here unless
it follows something like a bool or a u8.


