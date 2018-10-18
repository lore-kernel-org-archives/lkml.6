Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10067C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83F32083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cr+uHVw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83F32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJROcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:32:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37552 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeJROcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:32:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9I6ShFj101232;
        Thu, 18 Oct 2018 06:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Ow+onmQT5zhtUN055H5n4m3TLvroRI1ItihEQuboK/4=;
 b=cr+uHVw+wX97XhztgAUERffD9MrhUyLYAwspkMVGsaGffylDJjqT7Nl1mzXyUXG9Bc3j
 zsex2bpxJxE7Fu8rVHRWoljmLMfKbIRq+ZgjcRWUPb8ZelVh2ByC1uGODppzDDw5Iquo
 4frXFG93lueI32NqJHzr5QSUsUBVBhGtHELs9Swn7kIuGWQTSkzereJfIiykybfTzXkE
 c9wQnd3Qy28nCOY1ey9/ojmaH+ICR86xjAKeEb9sCuh6j2+H8m1MzNXY0bZyeW07D/Gs
 jaVJ1/oKWbFPXUXUC4OLdeaOaO/t7L5DNkVvt3CZ1w63aKiaq+utlTa08Wyow6+hnDkF uA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n38nqcgsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 06:32:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9I6WgBs011520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 06:32:42 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9I6WdHP025771;
        Thu, 18 Oct 2018 06:32:39 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 23:32:39 -0700
Date:   Thu, 18 Oct 2018 09:32:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kys@microsoft.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH V2 5/5] Tools: hv: kvp: Fix a warning of buffer overflow
 with gcc 8.0.1
Message-ID: <20181018063230.v6hp5e3agk62c3s3@mwanda>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
 <20181018050932.27932-5-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018050932.27932-5-kys@linuxonhyperv.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=796
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 05:09:32AM +0000, kys@linuxonhyperv.com wrote:
> From: Dexuan Cui <decui@microsoft.com>
> 
> The patch fixes:
> 
> hv_kvp_daemon.c: In function 'kvp_set_ip_info':
> hv_kvp_daemon.c:1305:2: note: 'snprintf' output between 41 and 4136 bytes
> into a destination of size 4096
> 
> The "(unsigned int)str_len" is to avoid:
> 
> hv_kvp_daemon.c:1309:30: warning: comparison of integer expressions of
> different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
> 

Ugh...  Any tool with the most basic flow analysis would realize this
was a false positive.  We use at least three static analyzers which
catch signedness bugs.  Can we turn off GCC's warning on this until they
improve it a bit?

regards,
dan carpenter

