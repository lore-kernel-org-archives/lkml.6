Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEBEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9582184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Do8U8X/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfBAIQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:16:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46044 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfBAIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:16:00 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x118F0e9022039;
        Fri, 1 Feb 2019 08:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YOzD41q6YDNLkf4HZNk7qLO6UNJRxdzPj11xqj2GirU=;
 b=Do8U8X/kAMO+A+OL9YkB4uSpmIzyXpwRCX2eNneqEUIpNgopH2p3wGhYIhOVJESqyDhO
 MNBLlyvICBh8lUZffV+aAeYESWAby9asIk5O+ObfOt7wlWZ+/j0dDXEd5pQ2Zy1yGQ0v
 H36a1yKLHWUp1a2bvcuKCP/C1IhcXRVxPgyeDDO+biXZ6vnQZ1q6AkL1QIyOF+GVGa+j
 uvLeeNnEyDxizhwAyghZh2ClWgPEH+iePvWg+qeYbM7BHkAUJyyfKnpM3H7Ygdto9EpZ
 laFtVGBdH5Wr4xxwy23dXSQUAxMIGwTRS2YcQrNmqrSTxDjYKjh5VimkCSnS8ccfjUh+ CA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q8g6rn1mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Feb 2019 08:15:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x118FjiN009211
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Feb 2019 08:15:45 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x118FiKS017898;
        Fri, 1 Feb 2019 08:15:44 GMT
Received: from kadam (/197.157.0.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Feb 2019 00:15:43 -0800
Date:   Fri, 1 Feb 2019 11:15:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Qing Xia <saberlily.xia@hisilicon.com>
Cc:     labbott@redhat.com, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, devel@driverdev.osuosl.org,
        puck.chen@hisilicon.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kongfei@hisilicon.com,
        linaro-mm-sig@lists.linaro.org, daniel.liuyi@hisilicon.com,
        yudongbin@hisilicon.com
Subject: Re: [PATCH] staging: android: ion: fix sys heap pool's gfp_flags
Message-ID: <20190201081530.GC14343@kadam>
References: <1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9153 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=759 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 02:59:46PM +0800, Qing Xia wrote:
> In the first loop, gfp_flags will be modified to high_order_gfp_flags,
> and there will be no chance to change back to low_order_gfp_flags.
> 
> Fixes: e7f63771 ("ION: Sys_heap: Add cached pool to spead up cached buffer alloc")

Huh...  Presumably you found this bug just by reading the code.  I
wonder how it affects runtime?

regards,
dan carpenter

