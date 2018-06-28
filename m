Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291BBC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39C725928
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kJSNkm8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39C725928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeF1BLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:11:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45500 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeF1BLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:11:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5S19PT8178431;
        Thu, 28 Jun 2018 01:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=zzyNLilympORGeiZAf2k/K8X5CENFuEoRD1Hqt1Ev1w=;
 b=kJSNkm8s4GtvGJkBxm7p1M4nZW+wCt8tIBNplzgvImt0pKPy1LGkwrkkUer1Vvx40xw8
 oQU3g9SmBs1NaTOoh4tF+FMLcXywFKRXzpKUMRxd/ceECIh96zyhmkCTdG+TR13hTmJH
 /ofr8JweIf9PodbAp1TVlALdj6c+Jfp42yO+EEn1jcsgooPYh/ItMesGVlKxuXcmbwH4
 09VF3VMQvcDVTY9HQ7B8Byij1ou5g0dis/vpqboSx/DWlAysoG+R84A2Zk2+YFXUY74A
 0EkMSihs9iVc/fukDh7TnAshBv3tVqKDw1YyHGaoAHGjdCMMW7uAWs9QyLEbtt9PyLVG tA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jum57xxwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 01:11:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5S1BAxw030623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 01:11:10 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5S1BAQB022879;
        Thu, 28 Jun 2018 01:11:10 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 18:11:09 -0700
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
To:     Bart Van Assche <bart.vanassche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
 <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
 <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
 <2c2003ff1baac05688495677f67239d52f6d9527.camel@wdc.com>
 <2a1dda06-5c7c-b75b-c1ae-75d1a2a49694@oracle.com>
 <a0350d07-3c11-c04c-d9ba-94a5868e7d8f@oracle.com>
 <1d4d1dc3-7014-4e2a-1ea5-e1446381b404@wdc.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <07e9e71a-723c-93a8-becb-df5d2f43b690@oracle.com>
Date:   Thu, 28 Jun 2018 09:11:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1d4d1dc3-7014-4e2a-1ea5-e1446381b404@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=859
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

On 06/26/2018 11:36 PM, Bart Van Assche wrote:
> On 06/25/18 20:47, jianchao.wang wrote:
>> V2 patch has been posted, would you please take a look at on them ?
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D152965143412927-26w-3D2&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=FPLHVLVF0V8ZCvwZJx7vHy9v01iAQogJ_IbvseGhElo&s=tQ0ZiK7VrV4j-6K_WEfiWAyxogOrC8hOm6coS9nAmYI&e=
> 
> Hello Jianchao,
> 
> Patches 1/3 and 2/3 of that series look fine to me but I don't like the approach of patch 3/3 so please do not expect a review from me for that patch.
> 

Would you please explain the defects of the patch 3/3 ?

Thanks
Jianchao
