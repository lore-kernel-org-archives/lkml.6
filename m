Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9D3C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF9E217B8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JL29IMFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF9E217B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeHMOpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:45:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32768 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHMOpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:45:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7DC3cBd075113;
        Mon, 13 Aug 2018 12:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0xW0/FoO+UYxsj9H9LR46Si5Zn78V5idlDbPA2D2q94=;
 b=JL29IMFMGK1AJ+HzBHBNEcV6PzgWiloCkb5J7wP0+4AuH+f4Ar/YFgROJQcljLHP5G6U
 3ySWNkw9vYQ6GwRibLTr5EM8SQMdi5vmzNklmRtfcd9XshXlAox/5Qgx+FAhxTf/tcXy
 wH1Qpk3TQer4+BS8c4pJUlxTrsp7JPyQ6oFDNFfk56z6VOxeUzUx8/x1wNCnfdp5oER7
 2y8u9Zow30yYLAX+Ve2G7c7D66zxv6GvkoSmelru4K7oemAH0NIGl/L4EoGKthAWMTI9
 d5k0b96XX42YDLZ4CQ57pO9tJsKcR5/kwdoQRABcnodeiE72XnxhYMBtMDuTdnkvMJUB cw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ksreput28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 12:03:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7DC3cJ8003106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 12:03:38 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7DC3bXX004327;
        Mon, 13 Aug 2018 12:03:37 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 05:03:36 -0700
Date:   Mon, 13 Aug 2018 15:03:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <chao@kernel.org>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] staging: erofs: fix vle_decompressed_index_clusterofs
Message-ID: <20180813120324.ibzrmftxji62ji6r@mwanda>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-7-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812140150.13397-7-chao@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=553
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static inline unsigned
> -vle_compressed_index_clusterofs(unsigned clustersize,
> -	struct z_erofs_vle_decompressed_index *di)
> +static inline int
> +vle_decompressed_index_clusterofs(unsigned int *clusterofs,

Not related to your patch, but don't make functions inline.  Leave it to
the compiler to decide.

regards,
dan carpenter


