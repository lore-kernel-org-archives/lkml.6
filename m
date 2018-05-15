Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeEORt2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:49:28 -0400
Received: from gateway36.websitewelcome.com ([50.116.127.2]:40227 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753337AbeEORt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:49:26 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH 01/11] media: tm6000: fix potential Spectre variant 1
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1524499368.git.gustavo@embeddedor.com>
 <3d4973141e218fb516422d3d831742d55aaa5c04.1524499368.git.gustavo@embeddedor.com>
 <20180423152455.363d285c@vento.lan>
 <3ab9c4c9-0656-a08e-740e-394e2e509ae9@embeddedor.com>
 <20180423161742.66f939ba@vento.lan>
 <99e158c0-1273-2500-da9e-b5ab31cba889@embeddedor.com>
 <20180426204241.03a42996@vento.lan>
 <df8010f1-6051-7ff4-5f0e-4a436e900ec5@embeddedor.com>
 <20180515085953.65bfa107@vento.lan> <20180515141655.idzuh2jfdkuu5grs@mwanda>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <f342d8d6-b5e6-0cbf-d002-9561b79c90e4@embeddedor.com>
Date: Tue, 15 May 2018 12:29:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515141655.idzuh2jfdkuu5grs@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fIdlB-001GXq-Hy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.172.56.86]:40428
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/15/2018 09:16 AM, Dan Carpenter wrote:
>>>
>>> I'm curious about how you finally resolved to handle these issues.
>>>
>>> I noticed Smatch is no longer reporting them.
>>
>> There was no direct fix for it, but maybe this patch has something
>> to do with the smatch error report cleanup:
>>
>> commit 3ad3b7a2ebaefae37a7eafed0779324987ca5e56
>> Author: Sami Tolvanen <samitolvanen@google.com>
>> Date:   Tue May 8 13:56:12 2018 -0400
>>
>>      media: v4l2-ioctl: replace IOCTL_INFO_STD with stub functions
>>      
>>      This change removes IOCTL_INFO_STD and adds stub functions where
>>      needed using the DEFINE_V4L_STUB_FUNC macro. This fixes indirect call
>>      mismatches with Control-Flow Integrity, caused by calling standard
>>      ioctls using a function pointer that doesn't match the function type.
>>      
>>      Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>>      Signed-off-by: Hans Verkuil <hansverk@cisco.com>
>>      Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>>

Thanks, Mauro.

> 
> Possibly...  There was an ancient bug in Smatch's function pointer
> handling.  I just pushed a fix for it now so the warning is there on
> linux-next.
> 

Dan,

These are all the Spectre media issues I see smatch is reporting in 
linux-next-20180515:

drivers/media/cec/cec-pin-error-inj.c:170 cec_pin_error_inj_parse_line() 
warn: potential spectre issue 'pin->error_inj_args'
drivers/media/dvb-core/dvb_ca_en50221.c:1479 dvb_ca_en50221_io_write() 
warn: potential spectre issue 'ca->slot_info' (local cap)
drivers/media/dvb-core/dvb_net.c:252 handle_one_ule_extension() warn: 
potential spectre issue 'p->ule_next_hdr'

I pulled the latest changes from the smatch repository and compiled it.

I'm running smatch v0.5.0-4459-g2f66d40 now. Is this the latest version?

I wonder if there is anything I might be missing.

Thanks
--
Gustavo
