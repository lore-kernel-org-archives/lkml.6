Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C7BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC381242A8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="MOS0Wr5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC381242A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeFVN1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:27:52 -0400
Received: from mout01.posteo.de ([185.67.36.65]:59816 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751315AbeFVN1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:27:51 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E65B920E33
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529674069; bh=9te1GlP18roQlxEE10FWJg39nxorUk+bQpniiOa9dFo=;
        h=Subject:To:Cc:From:Date:From;
        b=MOS0Wr5n6y2MxlNdgFChxDXyh5hkXvn9zi76XU8e2lBf3iKfY6K9DteAvpbFV8HIp
         quCCjPAkKML9bfMuJeU4AP92qNEEGg0qWYRWRlwZS6SFz6IfPI07OatsDgO5QcN0H7
         1uGcGS9BRLe7CdJhlxHHoWsXmA73zqoE3WZ171oQ4ZtvIhWKIlYsPFLfeG2hiqizuX
         OMavlW5EOt3+0n/lIbs6UXEAXFhOadwoiNnu4LsX4OGTefZPskgkXaLSOYjBEdGaR3
         I2k4fibIDi8Jkmqxb8zss1TkCeYGuqwOJHbEAjtY9BizFIps+SLLphZ5vqSFTqewBg
         WYEkXN/s1LsWg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41Bzry6qydz9rxK;
        Fri, 22 Jun 2018 15:27:46 +0200 (CEST)
Subject: Re: [PATCH] staging: rtl8723bs: fix brace coding style issues
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180621182155.27769-1-michael.straube@posteo.de>
 <20180622102800.4p6wabmte4yf4rtp@mwanda>
From:   Michael Straube <michael.straube@posteo.de>
Message-ID: <bc244970-498d-c6e7-7ed0-3c3d77777ccc@posteo.de>
Date:   Fri, 22 Jun 2018 15:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622102800.4p6wabmte4yf4rtp@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/18 12:28, Dan Carpenter wrote:
>>   	if (count < 1)
>>   		return -EFAULT;
>>   
>> -	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
>> +	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp)))
>>   		sscanf(tmp, "%u", &g_wait_hiq_empty);
>> -	}
> 
> 
> The original code is kind of bad.  The NULL check isn't required.

Just for clarification, NULL check refers to checking if buffer != NULL in the
if condition?

        if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp)))
            ~~~~~~

> The sscanf call should have error checking.  The error code is wrong if
> the copy from user fails.  The tmp buffer isn't NUL terminated.
> 
> 	if (copy_from_user(tmp, buffer, sizeof(tmp)))
> 		return -EFAULT;
> 	tmp[sizeof(tmp) - 1] = '\0';
> 
> 	if (sscanf(tmp, "%u", &g_wait_hiq_empty) != 1)
> 		return -EINVAL;
> 
> 	return count;
> 
> regards,
> dan carpenter
> 

Regards,
Michael
