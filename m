Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B352C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37486206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3+v3P5fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbfBOH6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:58:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53464 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfBOH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:58:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1F7n0t9003543;
        Fri, 15 Feb 2019 07:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xGG5BLeVn/vzYF68+/jx4DYwNAgtI72APfiYgr2Yf0Q=;
 b=3+v3P5fpt+Za29UHvG8EqUMOKOXHi3IxxChiljAoBr8DnQvrazWRm6fJBAZ6hnhm3R63
 /3Hc9ZzcN0iG/yJ6qBzkZx1CEDdSrbvDmm10Jv0KeAC73RZ6X/jZY6suRSdTi5jigg3i
 MaKSoCQipA6dams5zSu+VrasLDJQYgsEdZrCJtvOG/K6osjFQ7kfBg4ALROgMN7SmbAw
 vnnoqp2ZtwW21deXeobSgeDmPE0me4Hqi9018l1RQhegnrkF7vt1zSLWnZJVEJPvX+Ee
 2aTYqnggwVlQ3IBfWrH7D4sBUSwb2IRmJQ5vH1gSjCtY+A1G8bDwHXXTIN2OTjr1nnZ4 +Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qhre5va1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 07:58:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1F7w9Js011783
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 07:58:09 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1F7w9g1031533;
        Fri, 15 Feb 2019 07:58:09 GMT
Received: from kadam (/197.157.0.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 07:58:08 +0000
Date:   Fri, 15 Feb 2019 10:57:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH v2] staging: erofs: keep corrupted fs from crashing
 kernel in erofs_namei()
Message-ID: <20190215075757.GG2326@kadam>
References: <20190201121631.15179-1-gaoxiang25@huawei.com>
 <a9381c0d-9857-4d03-710d-80006d426bbc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9381c0d-9857-4d03-710d-80006d426bbc@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=685 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 03:02:25PM +0800, Chao Yu wrote:
> On 2019/2/1 20:16, Gao Xiang wrote:
> > +	/*
> > +	 * on-disk error, let's only BUG_ON in the debugging mode.
> > +	 * otherwise, it will return 1 to just skip the invalid name
> > +	 * and go on (in consideration of the lookup performance).
> > +	 */
> > +	DBG_BUGON(qd->name > qd->end);
> 
> qd->name == qd->end is not allowed as well?
> 
> So will it be better to return directly here?
> 
> 	if (unlikely(qd->name >= qd->end)) {
> 		DBG_BUGON(1);
> 		return 1;
> 	}

Please don't add likely/unlikely() annotations unless you have
benchmarked it and it makes a difference.

regards,
dan carpenter


