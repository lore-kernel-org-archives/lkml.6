Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81800C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A202080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T9zTdkRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A202080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJaCJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:09:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38346 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJaCJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:09:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UHDUSv101453;
        Tue, 30 Oct 2018 17:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=F9r24LzVJHFe5H+ij0hhPlxVwmdqteDk5lU8q0IOmso=;
 b=T9zTdkRW2LxyehkjAl1BOHMOtSZ7iZhwcz8IWfMTJ36W/RMjYXXzUK0kUTj0uGdgx6OP
 VSJQKjAAki7BpI3FsUaA26/lpEV9dWy+ODpmKG+xboLMhHG4Rwzs8qjzescNBYfDQ7gt
 XTFHmS53FkEnaCJ+mEpGBKxu+WMab0LniZ3Amyp/Pd7c3dk3+C4Cv/7VMXemq7uv0RAn
 H75IiC/LWbmoW8VBt95k7CKsmLliSWnhEeKrNNK++6JxBSWKPM3UfgEIPVzXHDl/H+3Y
 A2LMX+Y0J3bKCiGtc0vvXal71WMcR4NmLa5iT8xQJPOZWofcWJlmcIr/KKErqv/vN7az og== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2ncfypwtr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 17:15:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9UHF7kb017677
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 17:15:07 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9UHF6YH021498;
        Tue, 30 Oct 2018 17:15:06 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 10:15:06 -0700
Subject: Re: [PATCH] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, stable@vger.kernel.org
References: <20181030111103.12110-1-marc.zyngier@arm.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <0a20aaf3-65ce-a7ae-8a0e-877313483969@oracle.com>
Date:   Tue, 30 Oct 2018 10:15:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030111103.12110-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=621
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300146
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

On 10/30/2018 4:11 AM, Marc Zyngier wrote:
> The Keystone QMSS driver is pretty damaged, in the sense that it
> does things like this:
> 
> 	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> 
> where cpu_map is a local variable. As we leave the function, this
> will point to nowhere-land, and things will end-up badly.
> 
> Instead, let's use a proper cpumask that gets allocated, giving
> the driver a chance to actually work with things like irqbalance
> as well as have a hypothetical 64bit future.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
Could you please add this patch to your fixes branch ?

FWIW,
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

