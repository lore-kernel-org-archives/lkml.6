Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73084C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5982086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H6UwJiOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5982086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeIJIXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:23:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46858 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeIJIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:23:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8A1sFiL155433;
        Mon, 10 Sep 2018 01:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=t8+PIwKQ19udY+l+5bXLB6rUYxiMxi2gLZeDkaAjFAI=;
 b=H6UwJiOGCYoqq79mMOYgi8G8DuaMHNZWAHQn5iQs/4SIDrs5dv5T/sd4kQ254N3GOzCi
 1UiMDS2cI8RoLQ2b0tQYBD7JboE41At3pCnKbM2mDeK/YoHnviUFyxjpRzQutzAm/dh5
 qGcPCVTHZL3ze2iNw/aM0bI+gUp8SnlLmxacJMO6pBvkKtlpdDUOfShBpjfZ0mnEqZZW
 zMA/2kjzOTVxBQWzjn7i2foXYxXGpttKVJX+ZMiTWaujUqyJOmylWE3lFAL/qK/L1LQd
 ihMhkuN0m1FoVieF6ucGPY3YuqpQD7D/Eck6v+8kjKBA/k2RA175kJrymJqHP36ibh8J qg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mc5ut3b1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 01:54:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8A1sEbe016977
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 01:54:14 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8A1sEqZ025050;
        Mon, 10 Sep 2018 01:54:14 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Sep 2018 18:54:13 -0700
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180909125824.9150-1-ming.lei@redhat.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <6f48bb2c-9071-1d90-5b15-c15ba5d4eb64@oracle.com>
Date:   Mon, 10 Sep 2018 09:54:14 +0800
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
 engine=8.0.1-1807170000 definitions=main-1809100018
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
when we switch back to percpu mode, how can we know the exact value of the ref counter of every cpu ?

Draining the percpu refcounter to zero before switch it back to percpu mode should be relatively
easy to implement. And also, this is the initial intention of percpu refcounter, only switch
to atomic mode when want to drain the refcounter. 

Thanks
Jianchao
