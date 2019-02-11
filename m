Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6FE21B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbfBKPdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:33:35 -0500
Received: from www62.your-server.de ([213.133.104.62]:41086 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfBKPdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:33:33 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gtDaM-0007KE-6j; Mon, 11 Feb 2019 16:33:30 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gtDaL-000Ow1-WC; Mon, 11 Feb 2019 16:33:30 +0100
Subject: Re: [PATCH 1/2] xsk: do not use mmap_sem
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Bjorn Topel <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Netdev <netdev@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, dan.j.williams@intel.com
References: <20190207053740.26915-1-dave@stgolabs.net>
 <20190207053740.26915-2-dave@stgolabs.net>
 <CAJ+HfNg=Wikc_uY9W1QiVCONq3c1GyS44-xbrq-J4gqfth2kwQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d92b7b49-81e6-1ac5-4ae4-4909f87bbea8@iogearbox.net>
Date:   Mon, 11 Feb 2019 16:33:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAJ+HfNg=Wikc_uY9W1QiVCONq3c1GyS44-xbrq-J4gqfth2kwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25357/Mon Feb 11 11:38:50 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Dan ]

On 02/07/2019 08:43 AM, Björn Töpel wrote:
> Den tors 7 feb. 2019 kl 06:38 skrev Davidlohr Bueso <dave@stgolabs.net>:
>>
>> Holding mmap_sem exclusively for a gup() is an overkill.
>> Lets replace the call for gup_fast() and let the mm take
>> it if necessary.
>>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Bjorn Topel <bjorn.topel@intel.com>
>> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
>> CC: netdev@vger.kernel.org
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>> ---
>>  net/xdp/xdp_umem.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
>> index 5ab236c5c9a5..25e1e76654a8 100644
>> --- a/net/xdp/xdp_umem.c
>> +++ b/net/xdp/xdp_umem.c
>> @@ -265,10 +265,8 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem)
>>         if (!umem->pgs)
>>                 return -ENOMEM;
>>
>> -       down_write(&current->mm->mmap_sem);
>> -       npgs = get_user_pages(umem->address, umem->npgs,
>> -                             gup_flags, &umem->pgs[0], NULL);
>> -       up_write(&current->mm->mmap_sem);
>> +       npgs = get_user_pages_fast(umem->address, umem->npgs,
>> +                                  gup_flags, &umem->pgs[0]);
>>
> 
> Thanks for the patch!
> 
> The lifetime of the pinning is similar to RDMA umem mapping, so isn't
> gup_longterm preferred?

Seems reasonable from reading what gup_longterm seems to do. Davidlohr
or Dan, any thoughts on the above?

Thanks,
Daniel
