Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79A6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7662086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PDiFxS7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390407AbfAPIvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:51:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41456 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388743AbfAPIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:51:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0G8nGnG157669;
        Wed, 16 Jan 2019 08:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=cYT1XohZQGkO4yk5AtVj8Z3RinnutoeyYKFNnwSkSL4=;
 b=PDiFxS7ZU/bI2W2geEShQj0HwvINYTUtLM8qu5RsvkwS71Aq3mINTDppvX1M9aWik25w
 h/PaK29q5BD2s/TFoqQ7i3Iod6d/bZUNC5LWhKeCtvJQYqCFtkWSoTsp+Y6YNDZQm2vG
 WBi4qvh7TF6xE4DWMNGKwNEoS4XDYXW0KPFjpE7X/hEhGRNlQVklTgX0Ug83x/Wy3Y7r
 Y/RKY2QLHnBOomJOFcCJs57PRAnMuzKh25nT81Tr3UAjmxOc3uGQj6KfPiLl50VFhFSi
 vv6Um8OSlHyj9mQ0ZaoLeDcRbXyLu09WwgHF4mL7Es7UakOt1xUATg/gIMjbyIxnNFLW fg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pybkcgfm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 08:51:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0G8p6eV031322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 08:51:07 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0G8p65d010925;
        Wed, 16 Jan 2019 08:51:06 GMT
Received: from kadam (/10.175.54.137)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 00:51:05 -0800
Date:   Wed, 16 Jan 2019 11:50:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: he: fix sign-extension overflow on large shift
Message-ID: <20190116085051.GC4482@kadam>
References: <20190115180338.32357-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115180338.32357-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=641
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901160075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 06:03:38PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Shifting the 1 by exp by an int can lead to sign-extension overlow when
> exp is 31 since 1 is an signed int and sign-extending this result to an
> unsigned long long will set the upper 32 bits.  Fix this by shifting an
> unsigned long.

You could just cast it to unsigned.

	rate_cps = (unsigned long long) (1U << exp) * (man + 512) >> 9;

I don't think it makes a difference at runtime because we just
pick buf = 4 either way...

regards,
dan carpenter

