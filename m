Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00F4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF9206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rXAwABXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EF9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIFQed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:34:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53228 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIFQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:34:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w86BsbGZ165011;
        Thu, 6 Sep 2018 11:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TxrH6xD0BcHhU1tDyipN73KRXulpBL9j/3XnQjQzuEA=;
 b=rXAwABXc44NZKqPkEqFb05/QzzZYAtS+al5sfItOwfB0nD2mw0xaSn7fiZPWfVzQCO5s
 tqk92SprqL/B8NLNzZfBu4lsMHW1I5QQcXAimUFjeQIIs2lMVAALoQzdGi8VLUzUhTbG
 EHlGt+qqB+gEWS36SS2bNzA4pwa15GR6HgANBi9z5sqtCSglNUOFGURhgcATTQHc35+K
 6l5WUzBOSNWedDDYxw/T8gfQCUIeMoyoNItxKg+iK6MLEfVHVmPQySlVhSpAeGqO2Xn2
 jV6w62Sh7OyYEgKSHvsZRyaoUX5lL6u4l++F11g86bMZ0uWxMczJqvCusbv0NOlhvdt6 oA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m7kdqug7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 11:58:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w86BwQk3021298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 11:58:27 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w86BwNef030558;
        Thu, 6 Sep 2018 11:58:23 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Sep 2018 04:58:22 -0700
Date:   Thu, 6 Sep 2018 14:58:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sgtl5000: avoid division by zero if lo_vag is zero
Message-ID: <20180906115814.a5woyhfc5sczxksa@mwanda>
References: <20180906104152.17977-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906104152.17977-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=585
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 11:41:52AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where lo_vag <= SGTL5000_LINE_OUT_GND_BASE, lo_vag
> is set to zero and later vol_quot is computed by dividing by
> lo_vag causing a division by zero error.  Fix this by avoiding
> a zero division and set vol_quot to zero in this specific case
> so that the lowest setting for i is correctly set.
> 

This is a very clever patch.  How did you find the bug?

regards,
dan carpenter

