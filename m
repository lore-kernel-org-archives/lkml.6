Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67733208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jbSw+7VN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67733208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbeHAQj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:39:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34326 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389528AbeHAQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:39:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w71Eni57178766;
        Wed, 1 Aug 2018 14:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=5bTdUsB1Yukl8KK6U8ravuJd6B78txP7+GEV4RP7a+8=;
 b=jbSw+7VNswuIp5HM6QiFtd0TgBxAhHVEGw3Wo7s7b5gAnenD4UDencXLWSTnXA5wC8Ih
 AhNoyPQqDsK76/o6MdnGc0Yxu/AuBtrOdRMt4RkJEgIUquBwGM3StwS5Jh7lY0Tc2efT
 5r5vuBiKLs9Ebb8u+jrrqwZWeBUb/iwhmCLAPC4DePfLXuOMmGzWW1TUDzfZOJ0JA9Mm
 fJT+0XD6H4F/z3GSiiyZjDQocDtKHr2+m9XsuMy+9U7ESCmR2j3zEUliCbfNcxHXxtEc
 wnAt1cbVqMVXlQoSwqTx23FAOEAAAmkhawgm2vrnSfNwyoLyyEBHMnqOTbpNp5hVa7tN dA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kggep629b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 14:52:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w71EqtZ6009683
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 14:52:56 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w71Eqsbi027229;
        Wed, 1 Aug 2018 14:52:54 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 07:52:53 -0700
Date:   Wed, 1 Aug 2018 17:52:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devel@driverdev.osuosl.org, ldv-project@linuxtesting.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>
Subject: Re: [PATCH v5] staging: rts5208: add error handling into rtsx_probe
Message-ID: <20180801145245.rkuvugnxm4fofauz@mwanda>
References: <CAHp75VfktnjL+G0vjHNHr=8mbDXu+4BDogsnxrp_2Bo4em=r2Q@mail.gmail.com>
 <20180801115557.7086-1-vasilyev@ispras.ru>
 <CAHp75VeSr-dDC+BvvTi1f2JBDL0UB31O=umatKE4y=0HQ4_8UQ@mail.gmail.com>
 <cac7e1d3-dc55-5857-5fe5-4ff5bc39f2d1@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac7e1d3-dc55-5857-5fe5-4ff5bc39f2d1@ispras.ru>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=711
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:08:48PM +0300, Anton Vasilyev wrote:
> I found that staging-next already contains my patch v3, committed by Greg
> Kroah-Hartman.
> 
> Do I need to send a new patch with a label renaming based on Dan Carpenter
> comments?

I had to look to see what I had said earlier...  The naming isn't really
a problem but we should call scsi_host_put(host); if the
"dev->chip = kzalloc(sizeof(*dev->chip), GFP_KERNEL);" allocation fails.

regards,
dan capenter

