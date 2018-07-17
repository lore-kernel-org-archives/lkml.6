Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36A8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E974208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N2XkIXDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E974208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbeGQLRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:17:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37694 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbeGQLRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:17:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HAdNEF108295;
        Tue, 17 Jul 2018 10:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=N9MEHzoTJVXVcbarjSAmYUJspn1Td86wyt9S4n26rMU=;
 b=N2XkIXDU/KO6KokIyDGNMOmM8a+lsqDwVkKP+b1FA6wltivJkM5C/ToVoPMovq2FoUn4
 WmY5hfqkMVYnHQRgmAk34yz9h0jvXCHsdxex5Ep8QKxluiA/uoYCZZ8YOPwxBF4fBvjd
 ids8DAKC/gkT/32a1SLWxYOUsVQdFt5aT+/Ub+avmBKnznQ/5euzy500WSeWMkvucyA8
 oS045oglpFKb/hYLrkJu7AvwolvpjFcfxWkd/w9XVNwJNWFUPRLUIifdUrRBrlVXiqWh
 d2GHHKU6uBLwjABufocK+9litjxK3A6sIw4OX3ewKQVwEyzeKs1K+vUrhwWqGATR3WuO rQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k7a3403jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:44:54 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6HAirKe014670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:44:53 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6HAiqtL029482;
        Tue, 17 Jul 2018 10:44:52 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 03:44:52 -0700
Date:   Tue, 17 Jul 2018 13:44:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 30/32] staging: gasket: gasket_mmap use PAGE_MASK
Message-ID: <20180717104443.rx4viceiphjrmyut@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
 <20180717020926.176408-31-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717020926.176408-31-toddpoynor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=791
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:09:24PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Instead of math on PAGE_SIZE.
> 

The commit message is sort of distinct from the first line.  The first
line is like a title, not the start of a sentence.  On like marc.info
when you're looking at patches, the Subject and the commit message are
sort of far apart so it looks weird.  It looks weird on my email as
well.

Sorry, we're really hitting you with a bunch of nit-picky stuff.  If you
were a one off contributer I'd just let a lot of this stuff slide but
since you're going to be a maintainer for a while then it's good to
learn all these micro rules at the begining.

regards,
dan carpenter

