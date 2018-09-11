Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D0AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B568C20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XrJrX6CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B568C20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeIKJiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 05:38:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51532 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeIKJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 05:38:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B4d2HV024986;
        Tue, 11 Sep 2018 04:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=K6584tUf+jiABk6HMltVlfFhB3coE6drQg86b335fJI=;
 b=XrJrX6CP21VJhQY7XkKVKJlCmqqtKp7cYy7eSeLkLdryCvQm0x04KKru5k/DKX1j1EBe
 pK8HVxn6BCO3ineXlIZXQedB6j6rt6wrVgWYkDQcvIeJLOumPjgio9fYMkxep3kkxjh6
 t8ktqwqMw5WrpE4dkhaT5v+/BX+qhUwdRiUUcUSjc4BzXny6XXOLO7exShmLxnWZDN21
 Fli4+EZ8N0r9QcDP8hdrfgmvjLkqKJFmBsNvJuarH/ykOzL9ARQFzbGaPDElP8fGqJu6
 yxGTRF6G+Ka5zznKzQE9g0qNd3RL6aw98kWU1RLYkylzPpAvNHBaH0tougqwiS464RLe zg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5ut9kt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 04:40:43 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8B4ebgL017952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 04:40:38 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8B4ebUV015253;
        Tue, 11 Sep 2018 04:40:37 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 21:40:36 -0700
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
 <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
 <20180911040323.GC30977@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
Date:   Tue, 11 Sep 2018 12:40:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911040323.GC30977@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=488
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 09/11/2018 12:03 PM, Ming Lei wrote:
> After the refcount is switched to atomic mode, the whole counting is
> done on the atomic part. Then if the refcount need to switch to percpu mode
> again, all percpu part of the counter is re-initialized as zero simply. This
> is invariant with/without this patch.

Does the "whole counting" here means ?

(long)(sum (every cpu's refcounter)) + atomic refcounter

and when switch to atomic mode, there could be value left in atomic refcounter.
then the unsigned long percpu refcounter cound be decreased from 0.
	
From another angle, one request could be ended on a different cpu from the one where
it is issued.

Thanks
Jianchao
