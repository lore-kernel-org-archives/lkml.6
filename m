Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeAaMZG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:25:06 -0500
Received: from gateway30.websitewelcome.com ([192.185.179.30]:17661 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752061AbeAaMZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:25:05 -0500
Date: Wed, 31 Jan 2018 06:02:53 -0600
Message-ID: <20180131060253.Horde.vxLJv9n9JFz_lxqApXvdkZX@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: use 64-bit arithmetic instead of 32-bit
References: <20180131052948.GA16419@embeddedgus>
 <CAOi1vP_weac6BzPbpcqAiaC1Mfxr-83=3XKLpv8+aZCsPGObAw@mail.gmail.com>
In-Reply-To: <CAOi1vP_weac6BzPbpcqAiaC1Mfxr-83=3XKLpv8+aZCsPGObAw@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 108.167.133.22
X-Source-L: Yes
X-Exim-ID: 1egr6L-000sYZ-EG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:28785
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ilya,

Quoting Ilya Dryomov <idryomov@gmail.com>:

> On Wed, Jan 31, 2018 at 6:29 AM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>> Cast objsetno to u64 in order to give the compiler complete
>> information about the proper arithmetic to use. Notice
>> that this variable is used in a context that expects an
>> expression of type u64 (64 bits, unsigned).
>>
>> The expression objsetno * sc + stripepos is currently
>> being evaluated using 32-bit arithmetic.
>>
>> In general, the use of incorrect arithmetic has security
>> implications.
>>
>> Addresses-Coverity-ID: 200686
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  net/ceph/osdmap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 0da27c6..58dc965 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -2183,7 +2183,7 @@ int ceph_calc_file_object_mapping(struct  
>> ceph_file_layout *layout,
>>         stripepos = bl % sc;
>>         objsetno = stripeno / su_per_object;
>>
>> -       *ono = objsetno * sc + stripepos;
>> +       *ono = (u64)objsetno * sc + stripepos;
>>         dout("objset %u * sc %u = ono %u\n", objsetno, sc,  
>> (unsigned int)*ono);
>>
>>         /* *oxoff = *off % layout->fl_stripe_unit;  # offset in su */
>
> Hi Gustavo,
>
> This (and other u32/u64 issues in this function, is this the only
> warning?) is fixed in my striping v2 work branch.  I wasn't going to
> push that patch separately, but I guess I should post it.
>

Yeah, this was the only one warning reported by Coverity in this  
particular module.

Thanks
--
Gustavo
