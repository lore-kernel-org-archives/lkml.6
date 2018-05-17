Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeEQSI3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:08:29 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.142]:27592 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752346AbeEQSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:08:28 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH 01/11] media: tm6000: fix potential Spectre variant 1
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
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
 <0f31a60b-911d-0140-3546-98317e2a0557@embeddedor.com>
 <d34cf31f-6dc5-ee2d-ea6d-513dd5e8e5c3@embeddedor.com>
 <20180517083440.14e6b975@vento.lan> <20180517084324.3242c257@vento.lan>
 <20180517091340.7d8c62b2@vento.lan>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <5921004a-a7d3-59c9-2ef4-b6a490390d3f@embeddedor.com>
Date: Thu, 17 May 2018 13:08:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517091340.7d8c62b2@vento.lan>
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
X-Exim-ID: 1fJNKE-003dIJ-Dm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.172.56.86]:42110
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/17/2018 07:13 AM, Mauro Carvalho Chehab wrote:
> Em Thu, 17 May 2018 08:43:24 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> 
>>>>> On 05/15/2018 02:39 PM, Dan Carpenter wrote:
>>>    
>>>>>> You'd need to rebuild the db (possibly twice but definitely once).
>>>
>>> How? Here, I just pull from your git tree and do a "make". At most,
>>> make clean; make.
>>
>> Never mind. Found it using grep. I'm running this:
>>
>> 	make allyesconfig
>> 	/devel/smatch/smatch_scripts/build_kernel_data.sh
>> 	/devel/smatch/smatch_scripts/build_kernel_data.sh
> 
> It seems that something is broken... getting this error/warning:
> 
> DBD::SQLite::db do failed: unrecognized token: "'end + strlen("
> " at /devel/smatch/smatch_scripts/../smatch_data/db/fill_db_sql.pl line 32, <WARNS> line 2938054.
> 

Yep. I get the same warning multiple times.

BTW, Mauro, you sent a patch to fix an spectre v1 issue in this file 
yesterday: dvb_ca_en50221.c:1480, but it seems there is another instance 
of the same issue some lines above:

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c 
b/drivers/media/dvb-core/dvb_ca_en50221.c
index 1310526..7edd9db 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -1398,6 +1398,7 @@ static int dvb_ca_en50221_io_do_ioctl(struct file 
*file,

                 info->type = CA_CI_LINK;
                 info->flags = 0;
+               slot = array_index_nospec(slot, ca->slot_count + 1);
                 sl = &ca->slot_info[slot];
                 if ((sl->slot_state != DVB_CA_SLOTSTATE_NONE) &&
                     (sl->slot_state != DVB_CA_SLOTSTATE_INVALID)) {


Thanks
--
Gustavo
