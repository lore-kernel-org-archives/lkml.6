Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972154AbeEYBjd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 21:39:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49725 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S968873AbeEYBj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 21:39:28 -0400
Subject: Re: [PATCH net-next] cxgb4: Check for kvzalloc allocation failure
To: David Miller <davem@davemloft.net>
References: <20180522070718.12864-1-yuehaibing@huawei.com>
 <20180524.110743.522760687215216591.davem@davemloft.net>
CC: <ganeshgr@chelsio.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <f26c9a69-2d48-ddc7-4f12-53d0cf65b4f1@huawei.com>
Date: Fri, 25 May 2018 09:39:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180524.110743.522760687215216591.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/24 23:07, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Tue, 22 May 2018 15:07:18 +0800
> 
>> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> index 130d1ee..019cffe 100644
>> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> @@ -4135,6 +4135,10 @@ static int adap_init0(struct adapter *adap)
>>  		 * card
>>  		 */
>>  		card_fw = kvzalloc(sizeof(*card_fw), GFP_KERNEL);
>> +		if (!card_fw) {
>> +			ret = -ENOMEM;
>> +			goto bye;
>> +		}
>>  
> 
> On error, this leaks fw_info.

Hi David,

I checked fw_info is an element of fw_info_array，there all members of struct fw_info no need free.

It likes this :

static struct fw_info fw_info_array[] = {
	{
		.chip = CHELSIO_T4,
		.fs_name = FW4_CFNAME,
		.fw_mod_name = FW4_FNAME,
		.fw_hdr = {
			.chip = FW_HDR_CHIP_T4,
			.fw_ver = __cpu_to_be32(FW_VERSION(T4)),
			.intfver_nic = FW_INTFVER(T4, NIC),
			.intfver_vnic = FW_INTFVER(T4, VNIC),
			.intfver_ri = FW_INTFVER(T4, RI),
			.intfver_iscsi = FW_INTFVER(T4, ISCSI),
			.intfver_fcoe = FW_INTFVER(T4, FCOE),
		},
	}, {
		........

Am I missing something?
> 
> .
> 
