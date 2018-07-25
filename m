Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9527CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CDF20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CDF20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeGYL3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:29:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728708AbeGYL3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:29:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1539A3B7277ED;
        Wed, 25 Jul 2018 18:18:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Wed, 25 Jul 2018
 18:18:36 +0800
Subject: Re: [PATCH net-next] bnxt_en: Fix logic of forward the VF MAC address
 to PF in bnxt_vf_validate_set_mac
To:     Michael Chan <michael.chan@broadcom.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
References: <20180724052454.21524-1-yuehaibing@huawei.com>
 <CACKFLini64_5N7aVtPAVH3CBYCSsdHAJv35jimR18PJXeV6j5g@mail.gmail.com>
 <CAACQVJrS9_fCNG3g51q7kZnTt5wy1X-SrvXTsFq=zqZEUvVS5Q@mail.gmail.com>
 <CACKFLinjTEnma79YtNG3UVqfc+gzRxXoMttY0tMfSTSPRx8ZyQ@mail.gmail.com>
CC:     David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <04616f0d-ca58-db28-a4ad-3ea0cf8e7c3c@huawei.com>
Date:   Wed, 25 Jul 2018 18:18:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CACKFLinjTEnma79YtNG3UVqfc+gzRxXoMttY0tMfSTSPRx8ZyQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/25 5:48, Michael Chan wrote:
> On Tue, Jul 24, 2018 at 9:01 AM, Vasundhara Volam
> <vasundhara-v.volam@broadcom.com> wrote:
>> On Tue, Jul 24, 2018 at 1:01 PM, Michael Chan <michael.chan@broadcom.com> wrote:
>>>
>>> On Mon, Jul 23, 2018 at 10:24 PM, YueHaibing <yuehaibing@huawei.com> wrote:
>>>> Based on the comments,req->l2addr must match the VF MAC address
>>>> if firmware spec >= 1.2.2, mac_ok can be true.
>>>>
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 7 ++-----
>>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>>>> index a649108..7925964 100644
>>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>>>> @@ -954,12 +954,9 @@ static int bnxt_vf_validate_set_mac(struct bnxt *bp, struct bnxt_vf_info *vf)
>>>>                 if (ether_addr_equal((const u8 *)req->l2_addr, vf->mac_addr))
>>>>                         mac_ok = true;
>>>>         } else if (is_valid_ether_addr(vf->vf_mac_addr)) {
>>>> -               if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr))
>>>> +               if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr) &&
>>>> +                   bp->hwrm_spec_code >= 0x10202)
>>>>                         mac_ok = true;
>>>
>>> I'm not sure if this is correct.  If firmware spec < 0x10202, the VF
>>> MAC address is not forwarded to the PF and so it doesn't have to match
>>> and mac_ok should still be true.  I think we are missing that
>>> condition with this patch.
>>>
>>> I need to let my colleague Vasundhara comment on this.  She is more
>>> familiar with this logic.
>> Yes Michael, you are right. Also, the plain else condition is to cover
>> a special case to allow VF to modify
>> it's own MAC when PF has not assigned a valid MAC address and HWRM
>> spec code > 0x10202.
> 
> We should combine the "else if" and "else" below into a plain else and
> add some comments to explain the conditions.

Thank you for clarification.

I will send a new patch for this.

> 
>>>
>>>> -       } else if (bp->hwrm_spec_code < 0x10202) {
>>>> -               mac_ok = true;
>>>> -       } else {
>>>> -               mac_ok = true;
>>>>         }
>>>>         if (mac_ok)
>>>>                 return bnxt_hwrm_exec_fwd_resp(bp, vf, msg_size);
>>>> --
>>>> 2.7.0
>>>>
>>>>
> 
> .
> 

