Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B292085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0LmtCe9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B292085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeJKRpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:45:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44136 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:45:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9BA9EJT177311;
        Thu, 11 Oct 2018 10:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=LlfVbzetiWTuJGiZOmK8BtgunFI8r6KQ83IsX8U7eJ0=;
 b=0LmtCe9gTa6Zcm3fkzIPbyXkwdG4vJO00x+/sp4SI9f+0sfZ1vQj9kZ+CoP0TkKTHZVA
 AmZEwHUe2vWSCBStZP9OS8t3f2L+MgItXOJ8CtYHwVGRFYlWA81ERpolht7L6wF+tk0O
 PO2DODFjz4mIAcbOS0GKgXxUUZJWgoK4HOhv8kscSwspqi0ncV8A8ZI2OCftqMKTJrL5
 ygeRCHrbnD/iTLURj7vOeZB0zX39QbaQlmSEqYXp2Pf9o24cB2qmdRRbehRMqUSqRCDo
 mleRtFx1KIfAeFI70Z218TExO+Vz0yIpaJMAe10AURBghJb85fjdR8ieoMau1GJaVzMk DQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mxn0qb8f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 10:18:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9BAIGVG021720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 10:18:16 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9BAIFun009899;
        Thu, 11 Oct 2018 10:18:16 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 10:18:15 +0000
Date:   Thu, 11 Oct 2018 13:18:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH] staging: erofs: harden inode lookup for 32-bit platforms
Message-ID: <20181011101807.hydncp6nhzjlzznr@mwanda>
References: <20181009140713.29629-1-gaoxiang25@huawei.com>
 <20181011084413.3sovzgsj6pzyrml7@mwanda>
 <b6baf932-64e5-c902-7e7f-02094b96a8d6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6baf932-64e5-c902-7e7f-02094b96a8d6@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=733
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:46:26PM +0800, Gao Xiang wrote:
> 
> 
> On 2018/10/11 16:44, Dan Carpenter wrote:
> > On Tue, Oct 09, 2018 at 10:07:13PM +0800, Gao Xiang wrote:
> >> This patch introduces inode hash function, test and set callbacks,
> >> and iget5_locked to find the right inode for 32-bit platforms.
> >>
> > 
> > The way I read this changelog, we're trying to deal with corrupt file
> > systems?  Is that correct?  Presumably in the current code it could lead
> > to a Oops or something?
> 
> No, this commit isn't trying to deal with corrupt file systems.
> In EROFS, the nid is not continuous and it represents the inode offset
> inode offset = nid * 32.
> Therefore the nid is 64-bit both for 32-bit and 64-bit platforms. However,
> i_ino is 'unsigned long', which means for 32-bit platforms, i_ino is not enough
> to contain the nid.
> 
> Therefore, we should use iget5_locked for this case.

I guess what I'm saying is, what are the user visible effects of this
patch?  It's hard for me to tell from the patch description.  Could you
please re-write the description and send a v2?

regards,
dan carpenter

