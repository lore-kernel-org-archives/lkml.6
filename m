Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E1CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B96206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3icTU8r6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B96206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeJKHfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:35:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57748 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:35:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B09qnH157158;
        Thu, 11 Oct 2018 00:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=o1U3BkRHZrjF+n+MLWqGRb9CRrqu5urApEs/TNKZ0S8=;
 b=3icTU8r6Xdm9OjLD/FUQGXRZ+SHQUF44SNT6jh/fg0o48V1yGb7nPkkzZ/7NmGlimMQw
 iCKlhcGB9rAGu1KsiMxOu9YXa5zVlpGa+8j9KslD/BnIJzT5kWgX8MEtrW3B2e56ias+
 Vf3rFPV3pVExSkngy/2eX4KrqcdnjfVuTIFNn/prO8+VW7JKwEB814a4hr+KsDMcGaPS
 OY9EvF6RZnY9uZ13vCbMrDUbvSohxT+oFmT6n6/P+B1uz7L6oMOpuG/TBVP1+CksEpdJ
 Brr3JG1W1wpPkC8BLPzqMMcjbOadA7kI9O32ADGgUPKqF+ZriF1WDiJVeRVRPrUAs7Gv GA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mxn0q7a1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 00:10:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9B09w9o029750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 00:09:58 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9B09v4v003317;
        Thu, 11 Oct 2018 00:09:58 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 00:09:57 +0000
To:     linux-kernel@vger.kernel.org
Cc:     tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Subject: Gang scheduling
Message-ID: <44347e72-d595-5c2d-3983-7237526c71c6@oracle.com>
Date:   Wed, 10 Oct 2018 17:09:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=706
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was following the Coscheduling patch discussion on lkml and Peter 
mentioned he had a patch series. I found the following on github.

https://github.com/pdxChen/gang/commits/sched_1.23-loadbal

I would like to test this with KVMs. Are the commits from 38d5acb to 
f019876 sufficient? Also is there any documentaion on how to use it (any 
knobs I need to turn on for gang scheduling to happen?) or is it enabled 
by default for KVMs?

Thanks,
Subhra

