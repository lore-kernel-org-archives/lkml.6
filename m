Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF88C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C2020838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C2020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbeLFK0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:26:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:39292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFK0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:26:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF3FBACA4;
        Thu,  6 Dec 2018 10:25:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Dec 2018 11:25:57 +0100
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
In-Reply-To: <20181206040430.d7wjik6lt7kr75m6@linux-r8p5>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <45bce871-edfd-c402-acde-2e57e80cc522@akamai.com>
 <20181206040430.d7wjik6lt7kr75m6@linux-r8p5>
Message-ID: <98d200aa103fd6086c02dd620b65e961@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-06 05:04, Davidlohr Bueso wrote:
> On 12/3/18 6:02 AM, Roman Penyaev wrote:
> 
>> The main change is in replacement of the spinlock with a rwlock, which 
>> is
>> taken on read in ep_poll_callback(), and then by adding poll items to 
>> the
>> tail of the list using xchg atomic instruction.  Write lock is taken
>> everywhere else in order to stop list modifications and guarantee that 
>> list
>> updates are fully completed (I assume that write side of a rwlock does 
>> not
>> starve, it seems qrwlock implementation has these guarantees).
> 
> Its good then that Will recently ported qrwlocks to arm64, which iirc 
> had
> a bad case of writer starvation. In general, qrwlock will maintain 
> reader
> to writer ratios of acquisitions fairly well, but will favor readers 
> over
> writers in scenarios where when too many tasks (more than ncpus).

Thanks for noting that.  Then that should not be a problem, since number 
of
parallel ep_poll_callback() calls can't be greater then number of CPUs
because of the wq.lock which is taken by the caller of 
ep_poll_callback().

BTW, did someone make any estimations how much does the latency on the
write side increase if the number of readers is greater than CPUs?

--
Roman

