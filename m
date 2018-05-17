Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeEQBOV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 21:14:21 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:20596 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752014AbeEQBOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 21:14:19 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH 01/11] media: tm6000: fix potential Spectre variant 1
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3d4973141e218fb516422d3d831742d55aaa5c04.1524499368.git.gustavo@embeddedor.com>
 <20180423152455.363d285c@vento.lan>
 <3ab9c4c9-0656-a08e-740e-394e2e509ae9@embeddedor.com>
 <20180423161742.66f939ba@vento.lan>
 <99e158c0-1273-2500-da9e-b5ab31cba889@embeddedor.com>
 <20180426204241.03a42996@vento.lan>
 <df8010f1-6051-7ff4-5f0e-4a436e900ec5@embeddedor.com>
 <20180515085953.65bfa107@vento.lan> <20180515141655.idzuh2jfdkuu5grs@mwanda>
 <f342d8d6-b5e6-0cbf-d002-9561b79c90e4@embeddedor.com>
 <20180515193936.m25kzyeknsk2bo2c@mwanda>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <0f31a60b-911d-0140-3546-98317e2a0557@embeddedor.com>
Date: Wed, 16 May 2018 20:14:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515193936.m25kzyeknsk2bo2c@mwanda>
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
X-Exim-ID: 1fJ7Uo-0036Yi-E5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.172.56.86]:34798
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/15/2018 02:39 PM, Dan Carpenter wrote:
>> Dan,
>>
>> These are all the Spectre media issues I see smatch is reporting in
>> linux-next-20180515:
>>
>> drivers/media/cec/cec-pin-error-inj.c:170 cec_pin_error_inj_parse_line()
>> warn: potential spectre issue 'pin->error_inj_args'
>> drivers/media/dvb-core/dvb_ca_en50221.c:1479 dvb_ca_en50221_io_write() warn:
>> potential spectre issue 'ca->slot_info' (local cap)
>> drivers/media/dvb-core/dvb_net.c:252 handle_one_ule_extension() warn:
>> potential spectre issue 'p->ule_next_hdr'
>>
>> I pulled the latest changes from the smatch repository and compiled it.
>>
>> I'm running smatch v0.5.0-4459-g2f66d40 now. Is this the latest version?
>>
>> I wonder if there is anything I might be missing.
>>
> 
> You'd need to rebuild the db (possibly twice but definitely once).
> 

Hi Dan,

After rebuilding the db (once), these are all the Spectre media warnings 
I get:

drivers/media/pci/ddbridge/ddbridge-core.c:233 ddb_redirect() warn: 
potential spectre issue 'ddbs'
drivers/media/pci/ddbridge/ddbridge-core.c:243 ddb_redirect() warn: 
potential spectre issue 'pdev->port'
drivers/media/pci/ddbridge/ddbridge-core.c:252 ddb_redirect() warn: 
potential spectre issue 'idev->input'
drivers/media/dvb-core/dvb_ca_en50221.c:1400 
dvb_ca_en50221_io_do_ioctl() warn: potential spectre issue 
'ca->slot_info' (local cap)
drivers/media/dvb-core/dvb_ca_en50221.c:1479 dvb_ca_en50221_io_write() 
warn: potential spectre issue 'ca->slot_info' (local cap)
drivers/media/dvb-core/dvb_net.c:252 handle_one_ule_extension() warn: 
potential spectre issue 'p->ule_next_hdr'
drivers/media/dvb-core/dvb_net.c:1483 dvb_net_do_ioctl() warn: potential 
spectre issue 'dvbnet->device' (local cap)
drivers/media/cec/cec-pin-error-inj.c:170 cec_pin_error_inj_parse_line() 
warn: potential spectre issue 'pin->error_inj_args'

I just want to double check if you are getting the same output. In case 
you are getting the same, then what Mauro commented about these issues:

https://patchwork.linuxtv.org/project/linux-media/list/?submitter=7277

being resolved by commit 3ad3b7a2ebaefae37a7eafed0779324987ca5e56 seems 
to be correct.

Thanks
--
Gustavo
