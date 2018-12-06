Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C1BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C351421479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C351421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeLFK1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:27:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:39746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFK1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:27:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A26BACCC;
        Thu,  6 Dec 2018 10:27:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Dec 2018 11:27:36 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jason Baron <jbaron@akamai.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
In-Reply-To: <20181206030818.vu5g3edwl67tg3lc@linux-r8p5>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <45bce871-edfd-c402-acde-2e57e80cc522@akamai.com>
 <20181206030818.vu5g3edwl67tg3lc@linux-r8p5>
Message-ID: <51d9ca4acbbdb17a390383b839f1aba0@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-06 04:08, Davidlohr Bueso wrote:
>> On 12/3/18 6:02 AM, Roman Penyaev wrote:
> 
>>>  		if (!ep_is_linked(epi)) {
>>> -			list_add_tail(&epi->rdllink, &ep->rdllist);
>>> +			/* Reverse ->ovflist, events should be in FIFO */
>>> +			list_add(&epi->rdllink, &ep->rdllist);
>>>  			ep_pm_stay_awake(epi);
>>>  		}
> 
> This should probably a separate patch as it fixes the ordering,
> regardless of the rwlock+xchg optimization.

Yes, should not be a part of this RFC.  Thanks.

--
Roman

