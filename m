Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07DAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FEC21A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2vyDTlT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FEC21A0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbeHFOKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:10:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39302 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbeHFOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:10:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w76Bx4ai104416;
        Mon, 6 Aug 2018 12:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=BY16AYDEMF35iWPQ4qSOzxnusS53aZYFVYIxx7cqx9U=;
 b=2vyDTlT2utJUUWJ+zTDIIGrHW8GsMOl8iH07OqciBx02mdUH3C/WjZypkJ4MctO0MZ6a
 3dANl+aI/QOm55Ag/Zr0sT7nRCgDmv1p3Xfwc6RIZPZxG5NYnIM/zorSRvpwJg8RU7q9
 iHwaFY+8UUKYTnDTm/enCB8lCLQeY5jxm6dkcglpLa//imHTZVkvhH6usFswx49Q/v7t
 Oa1ec1/S8G1eF/USm+KWIVBkkos7EPqI4twc+h4kWkG4BBEXkYVDht+W3cqPtlV6Ld8B
 EOX4zmfazz1K2yq8AR7/gGvFl5zYBpN/wC/SaOGs5BLi5vTr7FDE97h6seMLpEDx/ZZA Sw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kn4spmf4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Aug 2018 12:01:48 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w76C1l6M007923
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Aug 2018 12:01:47 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w76C1kUK003092;
        Mon, 6 Aug 2018 12:01:46 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Aug 2018 05:01:45 -0700
Date:   Mon, 6 Aug 2018 15:01:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Jheng-Jhong Wu <goodwater.wu@gmail.com>,
        Palle Christensen <palle.christensen@microsemi.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arun Nagendran <arunrasppi@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] staging:mt29f_spinand: MT29F2G failing as only 16-bit
 arguments and variables used for addressing.
Message-ID: <20180806120137.s2lenmmhynw3zndz@mwanda>
References: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
 <20180801120551.ju6zhxhoef6w5zim@mwanda>
 <20180806134648.2976de9e@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806134648.2976de9e@bbrezillon>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8976 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808060130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:46:48PM +0200, Boris Brezillon wrote:
> Hi Dan,
> 
> On Wed, 1 Aug 2018 15:05:51 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > On Wed, Aug 01, 2018 at 11:24:19AM +0800, Jheng-Jhong Wu wrote:
> > > For NAND flash chips with more than 1Gbit (e.g. MT29F2G) more than 16 bits
> > > are necessary to address the correct page. The driver sets the address for
> > > more than 16 bits, but it uses 16-bit arguments and variables (these are
> > > page_id, block_id, row) to do address operations. Obviously, these
> > > arguments and variables cannot deal with more than 16-bit address.
> > > 
> > > Signed-off-by: Jheng-Jhong Wu <goodwater.wu@gmail.com>  
> > 
> > This seems reasonable...  It would be needed to make commit 6efb21d6d0e7
> > ("staging:mt29f_spinand: MT29F2G failing as only 16 bits used for
> > addressing.") work.  It also fixes a static checker warning.
> > 
> > My only concern is that the mtd/nand code seems to use -1 as a magical
> > page_id.  For example:
> 
> Yes, -1 means "don't issue the row/page address cycles", though I
> don't think page can be -1 for NAND_CMD_READ{1,0} commands.
> 

It sure looks like it can be in nand_exit_status_op()...

> Anyway, if you want this patch merged to fix a static checker warning,
> I'm fine with that. In any case, I still plan to send a patch removing
> this driver for v4.20, so, anyone using this driver should start
> testing the new SPI NAND driver (drivers/mtd/nand/spi) and tweak/fix
> the new implementation if needed.

I don't think we should make the code more complicated than necessary
just to make static checkers happy.  When you say "this driver", you
mean the staging driver?  In that case, there is no need to revert
commit 6efb21d6d0e7 ("staging:mt29f_spinand: MT29F2G failing as only 16
bits used for addressing.").

regards,
dan carpenter

