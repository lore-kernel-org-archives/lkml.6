Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B37C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57B720657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BGyiRrLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57B720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeJ2O2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 10:28:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52504 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeJ2O2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 10:28:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9T5dwYk074751;
        Mon, 29 Oct 2018 05:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=y/pY/zwn9+AjKsefh0p1MoafWjVNm5Je0Lglt2Y72O8=;
 b=BGyiRrLkXqBiGlaeCrsFaZNKkJCh4Oc5cOYBBr9UMgWgSu/EWgEtwv+O+DhVA6UkCNi/
 yXBdcJYSmNZmmUakWIPGQlLRKyLCwf/15M4uDuz7WynSugBg5ceFPRxvG1CwNi0e1dBo
 BIN8vy3J1PXnPHg/SmoJfnn1SVRGk62X8mFgRhrI2AT/mPlELhmFoILoEYC6+RVowLnL
 edMGQcf7oPEX8oH4drYBbAE1hmN4eThPBZV+UTmrtPE/fyTn458ywqoK0+MU31t/Ul4o
 wMB9N/QR81k+MyOERjYBV8aEntZu+5mUQS7iK498Y+7FRjinsUCWj/oDpaSwy10r/bps Jw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nduckr49j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 05:40:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9T5elZq023962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 05:40:48 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9T5ekdm005290;
        Mon, 29 Oct 2018 05:40:47 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 28 Oct 2018 22:40:46 -0700
Subject: Re: [PATCH V2 1/3] blk-mq: refactor the code of issue request
 directly
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
 <1540569671-6589-2-git-send-email-jianchao.w.wang@oracle.com>
 <20181029024937.GC32606@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <64ec3df3-27f8-4d75-5ec9-6427ffcf1244@oracle.com>
Date:   Mon, 29 Oct 2018 13:40:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029024937.GC32606@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9060 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=749
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810290055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 10/29/18 10:49 AM, Ming Lei wrote:
> On Sat, Oct 27, 2018 at 12:01:09AM +0800, Jianchao Wang wrote:
>> Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
>> into one interface which is able to handle the return value from
>> .queue_rq callback. Due to we can only issue directly w/o io
>> scheduler, so remove the blk_mq_get_driver_tag.
> 
> It isn't correct for dm-rq, see blk_insert_cloned_request().
> 

Yes, got it.
when the original requests are issued to the underlying paths as cloned
requests, they should not pass through the io scheduler.

Thanks
Jianchao
