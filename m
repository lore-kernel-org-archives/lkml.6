Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23266C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8C72084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8C72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeLLGuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:50:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51226 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:50:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A039D1455330F;
        Tue, 11 Dec 2018 22:50:01 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:50:00 -0800 (PST)
Message-Id: <20181211.225000.726755542677275663.davem@davemloft.net>
To:     lucien.xin@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com, dave.hansen@linux.intel.com,
        rientjes@google.com, eparis@redhat.com, khorenko@virtuozzo.com
Subject: Re: [PATCHv2 net 0/3] net: add support for flex_array_resize in
 flex_array
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1544163962.git.lucien.xin@gmail.com>
References: <cover.1544163962.git.lucien.xin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Dec 2018 22:50:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>
Date: Fri,  7 Dec 2018 14:30:32 +0800

> Without the support for the total_nr_elements's growing or shrinking
> dynamically, flex_array is not that 'flexible'. Like when users want
> to change the size, they have to redo flex_array_alloc and copy all
> the elements from the old to the new one.  The worse thing is every
> element's memory gets changed.
> 
> To implement flex_array_resize based on current code, the difficult
> thing is to process the size border of FLEX_ARRAY_BASE_BYTES_LEFT,
> where the base data memory may change to an array for the 2nd level
> data memory for growing, likewise for shrinking.
> 
> To make this part easier, we separate the base data memory and define
> FLEX_ARRAY_BASE_SIZE as a same value of FLEX_ARRAY_PART_SIZE, as Neil
> suggested.  When new size is crossing the border, the base memory is
> allocated as the array for the 2nd level data memory and its part[0]
> is pointed to the old base memory, and do the opposite for shrinking.
> 
> But it doesn't do any memory allocation or shrinking for elements in
> flex_array_resize, as which should be done by flex_array_prealloc or
> flex_array_shrink called by users.  No memory leaks can be caused by
> that.
> 
> SCTP has benefited a lot from flex_array_resize() for managing its
> stream memory so far.
> 
> v1->v2:
>   Cc LKML and more developers.

So I don't know what to do about this series.

One of the responses stated that it has been proposed to remove flex_array
and I don't know what to make of that, nor can I tell if that makes this
series inappropriate or not.
