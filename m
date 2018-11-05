Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2BFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B369620869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l8diVpyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B369620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeKESoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:44:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34142 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:44:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA59NfiT088899;
        Mon, 5 Nov 2018 09:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NWcwS1KgIiB2SkrwD3fuYYvm7SkVvsNDm6zehjFXAaM=;
 b=l8diVpyCMeJoYL8Y2PsLwQy7pP5OUNAgTDiXJS/AfJUeq0E/6FMAb8iLTWoLN0tJ/Wh8
 BLxhhWUTyHlnGmrcPgtnXcMn1gTI7sXu8ZSIfGaJl7nlJAvSLR6PUkGvkmbwktqQ0Hrj
 azPuLLPTuvLgQofFEMFEr/OtJO8vZ/0L46u9c+rvoQI1q8pi2oEdPPuFvi/C31zpVDTX
 jr/8iLcVxzHIPIGmBCsSx8Ywk318J1Q/Nop31ZaMJDVriIbNl6jYVekzrMFr3+UaGDGF
 I2NA5qNSVg8D7KpEx9WTWE1J8HuOzfqra+5X7y8jQBojToCBeW5BWcsP947C5we1wgex fA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nh3mpdfk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 09:25:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA59P9HS000871
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 09:25:09 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA59P8fP031359;
        Mon, 5 Nov 2018 09:25:08 GMT
Received: from [10.191.18.211] (/10.191.18.211)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 01:25:08 -0800
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH] kbuild: rpm-pkg: fix two build breaks when O= is used
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        srinivas.eeda@oracle.com, Michal Marek <michal.lkml@markovi.net>
References: <3e40ec15-3a8c-444d-8d32-35ef587f3980@default>
 <CAK7LNAQUie1D3=0o36idvxR7uLtGRaV-MCs5L_cPcuXj28inEw@mail.gmail.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <6d7af3dc-36a4-837d-42df-f37b2940dda9@oracle.com>
Date:   Mon, 5 Nov 2018 17:25:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQUie1D3=0o36idvxR7uLtGRaV-MCs5L_cPcuXj28inEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9067 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/5 15:55, Masahiro Yamada wrote:
> Hi Zhenzhong,
> 
> On Fri, Nov 2, 2018 at 8:26 PM Zhenzhong Duan<zhenzhong.duan@oracle.com>  wrote:
>> Running 'make O=/build/kernel binrpm-pkg' failed with below two errors.
>>
>> Makefile:600: include/config/auto.conf: No such file or directory
>>
>> + cp make -C /mnt/root/kernel O=/build/kernel image_name make -f
>> /mnt/root/kernel/Makefile ...
>> cp: invalid option -- 'C'
>> Try 'cp --help' for more information.
>>
>> Export KBUILD_OUTPUT when O= is used so that it could be used in locating
>> include/config/auto.conf
>>
>> Use $srctree to locate source dir when generating image name, no matter
>> if O= is used.
>>
>> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@oracle.com>
> 
> Sorry for the breakage, and thanks for your report.
> 
> I'd like to fix the issue in a cleaner way.
> 
> See this:
> https://patchwork.kernel.org/patch/10667539/

Never mind, appreciate you fixed it in a smart way:)

Thanks
Zhenzhong
