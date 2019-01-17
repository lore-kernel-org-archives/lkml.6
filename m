Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CF420856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4Lo8jJ0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfAQHLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:11:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32838 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfAQHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:11:33 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0H78rpx175782;
        Thu, 17 Jan 2019 07:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=b423RMdU3AUnioyRKGdsHy59wQ+FNlTIlTxn6ZkJyls=;
 b=4Lo8jJ0LW/Ena9Z1BFTcftMNCUdonBm3iAsGkW/z2zgiqvaNb8H3cR57OKbABrrFLJs/
 YgtIpGSM4X5M13I34OxNytE1Fi57Ly/Aw4xhGFrB5C794zbX/6vAMksCmS+J5jDcyEaz
 US16v95BZnrVS4dkR6JfgAMs+nPS1jl+yy8XBbEry4oKLa/zHnOPk90uYB/9vQWWqXmm
 DSrkaEx3cInLgReVOyWL32PIg+d3AqaTBQk3Q4610fe21N3L5rRd4J8GPomrdRkdMbQ6
 VQSdDpSOWGX88PvIM5jbml5ScaIb03Y8o4flFHv0NYQ72V3ocGhrQbSVUUVKhezg0mFe kw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2pybjnx5gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 07:11:11 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0H7BBiL001899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 07:11:11 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0H7BAKD029864;
        Thu, 17 Jan 2019 07:11:10 GMT
Received: from kadam (/41.202.241.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 23:11:09 -0800
Date:   Thu, 17 Jan 2019 10:10:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] cifs: fix memory leak of an allocated cifs_ntsd
 structure
Message-ID: <20190117071048.GF4482@kadam>
References: <20190116162859.8028-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116162859.8028-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=756
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Colin!

Reviewed-by: Dan Carpener <dan.carpenter@oracle.com>

regards,
dan carpenter

