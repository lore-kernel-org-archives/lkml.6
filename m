Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA8920818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VqV6yA2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfBUScQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:32:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38888 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:32:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LINkpN001627;
        Thu, 21 Feb 2019 18:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=atIVD4ILPuOHjcsne/XUsEwwvQDrCLJVV6FplUCwJo4=;
 b=VqV6yA2/spU2GPz22Z5YycCOgtpTerEsqdlTGs9kaFxUigH4BS9+jdFkXL3CJMUV/K6P
 WXHlLPTzOERuZr4LocTl22kxnnbV6bEDc2nnbX99DOpy12oV83tD0nR/b97x7JvxEPd5
 6FN41Y8IayeaHMqx+uubjpgGrRGdikYVjU/Fy7XEJCnUpccOsw7LAnAoLrwbx26wbaqJ
 OGe87jESMB5i0YET7poyvx+WthdRVcOojsRe2RJA3vQtpsVAj5gn3TPm9SZ5oPTlrYd9
 2Z9iBVTvs30Fb9skhgpz/Mfd7MpjQsRZ9KpZ5gGIZRc9DBP/WcKdWlDBtfHxLcI89bMa cg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qp9xu9xdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 18:32:10 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LIW4cM016426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 18:32:04 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LIW3bX028380;
        Thu, 21 Feb 2019 18:32:03 GMT
Received: from kadam (/197.157.0.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 10:32:02 -0800
Date:   Thu, 21 Feb 2019 21:31:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>
Subject: Re: [PATCH -next] platform/chrome: Fix off-by-one error in
 wilco_ec/debugfs.c
Message-ID: <20190221070704.GD1711@kadam>
References: <20190220215826.44366-1-ncrews@chromium.org>
 <a0cf4649-e06f-aded-55ad-893560c2414a@collabora.com>
 <CAHX4x87KP9QsnX-vAwyEs45tXngbiSSq+vrByj01S-LpUdO40g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHX4x87KP9QsnX-vAwyEs45tXngbiSSq+vrByj01S-LpUdO40g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:15:18PM -0700, Nick Crews wrote:
> Fixing something after it's already in the tree was a new
> process for me, so I tried to copy other people's examples. Please
> let me know if there's anything else I should do something different
> next time.

I seldom mention how much I like Reported-by tags because it makes me
seem needy...  Also in this case it doesn't matter because it's going to
get folded into the original patch so it's going to be lost anyway.  But
since you're asking process questions, the Reported-by cookie is nice.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

