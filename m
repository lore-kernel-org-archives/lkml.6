Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA07ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4381A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WofuVJtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4381A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeIRSgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:36:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37358 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeIRSgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:36:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8ICrfTB021030;
        Tue, 18 Sep 2018 13:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=zyqbeIcv4LSFft+iU0mSjfXsfU+r6SVVmkHKP9pY/O0=;
 b=WofuVJtKPAetZvCaXkiJtKQZqUEgUnLmkM1zsmlfVWsQE+iDKkOGbL0Y11P/FyytUg8S
 jX9CsHvVMv/VxEyC7oUOZA2Z5Yi10WcFM77hvYYkaj4xnpo1F8scM7Q9PRG/fZ3Njx88
 jn6sDK9FReyzSdx2ZeWfphESJkjYfM4YHs0Zwed3p99f5v1uGA3jXspmw7Z1HZJD7wUW
 zShSqEip0MltzoC8H7dny7ghIYL8tD3B1euWe4TxFdrFgfbvniicFZj4+ohwboRVfnfW
 k8ek6BP9mk5vy3IZeakenPXoltewwFGei1cFbpE4g6v6IatRfjRBXVTmyAf7r8URtxTi PQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mgsgtm8n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 13:03:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8ID3oX1004708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 13:03:50 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8ID3neW011664;
        Tue, 18 Sep 2018 13:03:50 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Sep 2018 06:03:49 -0700
Date:   Tue, 18 Sep 2018 16:03:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 0/8] staging: erofs: error handing and more tracepoints
Message-ID: <20180918130337.jtq6ziqp6efr3fq4@mwanda>
References: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
 <20180918111953.GA3585@kroah.com>
 <aab26d0e-f8dc-cc83-46eb-7a93a833eaae@huawei.com>
 <20180918121413.GA499@kroah.com>
 <e940cdaf-faeb-7f60-b5ca-5f4d6af450be@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e940cdaf-faeb-7f60-b5ca-5f4d6af450be@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=976
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 08:31:22PM +0800, Gao Xiang wrote:
> (I have no clang environment to build kernel yet... :( I will try later, but I have no idea why it happens,
> and it seems a false warning).
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Or is gcc just being "dumb" here?  What about clang, have you tried
> > building it with that compiler as well?

Yeah.  Gcc is wrong.  Gcc used to be extra conservative and missed a
bunch of bugs, but I guess now they're going in to opposite direction?

Smatch gets this correct, but you have to rebuild the cross function DB
twice to make the warning go away.  It could be because it starts out
with the old vle_get_logical_extent_head() information so it thinks it
knows how that function works.

regards,
dan carpenter

