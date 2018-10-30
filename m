Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA24C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A497D2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldQNnnHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A497D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJaCEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:04:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44180 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbeJaCEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:04:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UH8wkd048987;
        Tue, 30 Oct 2018 17:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=b3U5DbmuP4Q+KG5ilZYP2kHAf9TrxHsTEaW54NnaGQg=;
 b=ldQNnnHptAciGexLNmWiaf31kvfB2naA5fETlAVoshhkBr8uCYCRciKNqt4GQ2q7wv//
 ivU+vymysoPMsu0jZCRMqblWa2BitKgGGlfCRLPKcKYEYRnRnZJyMec/rXc+OBQk3onE
 Xvg9TSt2RO7dZmQk7og4GEGbDbeHvANPXdU9AWfOOPJCVNm2ok5hk75z2FuPFnQhxyBv
 WxgHRkyuB2AX1gmf5xvyO0Db0e3/5uNhVbD5ia3+RPUK0Dz8DS5RRpTj7/4So4TYVNXv
 gohvu80dUuEFM7SfQUOKzcC153FgtCGxr6YGz8CMQ7BvSliSvJdYDxEy7kjaeiE3hg+5 3Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2ncgnqws42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 17:09:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9UH9vp3019004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 17:09:57 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9UH9udk029410;
        Tue, 30 Oct 2018 17:09:56 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 10:09:56 -0700
Subject: Re: [PATCH] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181030111103.12110-1-marc.zyngier@arm.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <2e742a7e-5e1f-a5ac-0372-f0e10a3783d7@oracle.com>
Date:   Tue, 30 Oct 2018 10:09:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030111103.12110-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=814
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10/30/2018 4:11 AM, Marc Zyngier wrote:
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
Thanks Marc for the fix. Will send note to arm-soc folks
to pick this up for fixes and also stable.

Regards,
Santosh
