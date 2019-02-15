Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512C1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B1221B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mkTw7k1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392931AbfBOJfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:35:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39476 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBOJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:35:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1F9XlTf089418;
        Fri, 15 Feb 2019 09:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=+RB02ueo5EzSN1SvadwA/3sS1Xx5cCyLiZbxDRhnnUo=;
 b=mkTw7k1I7L6u93e3/EcS4e0lAr2hZAdg2nni5o/MyFMZJ718xFtWmcTrXHQCQoNDdvie
 4BeULQ1LCUrzLWagmGDwtRA9QNlX0CkLunNV9IxH9vMtZQnH6Fvw43mEjFBX8IhRVXyJ
 vTPQmEmzZkoQGKxd5MnUvRo2YJObLtu6BEwFv7e6nYKvVG4yJDKr6yviVb2ykFRsOIMe
 uWYcJkaWxCb0f76o+JMxVL8qzZn5idA6jjq1HvUle+7Qso72tgkOuBRIEHliXGaqVTq6
 eMTiBacCEgymHhKHuhQKi26Wah4bZvRcuEARNm1OuprOOgbBJAAT9cmrIHvAwIgVnghn Bg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qhreectrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 09:35:16 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1F9ZFEE022622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 09:35:15 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1F9ZENP010706;
        Fri, 15 Feb 2019 09:35:14 GMT
Received: from kadam (/197.157.0.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 09:35:13 +0000
Date:   Fri, 15 Feb 2019 12:35:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        weidu.du@huawei.com, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-erofs@lists.ozlabs.org, Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v2] staging: erofs: keep corrupted fs from crashing
 kernel in erofs_namei()
Message-ID: <20190215093503.GH2326@kadam>
References: <20190201121631.15179-1-gaoxiang25@huawei.com>
 <a9381c0d-9857-4d03-710d-80006d426bbc@huawei.com>
 <20190215075757.GG2326@kadam>
 <fb99bac2-2587-04fa-6ac2-f2e5f83af7c9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb99bac2-2587-04fa-6ac2-f2e5f83af7c9@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=656 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 05:32:33PM +0800, Chao Yu wrote:
> On 2019/2/15 15:57, Dan Carpenter wrote:
> > On Fri, Feb 15, 2019 at 03:02:25PM +0800, Chao Yu wrote:
> >> On 2019/2/1 20:16, Gao Xiang wrote:
> >>> +	/*
> >>> +	 * on-disk error, let's only BUG_ON in the debugging mode.
> >>> +	 * otherwise, it will return 1 to just skip the invalid name
> >>> +	 * and go on (in consideration of the lookup performance).
> >>> +	 */
> >>> +	DBG_BUGON(qd->name > qd->end);
> >>
> >> qd->name == qd->end is not allowed as well?
> >>
> >> So will it be better to return directly here?
> >>
> >> 	if (unlikely(qd->name >= qd->end)) {
> >> 		DBG_BUGON(1);
> >> 		return 1;
> >> 	}
> > 
> > Please don't add likely/unlikely() annotations unless you have
> > benchmarked it and it makes a difference.
> 
> Well, it only occur for corrupted image, since the image is readonly, so it
> is really rare.

The likely/unlikely() annotations make the code harder to read.  It's
only worth it if it's is a speedup on a fast path.

regards,
dan carpenter

