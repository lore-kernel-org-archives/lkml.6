Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E8F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sFJAPAma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E8F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeK1JrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:47:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58626 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeK1JrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:47:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wARMdFaT178208;
        Tue, 27 Nov 2018 22:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=l3litCukBO7sM6u1X3nElfQW7pboYC5d+ziFa90NcIQ=;
 b=sFJAPAmaXbpw5TWD5L9AXETfWL6KQsI5gpvx76MLDiGDLR+2Znex7WYwEwMTVMY5t+st
 ULf958a3dJTuBR6h/8+pniM+yYeQ/Oa+3eVWxC8UWEF429wY3rrK3I9AHiN5+AIwXom4
 /hBPNnhbf6x4wdrlLtLiArCuXqWW1NnWY6Hc5skyzX8zIHv4y+ZGp0XUwVkC7C+Jm/Hx
 06jegN19MU4OmRllFq/90Uhaazsf7gQPfcRPFtNR7pevfj61Jclz2kgByVGgIi6LOuS+
 3ARg++AkM0r33gwf90rUzZBIRm0VIcwnYCmwesaK1K7EUWdC7W0TbWWrsuKqInTVgtSt 0A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nxy9r6y6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 22:47:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wARMlWAh015141
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 22:47:32 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wARMlVAB027854;
        Tue, 27 Nov 2018 22:47:31 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 14:47:30 -0800
Subject: Re: [Xen-devel] [PATCH] pvcalls-front: fixes incorrect error handling
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     PanBian <bianpan2016@163.com>, Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1542852432-30019-1-git-send-email-bianpan2016@163.com>
 <1f765e81-ed89-d110-74b1-cc8029a4555f@oracle.com>
 <20181127005823.GB125510@bp>
 <alpine.DEB.2.10.1811271233550.4577@sstabellini-ThinkPad-X260>
 <0af126ad-1a74-e4c7-d74f-658a46757b9d@oracle.com>
 <alpine.DEB.2.10.1811271307020.4577@sstabellini-ThinkPad-X260>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <f4835c65-33f9-9076-1d36-9aad7cd39885@oracle.com>
Date:   Tue, 27 Nov 2018 17:47:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1811271307020.4577@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 4:08 PM, Stefano Stabellini wrote:
> On Tue, 27 Nov 2018, Boris Ostrovsky wrote:
>> On 11/27/18 3:37 PM, Stefano Stabellini wrote:
>>> On Tue, 27 Nov 2018, PanBian wrote:
>>>> On Mon, Nov 26, 2018 at 03:31:39PM -0500, Boris Ostrovsky wrote:
>>>>> On 11/21/18 9:07 PM, Pan Bian wrote:
>>>>>> kfree() is incorrectly used to release the pages allocated by
>>>>>> __get_free_page() and __get_free_pages(). Use the matching deallocators
>>>>>> i.e., free_page() and free_pages(), respectively.
>>>>>>
>>>>>> Signed-off-by: Pan Bian <bianpan2016@163.com>
>>>>>> ---
>>>>>>  drivers/xen/pvcalls-front.c | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
>>>>>> index 2f11ca7..77224d8 100644
>>>>>> --- a/drivers/xen/pvcalls-front.c
>>>>>> +++ b/drivers/xen/pvcalls-front.c
>>>>>> @@ -385,8 +385,8 @@ static int create_active(struct sock_mapping *map, int *evtchn)
>>>>>>  out_error:
>>>>>>  	if (*evtchn >= 0)
>>>>>>  		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
>>>>>> -	kfree(map->active.data.in);
>>>>>> -	kfree(map->active.ring);
>>>>>> +	free_pages((unsigned long)map->active.data.in, PVCALLS_RING_ORDER);
>>>>> Is map->active.data.in guaranteed to be NULL when entering this routine?
>>>> I am not sure yet. Sorry for that. I observed the mismatches between
>>>> __get_free_page and kfree, and submitted the patch.
>>>>
>>>> But I think your consideration is reasonable. A better solution is to
>>>> directly free bytes, a local variable that holds __get_free_pages return
>>>> value. If you agree, I will rewrite the patch.
>>> Like Boris said, map->active.ring and map->active.data.in are not
>>> guaranteed to be NULL or != NULL here. For instance,map->active.ring can
>>> be != NULL and map->active.data.in can be NULL. However, free_pages and
>>> free_page should be able to cope with it, the same way that kfree is
>>> able to cope with it?
>> If map->active.data.in can be non-NULL on entry to this routine then I
>> think this has been a problem all along. Pan's suggestion to use bytes
>> for freeing is going to solve this (assuming bytes will be initialized
>> to NULL).
> Why is it a problem? map->active.data.in and map->active.ring are only
> != NULL if they need to be freed. Otherwise, they are NULL. 

That was my question --- I wasn't sure about it, and I read your
previous message as if it was possible to be calling create_active()
with map->active.data.in pointing somewhere non-NULL.

If it is NULL *upon entry* to calling_create() then Pan's original patch
is fine.


-boris


> All structs
> are always initialized to zero. I don't think there are any issues.

