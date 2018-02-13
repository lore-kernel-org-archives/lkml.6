Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933327AbeBMCTq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 21:19:46 -0500
Received: from casper.infradead.org ([85.118.1.10]:40640 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeBMCTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 21:19:45 -0500
Subject: Re: [PATCH] fs/signalfd: fix build error for BUS_MCEERR_AR
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <8a85cfae-0c26-e50c-9b26-582802a7f3eb@infradead.org>
 <87tvul4opx.fsf@xmission.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3b0d0b5c-a839-87e0-a2cd-76d5780ee6a7@infradead.org>
Date: Mon, 12 Feb 2018 18:19:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87tvul4opx.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 06:18 PM, Eric W. Biederman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build error in fs/signalfd.c by using same method that is used in
>> kernel/signal.c: separate blocks for different signal si_code values.
>>
>> ./fs/signalfd.c: error: 'BUS_MCEERR_AR' undeclared (first use in this function)
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Do you want to me to pick this one up?  Or does it have another path
> into mainline?
> 

Just via you or Al. You might as well take it.

Thanks.

> 
>> ---
>>  fs/signalfd.c |   15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> Applies to mainline 4.16-rc1.
>>
>> --- linux-next-20180212.orig/fs/signalfd.c
>> +++ linux-next-20180212/fs/signalfd.c
>> @@ -118,13 +118,22 @@ static int signalfd_copyinfo(struct sign
>>  		err |= __put_user(kinfo->si_trapno, &uinfo->ssi_trapno);
>>  #endif
>>  #ifdef BUS_MCEERR_AO
>> -		/* 
>> +		/*
>>  		 * Other callers might not initialize the si_lsb field,
>>  		 * so check explicitly for the right codes here.
>>  		 */
>>  		if (kinfo->si_signo == SIGBUS &&
>> -		    (kinfo->si_code == BUS_MCEERR_AR ||
>> -		     kinfo->si_code == BUS_MCEERR_AO))
>> +		     kinfo->si_code == BUS_MCEERR_AO)
>> +			err |= __put_user((short) kinfo->si_addr_lsb,
>> +					  &uinfo->ssi_addr_lsb);
>> +#endif
>> +#ifdef BUS_MCEERR_AR
>> +		/*
>> +		 * Other callers might not initialize the si_lsb field,
>> +		 * so check explicitly for the right codes here.
>> +		 */
>> +		if (kinfo->si_signo == SIGBUS &&
>> +		    kinfo->si_code == BUS_MCEERR_AR)
>>  			err |= __put_user((short) kinfo->si_addr_lsb,
>>  					  &uinfo->ssi_addr_lsb);
>>  #endif


-- 
~Randy
