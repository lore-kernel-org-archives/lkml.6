Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeBTSFb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:05:31 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.5]:44820 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751381AbeBTSF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:05:28 -0500
Subject: Re: [PATCH] rds: send: mark expected switch fall-through in
 rds_rm_size
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20180219181020.GA19154@embeddedgus>
 <9b385269-7f13-983c-caf1-72e050acc6d9@oracle.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <56eff85f-852b-0123-ae57-7cf9baedbae6@embeddedor.com>
Date: Tue, 20 Feb 2018 12:05:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9b385269-7f13-983c-caf1-72e050acc6d9@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1eoCIB-003xeI-CM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:34488
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On 02/20/2018 11:54 AM, Santosh Shilimkar wrote:
> Hi,
> 
> 2/19/2018 10:10 AM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Addresses-Coverity-ID: 1465362 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   net/rds/send.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/rds/send.c b/net/rds/send.c
>> index 028ab59..79d158b 100644
>> --- a/net/rds/send.c
>> +++ b/net/rds/send.c
>> @@ -902,6 +902,8 @@ static int rds_rm_size(struct msghdr *msg, int 
>> num_sgs)
>>           case RDS_CMSG_ZCOPY_COOKIE:
>>               zcopy_cookie = true;
>> +            /* fall through */
>> +
>>           case RDS_CMSG_RDMA_DEST:
>>           case RDS_CMSG_RDMA_MAP:
>>               cmsg_groups |= 2;
>>
> So coverity greps for commet as "fall through" for
> -Wimplicit-fallthrough build ?
> 

No. Basically, Coverity only reports cases in which a break, return or 
continue statement is missing.

Now, if the statements I mention above are missing and if you add the 
following line to your Makefile:

KBUILD_CFLAGS  += $(call cc-option,-Wimplicit-fallthrough)

You will get a warning if a fall-through comment is missing.

> Adding that comments itself if fine but was curious
> about it if some one makes a spell error in this
> comment what happens ;-)
> 

In this case, Coverity would still report the same "Missing break in 
switch" error, but you'll get a GCC warning.

> For patch itself,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>

--
Gustavo
