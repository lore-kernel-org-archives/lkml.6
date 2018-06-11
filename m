Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ldhZGjVbHlvVHQAAmS7hNA
	; Mon, 11 Jun 2018 11:22:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 26136607BB; Mon, 11 Jun 2018 11:22:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 91F2860792;
	Mon, 11 Jun 2018 11:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91F2860792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932850AbeFKLWQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932676AbeFKLWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:22:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CE5A30C10F4;
        Mon, 11 Jun 2018 11:22:15 +0000 (UTC)
Received: from [10.3.116.105] (ovpn-116-105.phx2.redhat.com [10.3.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BD7759740;
        Mon, 11 Jun 2018 11:22:14 +0000 (UTC)
Subject: Re: [PATCH] net: thunderx: prevent concurrent data re-writing by
 nicvf_set_rx_mode
To: David Miller <davem@davemloft.net>,
        Vadim.Lomovtsev@caviumnetworks.com
Cc: rric@kernel.org, sgoutham@cavium.com,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vadim.Lomovtsev@cavium.com
References: <20180608092759.28059-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180610.123551.885190586229525170.davem@davemloft.net>
From: Dean Nelson <dnelson@redhat.com>
Message-ID: <036618ae-887f-44b5-2b39-451b81191cc1@redhat.com>
Date: Mon, 11 Jun 2018 06:22:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180610.123551.885190586229525170.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 11 Jun 2018 11:22:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2018 02:35 PM, David Miller wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Date: Fri,  8 Jun 2018 02:27:59 -0700
> 
>> +	/* Save message data locally to prevent them from
>> +	 * being overwritten by next ndo_set_rx_mode call().
>> +	 */
>> +	spin_lock(&nic->rx_mode_wq_lock);
>> +	mode = vf_work->mode;
>> +	mc = vf_work->mc;
>> +	vf_work->mc = NULL;

If I'm reading this code correctly, I believe nic->rx_mode_work.mc will
have been set to NULL before the lock is dropped by
nicvf_set_rx_mode_task() and acquired by nicvf_set_rx_mode().


>> +	spin_unlock(&nic->rx_mode_wq_lock);
> 
> At the moment you drop this lock, the memory behind 'mc' can be
> freed up by:
> 
>> +	spin_lock(&nic->rx_mode_wq_lock);
>> +	kfree(nic->rx_mode_work.mc);

So the kfree() will be called with a NULL pointer and quickly return.


> 
> And you'll crash when you dereference it above via
> __nicvf_set_rx_mode_task().
> 

I believe the call to kfree() in nicvf_set_rx_mode() is there to free
up a mc_list that has been allocated by nicvf_set_rx_mode() during a
previous callback to the function, one that has not yet been processed
by nicvf_set_rx_mode_task().

In this way only the last 'unprocessed' callback to nicvf_set_rx_mode()
gets processed should there be multiple callbacks occurring between the
times the nicvf_set_rx_mode_task() runs.

In my testing with this patch, this is what I see happening.
