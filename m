Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DDC81C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EB1208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V0J5V6Dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EB1208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965589AbeFOJOz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:14:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40502 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965488AbeFOJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:14:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F9DR7S179678;
        Fri, 15 Jun 2018 09:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=V7R9cSLezLof/PilyE6KnIwC5iCm1kmfpruC4cfSCT8=;
 b=V0J5V6Dqww16H2brbmiTtMByYPqsYKYuUImY2X2aynaJu1q9S3xzeE6mLwdvjjfoMbC7
 gKvNCnPR5tmHY90rpkY0aYohxpG+X5t9hFAkftqKIQY+RLObEhBL62Y7jkmd595SgfhW
 tLHfmBGdc7nD85uq+xnlhfDqsjOLsW+CQDtuUWItxXkLN0+5B3MvrHDRGwdwW1fJ00RB
 Q3DxKVJHECvPg6pJcb6ZzSRDAQsZPzb7mW285OQdKKqb/vOH/asBNLruIurx1Qn3a7a9
 UPCzQI+iTgkA9scXcgxWFlQ5OZL7EntYHXSCxQR3NQnjDERk7C+9zdY3TUaKXhJlJAEl LA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jk0xr08b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 09:14:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5F9EYWk022026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 09:14:34 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5F9EYrG008133;
        Fri, 15 Jun 2018 09:14:34 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 02:14:33 -0700
Date:   Fri, 15 Jun 2018 12:14:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     haiyangz@microsoft.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org, olaf@aepfle.de,
        sthemmin@microsoft.com, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, vkuznets@redhat.com
Subject: Re: [PATCH net] hv_netvsc: Fix the variable sizes in ipsecv2 and rsc
 offload
Message-ID: <20180615091412.kh7zzt4b7arrjae2@mwanda>
References: <20180615012909.13440-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615012909.13440-1-haiyangz@linuxonhyperv.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=430
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 06:29:09PM -0700, Haiyang Zhang wrote:
> These structs are not in use right now, but will be used soon.

Btw, thank you for adding this information.  I was wondering about that
in the first version of this patch.  It's always useful to know what
the effect of a bugfix is even if the effect is nothing at this time.

regards,
dan carpenter
