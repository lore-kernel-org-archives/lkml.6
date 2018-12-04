Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD6EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127352082F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W5IAPz5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127352082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeLDPLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:11:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45846 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDPLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:11:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB4F4ivv003202;
        Tue, 4 Dec 2018 15:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=2aarRQK15wjSwi3CjU9H10FDAlFxIePaV+maM8hnSqA=;
 b=W5IAPz5dddprUeiZ9fjWqgyi57qg5lGC60ZxTUmOVvZzV/DTMBWOixHeDHWxyaW8LQwc
 0nLMRJDGAfCMbWB1VRzjebuBo6XMIuTDpeP+isYs9Pwt3u0nEbEqyaCC05PYKFCKX2z2
 rUh09ALmInwXuAokZ2/IPPCZlpt3+ZfeySoCwzu68NaBNdk80CXOq/dL6tUE6lYxaKbn
 D6yukpjW7lwj6Z2xIB/lyk1IvmVlY5HvITiTL+LOhDFLoNQzYR2W5LpIw2qT35h+YJry
 M6yWRZn16QsltTBXfhA5CQ6mm/ie71/2FmM8CvRO9geGa9awbhIfpbr6a5GrZMHc+KCm Eg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2p3hqtw0u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 15:11:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB4FB1Tp012718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 15:11:01 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB4FB1uQ009882;
        Tue, 4 Dec 2018 15:11:01 GMT
Received: from unbuntlaptop (/197.157.0.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 07:11:00 -0800
Date:   Tue, 4 Dec 2018 18:10:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181204151049.GK3073@unbuntlaptop>
References: <20181130163252.e6z33t23j3qud57z@localhost>
 <20181203105506.GA21127@unbuntlaptop>
 <20181204044257.grk3na2wyrx6nssg@localhost>
 <20181204070033.GG3073@unbuntlaptop>
 <20181204145538.dnyqlfspnpqmojop@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204145538.dnyqlfspnpqmojop@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=836
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 06:55:38AM -0800, Richard Cochran wrote:
> On Tue, Dec 04, 2018 at 10:00:33AM +0300, Dan Carpenter wrote:
> > 
> > Why did you commit 3b1ad360acad ("pps: using ERR_PTR instead of NULL
> > while pps_register_source fails")?  You're not listed as a maintainer so
> > I wouldn't have known to CC you.
> 
> I'm confused.  Where is that commit?
> 
>    $ git show 3b1ad360acad
>    fatal: ambiguous argument '3b1ad360acad': unknown revision or path not in the working tree.
> 
> I'm pulling from:
> 
>    torvalds git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (fetch)
>    stable   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git (fetch)
> 
> (and also from net and net-next)
> 

I'm on linux-next but originally it came from the char-misc-next tree.

git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-next

regards,
dan carpenter

