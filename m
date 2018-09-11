Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C30C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB3220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VbII7OUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB3220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeIKTWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:22:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKTWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:22:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8BEJQaE134884;
        Tue, 11 Sep 2018 14:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=CKWyAbFc8M7uowMRSNOPyYR5frAzP4Z20kDs5JGd4A0=;
 b=VbII7OUsTJKIrA5+6n8wBe7+xyrSPtTbgahz7dOZbdJbHH5QUCnilk2NMn/4zFqwu2eu
 VKicoI/DN/orwSF2ZAuIv/UOarGjufahULVVHWh4bSjBZ8XqNoJnzVmGtN7VyaSM1SYD
 o2ds+mF71binnk4gEVQArJ+w+K4DrLDlaKw3Eu+zeGADHiCUbva385bHHBAii8gS64gs
 UaTMh7YEYATPwnY3MnBv4CzQCGoFKiAwjonevMc1nEj5CMDYX3UwcZs66qQfvSBS6ZWB
 /+67KikV7p31z7+8jGhoYfdOb2G5RdOiareWYoXYuWaWHckRsdb4Vf1+VAiLvrS2jkSR Fw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mc5utckqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 14:22:23 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8BEMMPB017241
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 14:22:23 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8BEMMkS004761;
        Tue, 11 Sep 2018 14:22:22 GMT
Received: from [10.191.3.83] (/10.191.3.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 07:22:22 -0700
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
 <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
 <20180911082023.GA5360@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <096be5c0-a69f-4553-5507-5fcdecc1ea20@oracle.com>
Date:   Tue, 11 Sep 2018 22:22:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911082023.GA5360@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=630
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 09/11/2018 04:20 PM, Ming Lei wrote:
> We only check the 'whole counting' at atomic mode, so it is the atomic
> part('ref->count'), please see percpu_ref_put_many(), in which ref->release()
> is only called at atomic mode.
> 
> At percpu mode, the ref-count is only decreased/increased on the local CPU.

Yes, I got it.
Thanks for your kindly response.

Sincerely
Jianchao
