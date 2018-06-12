Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 209E4C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59CB2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59CB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934948AbeFLWZm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:25:42 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42774 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934418AbeFLWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:25:41 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BBE2C100AB41B;
        Tue, 12 Jun 2018 15:25:40 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:25:40 -0700 (PDT)
Message-Id: <20180612.152540.1304714747425091865.davem@davemloft.net>
To:     dnelson@redhat.com
Cc:     Vadim.Lomovtsev@caviumnetworks.com, rric@kernel.org,
        sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH] net: thunderx: prevent concurrent data re-writing by
 nicvf_set_rx_mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <036618ae-887f-44b5-2b39-451b81191cc1@redhat.com>
References: <20180608092759.28059-1-Vadim.Lomovtsev@caviumnetworks.com>
        <20180610.123551.885190586229525170.davem@davemloft.net>
        <036618ae-887f-44b5-2b39-451b81191cc1@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Jun 2018 15:25:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dean Nelson <dnelson@redhat.com>
Date: Mon, 11 Jun 2018 06:22:14 -0500

> On 06/10/2018 02:35 PM, David Miller wrote:
>> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
>> Date: Fri,  8 Jun 2018 02:27:59 -0700
>> 
>>> +	/* Save message data locally to prevent them from
>>> +	 * being overwritten by next ndo_set_rx_mode call().
>>> +	 */
>>> +	spin_lock(&nic->rx_mode_wq_lock);
>>> +	mode = vf_work->mode;
>>> +	mc = vf_work->mc;
>>> +	vf_work->mc = NULL;
> 
> If I'm reading this code correctly, I believe nic->rx_mode_work.mc
> will
> have been set to NULL before the lock is dropped by
> nicvf_set_rx_mode_task() and acquired by nicvf_set_rx_mode().
> 
> 
>>> +	spin_unlock(&nic->rx_mode_wq_lock);
>> At the moment you drop this lock, the memory behind 'mc' can be
>> freed up by:
>> 
>>> +	spin_lock(&nic->rx_mode_wq_lock);
>>> +	kfree(nic->rx_mode_work.mc);
> 
> So the kfree() will be called with a NULL pointer and quickly return.
> 
> 
>> And you'll crash when you dereference it above via
>> __nicvf_set_rx_mode_task().
>> 
> 
> I believe the call to kfree() in nicvf_set_rx_mode() is there to free
> up a mc_list that has been allocated by nicvf_set_rx_mode() during a
> previous callback to the function, one that has not yet been processed
> by nicvf_set_rx_mode_task().
> 
> In this way only the last 'unprocessed' callback to
> nicvf_set_rx_mode()
> gets processed should there be multiple callbacks occurring between
> the
> times the nicvf_set_rx_mode_task() runs.
> 
> In my testing with this patch, this is what I see happening.

You're right, my bad.

Patch applied.
