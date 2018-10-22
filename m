Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E638C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0355420658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cmbkHNt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0355420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeJVSc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:32:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45054 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeJVSc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:32:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MA8Y14085351;
        Mon, 22 Oct 2018 10:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vFGiNDGgucXti1BiSi8qMgC4RPigauu/xhnIYWvHlKU=;
 b=cmbkHNt1JQKHv55Nx01fNJaImFLm1KqOeAB5asQ3jPVynWJ1AQan5qvxRxaCowvRLGwJ
 viw3bL86fVleRRU7plnV8qVAK4/IukwT5GY0ehxOQScTcQ/glzb6yg5QXzbghH/QXGSq
 +1wu3AYJIjI7ayhmQ84GYXJKhoWiFGo9OU01CHctntfDIg8o6TbViFgCrTOXeju6XeiM
 06M6inV7iJ7ooS20TF56dhRT9hg+oEY2/UppOfW5sUO7rKzX22Nh1Y2zE5Y9cgaCECIc
 ciDPZcVh7DI0oRzcYyroeZ8JK6S/GUmxGzBEkefU8ei6gASqHgB/IH+eGL64XzCvVk7k CQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n7ustwk0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 10:14:28 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9MAERvD028100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 10:14:27 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9MAERwa003118;
        Mon, 22 Oct 2018 10:14:27 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 03:14:27 -0700
Subject: Re: [PATCH V2] block: fix the DISCARD request merge
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com>
 <20181022090601.GA21171@ming.t460p> <20181022090849.GA19053@lst.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c53fc061-2a83-428d-b3c0-87feff375f42@oracle.com>
Date:   Mon, 22 Oct 2018 18:14:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022090849.GA19053@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=714
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/18 5:08 PM, Christoph Hellwig wrote:
> On Mon, Oct 22, 2018 at 05:06:02PM +0800, Ming Lei wrote:
>>
>> The above may be changed to 'if (blk_try_merge(req) == ELEVATOR_DISCARD_MERGE)'
>> or sort of in future, which may has document benefit at least, since
>> ELEVATOR_DISCARD_MERGE means multi-segment discard merge.
> 
> I like that idea, and we should do it for the respin
> 

OK, I will use the blk_try_merge in next version.

Thanks
Jianchao
