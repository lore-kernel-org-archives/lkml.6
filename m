Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F9EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6CB20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J+QpC7zY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6CB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeIFVo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:44:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35614 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbeIFVo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:44:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w86H4RGi067543;
        Thu, 6 Sep 2018 17:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=chSGWLzPYZVOnt/7XzLI/x0ephQSPBOJbR4MttNzbbE=;
 b=J+QpC7zYCffMZXjb8eQ6umUm4DubE3uFtQBIefqQ3ISeolKLIIbU4lOpaj1ChYIJO5Dk
 ElQF/GZlQMspBk65bPe89BO8ZIJL1/6Jn7B09EvrR3yKmsmZ6bcV5o2uCsPFa3ZUbytd
 MrpJo2h4J+8C3RDGUIZ1gxxZ3L/SDK2sEgI9wUkbs92CdPHlrvw6alz3/5z47VOSURQj
 Nx+OOMYKGY1iTmKv5c4K8vaZr5FNDSZw/G/+K2rs1ud/cuP95tHmZ+hOupkrm7xxpWCR
 Oj8Pzb5zhTXW4I4n9XHGLcazcfgu2jaI87PG4RibpkdorWGRNik4V/gizcs3HuHhsemi YA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m7j6twe92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 17:07:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w86H7mx3000674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 17:07:49 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w86H7lvj028111;
        Thu, 6 Sep 2018 17:07:48 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Sep 2018 10:07:47 -0700
Subject: Re: [PATCH] memory: ti-aemif: fix a potential NULL-pointer
 dereference
To:     Olof Johansson <olof@lixom.net>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "arm@kernel.org" <arm@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
References: <20180906121219.23948-1-brgl@bgdev.pl>
 <b04c16ad-b57d-1635-8d0c-a96020e5aa76@oracle.com>
 <20180906170358.tfdw377lcffwztsm@localhost>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <dcff3b3e-7f0c-1af8-9c30-c32c1185f4c5@oracle.com>
Date:   Thu, 6 Sep 2018 10:07:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906170358.tfdw377lcffwztsm@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9008 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=933
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2018 10:03 AM, Olof Johansson wrote:
> On Thu, Sep 06, 2018 at 09:58:54AM -0700, Santosh Shilimkar wrote:
>> Hi Arnd, Olof,
>>
>> On 9/6/2018 5:12 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Platform data pointer may be NULL. We check it everywhere but in one
>>> place. Fix it.
>>>
>>> Fixes: 8af70cd2ca50 ("memory: aemif: add support for board files")
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>    drivers/memory/ti-aemif.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>> Will you be able to push this via drivers-soc fixes ?
> 
> Applied to fixes.
> 
Thanks Olof !!

Regards,
Santosh
