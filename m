Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB08C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB862085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HKCLm3zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB862085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeJKO7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:59:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58668 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeJKO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:59:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B7TNeJ012545;
        Thu, 11 Oct 2018 07:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=D6ZbIURfJB1M9Bk+DXYFmDVaHVlSdMHbDoduECvLvZo=;
 b=HKCLm3zQzwngUChCdekqMU7TsSZ9wm+ZF70aRov1boYJ2tobbBauNnfrlzWFsrbsNVkb
 NT3wuLbhxPyicxhwoKGeMsi08bCE1g0Z0K1EClsCC1BC5/Apwkd/cKsVGrY1zjREUTK+
 UzO6ALYM82DsMPNFA8vrCLrwOkEKl4piyzFPhqwUCbxFzTmblEBOb7ymXu89qnpBoyVD
 NmuBUeXrZmvsLNxJGpS6IAE5fL4tJK0E2672AGJASYAf7X1tNrKDhKxVgaQUKemrHjxs
 +s3I/QFUBLiXFJrrj9kug4nzy4O04lfr08jBwYkOJ2s/TYpLVxT1cXResxUkFSnuesWb JQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mxmfu2des-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 07:32:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9B7WEaf017760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 07:32:14 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9B7WCkA002496;
        Thu, 11 Oct 2018 07:32:12 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 07:32:11 +0000
Date:   Thu, 11 Oct 2018 10:32:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Gabriel Capella <gabriel@capella.pro>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: fix 2 checks
Message-ID: <20181011073203.iesapekyqkma2cqa@mwanda>
References: <20181006162715.GA8476@mantaray>
 <20181006202542.GC5035@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181006202542.GC5035@x220.localdomain>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=721
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 10:25:42PM +0200, Slawomir Stepien wrote:
> On paź 06, 2018 13:27, Gabriel Capella wrote:
> > This patch does not change the logic, it only
> > corrects the checkpatch checks.
> > 
> > The patch fixes 2 checks of type:
> > "CHECK: spaces preferred around that '-'"
> 
> I've made the same mistake few days ago. This change is incorrect.
> Please see: https://lore.kernel.org/patchwork/patch/635994/.
>

You could add a comment.  /* do not put spaces around the hyphen.  #checkpatch.pl */

These are the only places which use this style and a lot of people
bump into it.

regards,
dan carpenter

