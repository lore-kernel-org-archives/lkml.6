Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B209C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8AA2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3Cxpj2mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8AA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeLKKIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:08:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53722 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:08:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBBA3fep187673;
        Tue, 11 Dec 2018 10:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xcfh6X1iCfgCIOM5TA1lbZ+h6nUBiMBhdmWu9whNHn8=;
 b=3Cxpj2mklIxyFEdp+01BAfDwnqtq0xOZ2gNzCfthciaFbN8MJzR1qKX3eMPaKmBBuo20
 5/QyQ3iXJUjdznVZi5QphWKcwGpj+8U/4VABcvqYczNq2A9XAJ0H2cKolnZLwsipSq/b
 6p8yWceMC9JmaPjGj9APDcvTKo0zEC2oMHHLafc9pA/dDFosrSPwHi2l+6TZM7I8iehT
 N8rx6ZVcUMXWo0Ou8850U81orQb0CbkjgQ8adKIkLDEbKOvJKkWFbNJY3UHTywCwzmVQ
 EJGTSIC3hrUVcNv3W3dzxfU08AF3RlmdP2Av6ZF9x20ZMhAtqgXS19as+jSAG3D10nQX xg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p86kqtx6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 10:07:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBBA7eNj001895
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 10:07:41 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBBA7du2024301;
        Tue, 11 Dec 2018 10:07:39 GMT
Received: from kadam (/10.175.35.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Dec 2018 02:07:38 -0800
Date:   Tue, 11 Dec 2018 13:07:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Tara Null <tn@fastmail.net>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
Message-ID: <20181211100728.GC3116@kadam>
References: <20181210211231.4084251-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210211231.4084251-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=948
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:11:58PM +0100, Arnd Bergmann wrote:
> Note that I'm changing it back to 'killable' after the previous patch
> changed 'killable' to 'interruptible', apparently based on a misunderstanding
> of the subtle down_interruptible() macro override in vchiq_killable.h.

Oh wow...  The non standard down_interruptible() macro is ugly.

regards,
dan carpenter

