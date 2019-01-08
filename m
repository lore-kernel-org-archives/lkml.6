Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4861CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE5C2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="XncHBT5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfAHGEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:04:07 -0500
Received: from mail.synology.com ([211.23.38.101]:55387 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727408AbfAHGEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:04:07 -0500
Subject: Re: [PATCH 1/1] net: bridge: fix a bug on using a neighbour cache
 entry without checking its state
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1546927439; bh=IkBoqKAePbKj6cjh5W5/WkX3c9rVHT016AAtBwVI9lY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XncHBT5XOVbCt87AxkwhwoBMW4mCnZXueAgWbbV1KTDV4+TxLPj+H8ytNMGfHBMIQ
         yDs+oLQRqDXZWXGVjpfRJa4A3gWvp0kOiR9JjwKR28oG7EMTn9fWfhZIUjY1bprgVI
         GJ1x9n74tz1VN34aVoCC/87vgfoV6Zu9U6FnhoIs=
To:     David Miller <davem@davemloft.net>
Cc:     nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, JianJhen Chen <kchen@synology.com>,
        linux-kernel@vger.kernel.org
References: <1546745293-5678-1-git-send-email-kchen@synology.com>
 <20190107.091031.100384065611982323.davem@davemloft.net>
From:   kchen <kchen@synology.com>
Message-ID: <c1c44397-057c-1ce6-dd52-62f15066e203@synology.com>
Date:   Tue, 8 Jan 2019 14:04:04 +0800
MIME-Version: 1.0
In-Reply-To: <20190107.091031.100384065611982323.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: David Miller <davem@davemloft.net>
Date: Mon, 07 Jan 2019 09:10:31 -0800

 > From: David Miller <davem@davemloft.net>
 >
> From: kchen <kchen@synology.com>
> Date: Sun,  6 Jan 2019 11:28:13 +0800
> 
>> From: JianJhen Chen <kchen@synology.com>
>>
>> When handling DNAT'ed packets on a bridge device, the neighbour cache entry
>> from lookup was used without checking its state. It means that a cache entry
>> in the NUD_STALE state will be used directly instead of entering the NUD_DELAY
>> state to confirm the reachability of the neighbor.
>>
>> This problem becomes worse after commit 2724680bceee ("neigh: Keep neighbour
>> cache entries if number of them is small enough."), since all neighbour cache
>> entries in the NUD_STALE state will be kept in the neighbour table as long as
>> the number of cache entries does not exceed the value specified in gc_thresh1.
>>
>> This commit validates the state of a neighbour cache entry before using
>> the entry.
>>
>> Signed-off-by: JianJhen Chen <kchen@synology.com>
>> Reviewed-by: JinLin Chen <jlchen@synology.com>
> 
> Indeed, this looks correct.
> 
> Applied and queued up for -stable, thanks.
> 

Thank you for the confirmation.
