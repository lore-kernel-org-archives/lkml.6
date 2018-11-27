Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82892086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ECNfnEmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82892086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbeK0TrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:47:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51182 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbeK0TrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:47:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAR8iEqY054392;
        Tue, 27 Nov 2018 08:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lYICSsLS0iRJ/0uL6ag4MEBkf4EeBwMF7Xm0Fh4dQJ0=;
 b=ECNfnEmVLoNa7y/5tshqu4XznooeT7YHya8Ij1hg+gaN98y2xEz08CP/mKrsPHuRMKfx
 bpZ7Z50IQJjZFXKPdHhaNzaa3pn3fPLK4gc8dOOHLxhiku9otL30MUwsYyS0obBcNRit
 5nsaJ4qTOZgNvWusCEsmPjGpjKWGDBTTeeoTe6aKhp1YrYeVkavc9EUwk+KtZsBgsOmW
 PF2y4aDktHW5wb48sGNZlC8mNdxMd5tpb4XFlioUUtSzSzSV9PYnLfZLUfMkG7BjJfAr
 ZUJhBd/zloYS2Mkrd3c6rIAv47lyiIY53GtqBXBJxLp4yBR4HSgQ00sq8AE/j/oUypd2 YA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqaem8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 08:49:53 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAR8nlp0019885
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 08:49:47 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAR8nkkU018903;
        Tue, 27 Nov 2018 08:49:47 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 00:49:46 -0800
Date:   Tue, 27 Nov 2018 11:49:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Xiao <YangX92@hotmail.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jananis37@gmail.com" <jananis37@gmail.com>,
        "r.weclawski@gmail.com" <r.weclawski@gmail.com>,
        "santhameena13@gmail.com" <santhameena13@gmail.com>
Subject: Re: [PATCH] staging: rtl8188eu: Fix off-by-one in core/rtw_mlme_ext.c
Message-ID: <20181127084928.GO3088@unbuntlaptop>
References: <HK0PR01MB216364A68D785B7EBC8DD43EADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
 <20181127081542.GN3088@unbuntlaptop>
 <HK0PR01MB2163A0287797ECA3CDA68AA2ADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
 <20181127083427.GS2970@unbuntlaptop>
 <HK0PR01MB2163FB565C3ADD4BCE1FE7D2ADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB2163FB565C3ADD4BCE1FE7D2ADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=743
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 08:41:53AM +0000, Yang Xiao wrote:
> Okay. I can send a patch to revert ef9209b642f.
> 
> But, can you make sure that the condition "(pstapriv->sta_aid[pstat->aid 
> - 1] == NULL)" can satisfies in the for loop?

->max_num_sta is either set in _rtw_init_sta_priv() or rtw_set_beacon().
You can see that it's <= MAX_STA.

regards,
dan carpenter

