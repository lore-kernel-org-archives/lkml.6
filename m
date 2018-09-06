Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E465DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861C92083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="op8Sg2o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861C92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeIFGDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:03:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36692 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeIFGDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:03:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w861TXek173864;
        Thu, 6 Sep 2018 01:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3T9ZqV/IZCowlUOJneNIv3S8gnzw9SPNsEDpy2xGQ48=;
 b=op8Sg2o28HLa8kPbrAnPzPvozaxENOJGmOcnWuO9Xl9MbwmLj2pacoGRJJBpRdYf9FmW
 SVh6By0lO8JvHC0ZmL7qjNiz2rcHE/crL8coY5KNUS5ZPgEXaFuwQMeDvdHeK0x1TWzE
 m2nFNRee4Ot5nc0aaYOv6EzwO3fozLcLa/vVugC77s0T8RYVoYD2vpwChVrHoFGno12I
 vAAi9Vytkbdbzzrn9T2wPA9XTOQpvHyYMzHeMNdUuQhqIO1RQfddB+5/BSSvf0csnWl8
 xJ4ni3/XSs9ZhvoX0P0yTVPUY9q2/jyRvw+XxRyOwfew1jBJuBTtq+HGSuH+a+eqCMpN 4A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2m7j6tqgfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 01:30:22 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w861UGGA010053
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 01:30:16 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w861UGFK018139;
        Thu, 6 Sep 2018 01:30:16 GMT
Received: from [10.182.69.224] (/10.182.69.224)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 18:30:16 -0700
Subject: Re: [PATCH 2/3] blk-core: introduce queue close feature
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        ming.lei@redhat.com, bart.vanassche@wdc.com, sagi@grimberg.me,
        keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-3-git-send-email-jianchao.w.wang@oracle.com>
 <1536163037.11534.6.camel@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ccf20c21-880a-98ca-b111-8e6b82b47a11@oracle.com>
Date:   Thu, 6 Sep 2018 09:31:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536163037.11534.6.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

On 09/05/2018 11:57 PM, Bart Van Assche wrote:
> On Wed, 2018-09-05 at 12:09 +0800, Jianchao Wang wrote:
>> blk queue freeze is often used to prevent new IO from entering
>> request queue. However, becuase we kill the percpu-ref
>> q_usage_counter when freeze queue, we have to drain the request
>> queue when unfreeze. This is unnecessary for just preventing new
>> IO. In addition, If there is IO timeout or other issue when unfreeze
>> the queue, the scenario could be very tricky.
>>
>> So we introduce BLK_QUEUE_GATE_CLOSED to implement a light-weight
>> queue close feature base on the queue_gate to prevent new IO from
>> comming in queue which will not need to drain the queue any more.
> 
> Does the "queue gate close" feature cause blk_get_request() /
> blk_mq_get_request() to block until blk_clear_queue_closed() is called? 

Yes. It works in blk_queue_enter. So it could cover blk_mq_get_request

If
> so, I think we need a better name for this feature. How about calling these
> two operations suspend and resume?

I'm open for it. :)

> 
> Thanks,
> 
> Bart.
> 
