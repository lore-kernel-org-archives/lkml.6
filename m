Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9494BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37474208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qj/n+cFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37474208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeH1Gly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:41:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53008 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeH1Gly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:41:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7S2mbbn057812;
        Tue, 28 Aug 2018 02:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=f0k4iiSktII+oOrUuFxk7UEitvlyl/1CXHnpdOsSVHE=;
 b=Qj/n+cFX5ml3slqITSURrQ2RPsoD15oI79yJmdBvULq9SkBb3P2Ghk6aVMtR9zfIWn0H
 m31B14t79X8Nu2IGRXKN1a8MG565U2kk9UU2GA88YXsWbVLvr1tTOYAqNpRldBO92/Ps
 2YMFRbh2ldkMSAxA8sBBt/Va9vIkGlAEGMaz7rzK4FDrALr3jhGLlPKyuC3PVUAlDm+3
 gpnMdIo8M5aOC1kQcNRP2a/wEDPKfJA6LanqIncuP6m7weG1BLDKOnBaWVua4GYqCpHm
 dV2jhXm6C3iLgstxXvfz0eIHbSMj8vYjBetlcqTLjmMHf7igAS8ARt6rw2reJ588AZKH Sw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m2xhth7vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 02:52:18 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7S2qG5r011704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 02:52:17 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7S2qFkY000519;
        Tue, 28 Aug 2018 02:52:16 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Aug 2018 19:52:15 -0700
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     Jens Axboe <axboe@kernel.dk>, Anchal Agarwal <anchalag@amzn.com>
Cc:     fllinden@amazon.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
 <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
 <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
 <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
 <3876c36c-fec6-6586-435f-dc177dc38c76@oracle.com>
 <f88cd48d-e140-fa61-76f7-8985ca2c2e08@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <5cd959f0-b40c-b6ac-c037-89f6cc670f47@oracle.com>
Date:   Tue, 28 Aug 2018 10:52:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f88cd48d-e140-fa61-76f7-8985ca2c2e08@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808280026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

On 08/27/2018 10:51 PM, Jens Axboe wrote:
>>> I cannot get the point of "since we can't rely on just being woken from the ->func handler
>>> we set".
>>> Do you mean there could be someone else could wake up this task ?
> Yeah, you don't know for a fact that the wbt wait queue is the only
> guy waking us up. Any sleep like this needs a loop. It was quite
> easy to reproduce for me, and as expected, you'll get list corruption
> on the wait queue since we leave it on the list and the stack goes
> away.
> 
Yes, got it. Thanks for your kindly response. :)

Thanks
Jianchao
