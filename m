Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D70C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660F220779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660F220779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeI2Dkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:40:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeI2Dkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:40:45 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4DF09D1E;
        Fri, 28 Sep 2018 21:15:10 +0000 (UTC)
Date:   Fri, 28 Sep 2018 14:15:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     gorcunov@openvz.org, mhocko@suse.com, aryabinin@virtuozzo.com,
        hannes@cmpxchg.org, penguin-kernel@I-love.SAKURA.ne.jp,
        shakeelb@google.com, jbacik@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix int overflow in callers of do_shrink_slab()
Message-Id: <20180928141509.fd8f8ac8c0ea61f0cb79d494@linux-foundation.org>
In-Reply-To: <153813407177.17544.14888305435570723973.stgit@localhost.localdomain>
References: <153813407177.17544.14888305435570723973.stgit@localhost.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 14:28:32 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> do_shrink_slab() returns unsigned long value, and
> the placing into int variable cuts high bytes off.
> Then we compare ret and 0xfffffffe (since SHRINK_EMPTY
> is converted to ret type).
> 
> Thus, big number of objects returned by do_shrink_slab()
> may be interpreted as SHRINK_EMPTY, if low bytes of
> their value are equal to 0xfffffffe. Fix that
> by declaration ret as unsigned long in these functions.

Sigh.  How many times has this happened.

> Reported-by: Cyrill Gorcunov <gorcunov@openvz.org>

What did he report?  Was it code inspection?  Did the kernel explode? 
etcetera.  I'm thinking that the fix should be backported but to
determine that, we need to understand the end-user runtime effects, as
always.  Please.

