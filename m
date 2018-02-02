Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AH8x227Ey381mz1td7vi9CaM7dpXKulipBefPtGEfKABHBBYo+c5eFI7UebqcW8oB5j48j+zF8F4
ARC-Seal: i=1; a=rsa-sha256; t=1517551981; cv=none;
        d=google.com; s=arc-20160816;
        b=D7b8HIOmZ39pZmeZk7Y2N6IHgc5VhZcO/Gib8ikVesXuKN10tYn8RFi5u+o5xOLBqy
         oKZJUmDvbo5bNRVTkxxvAISimGE9NbjiZEGfYKqWlZFiC8i7aAG3zyaS3jcQfZyxlVZL
         BCDtnDw14pQEHqOYmrDZIHgLd9Rib4ndJiDZq10mKnt/x52xLrDJ88B+SYw2ghUL+48f
         m3dGJ9q4zZXHvLAyWrRmkV4myr4qrFntqnrzFue+j1FNZcOUPx8JGZ8ICuy0aS2NQZ2B
         L+vA/F2uG3b28SbY3LD2zH4b1YtHOqwEJDTcQApK/dq0G+ZkFyWx4icbqd5YR9I1EMim
         eqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=dgKfSzBIeioyhmgTBc/0UTUxAeNLDFRPP9Utxl2VFGo=;
        b=arZcwXmzFJubw1tZ+asqr107hnxnUUcY/2ovyU6HgJq+jKCnpGc1XAyTfWqGBWXY++
         hC4LljYXV3DJsogfP+CWDPkPeeWkQGxx6q1A8y4KjA3cJeVte1Bmki/gFtloz8IgA+mR
         Nh67Dx5Au8BQ25L+naB2Rpcpus7bZiQbUbHevBIuiJijRqHC+0mPCWMBFEmo7mojcfyk
         I493OUFf0LgnbI4+Whb9pa2m40Os6Rsv1WiDC1qMO4RnxI0PIKl3goOoYZB+8a1AoHFy
         BsPFIngSEi0EUNY0/cRmeZiMFB160CVRZzYNBsHhFpn14TMzhPUl5Ih705PVeR2vUeE6
         52rA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, gregkh@linuxfoundation.org
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 linux-kernel@vger.kernel.org
References: <a01cedbc-ca1a-3e3d-cf2c-3e995c63f793@csail.mit.edu>
 <ce6d8040-3a1e-4137-e7b1-2066b9e56f42@deltatee.com>
 <e23b4d8f-9391-d214-e370-548244339cfb@csail.mit.edu>
 <c4e3aba6-74ac-f19f-47eb-45484e18630a@deltatee.com>
 <b5609789-cc3e-57b9-1848-57b462fe9b0f@csail.mit.edu>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ffed4551-fbd0-481f-63f1-aea489395f18@deltatee.com>
Date: Thu, 1 Feb 2018 23:12:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <b5609789-cc3e-57b9-1848-57b462fe9b0f@csail.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, bfields@fieldses.org, jlayton@poochiereds.net, axboe@kernel.dk, gregkh@linuxfoundation.org, srivatsa@csail.mit.edu
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: Change in register_blkdev() behavior
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591067494565207085?=
X-GMAIL-MSGID: =?utf-8?q?1591268586675923859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 01/02/18 07:17 PM, Srivatsa S. Bhat wrote:
> Thank you for confirming! I'll send a patch to fix that (and the analogous
> case for CHRDEV_MAJOR_DYN_EXT_END).

Great! Thanks!

>>>
>>>                  for (cd = chrdevs[major_to_index(i)]; cd; cd = cd->next)
>>>                          if (cd->major == i)
>>>                                  break;
>>>
>>>                  if (cd == NULL || cd->major != i)
>>>                                       ^^^^^^^^
>>> It seems that this latter condition is unnecessary, as it will never be
>>> true. (We'll reach here only if cd == NULL or cd->major == i).
>>
>> Not quite. chrdevs[] may contain majors that also hit on the hash but don't equal 'i'. So the for loop will iterate through all hashes matching 'i' and if there is one or more and they all don't match 'i', it will fall through the loop and cd will be set to something non-null and not equal to i.
>>
> 
> Hmm, the code doesn't appear to be doing that though? The loop's fall
> through occurs one past the last entry, when cd == NULL. The only
> other way it can exit the loop is if it hits the break statement
> (which implies that cd->major == i). So what am I missing?

Oh, yup, you're right. Looking at it a second (or third) time, it should
be NULL or equal to 'i'.

Thanks,

Logan
