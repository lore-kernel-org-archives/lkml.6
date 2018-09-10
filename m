Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78E8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFCB20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iJLgaJjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFCB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeIJKRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:17:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeIJKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:17:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8A1drer171997;
        Mon, 10 Sep 2018 01:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=gGfouuOW1OSanfJpHnMvio8ROjcF33/48GK+JyKa7CI=;
 b=iJLgaJjT+9L2TniCY8pe+OZy8VRW26ac1Eoi/bIM9CqiWErUI4B15zmVCZI9xSAUVPQG
 hUHLgr2Uj6H/4JExKhSxPjhUTGZRY6H8uVwnv5P/DtefNtahoY3oenY8FDPzmqKgCUST
 7kkVf4aE8MAGE5TSDhBr5ubsoMOoSRdaZGYFXPMROAz+a1YMP7lmjZiElcs4jMH/rXlF
 GMwBx6+ceLWnizgQl//eQvGLzvSl9k0qF3Fm/q+dmnk+RpJF16SUzDedZT51Fj6zmIl4
 i7NLNQzkpJVnI8x1himiBwH2IOkUYgO1PDZ242+kLZc9sPhXiWIgMrR9qiyu80it1Kdf mA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mc6cpb8m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 01:40:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8A1eaei016234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 01:40:36 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8A1eZpk026337;
        Mon, 10 Sep 2018 01:40:36 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Sep 2018 18:40:35 -0700
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180909125824.9150-1-ming.lei@redhat.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
Date:   Mon, 10 Sep 2018 09:40:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180909125824.9150-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9011 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=642
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809100015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 09/09/2018 08:58 PM, Ming Lei wrote:
> Now percpu_ref_reinit() can only be done on one percpu refcounter
> when it drops zero. And the limit shouldn't be so strict, and it
> is quite straightforward that percpu_ref_reinit() can be done when
> this counter is at atomic mode.

As we know, when the percpu_ref is switched to atomic mode, the values
of the per cpu will be sumed up to the atomic conter in percpu_ref_switch_to_atomic_rcu.

However, the tricky part is:
when we switch back to percpu mode, how can we know the exact value of the value of every cpu ?

Draining the percpu refcounter to zero before switch it back to percpu mode should be relatively
easy to implement. And also, this is the initial intention of percpu refcounter, only switch
to atomic mode when want to drain the refcounter. 


Thanks
Jianchao
