Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61044ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FE120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HGKXryFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FE120C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbeGQLo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:44:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35700 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbeGQLo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:44:58 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HB8dcs121810;
        Tue, 17 Jul 2018 11:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=nCZgGOKWJOVRQzaoLoBDZJ0T2u3H4n4K18h4Ci15tmE=;
 b=HGKXryFdMCDz/8e/005AHqE6WX757V+8bkLNipDC1p5sMgFtzSWaCQ99BwDiyE7i/+Nf
 zxhHjkr2UzfreEZe2svfV6UOqwcTT/55q7zMYF+i+qnyqdoLAWFcEW8etA3Rh4t+YplA
 vMJgdpbFZHFNj1KE5hRK6d1GZhFULNCD1TKY3cYRNOlwK3ihXRjsqrTDEQwMgQBIlqVT
 ljKCaXrDhqnRGXiEW3s1vKdl7cml4Cfy3nTs6w/9FAZPnUb9JaHjTO5d6c9qZ48E7eJk
 UmXh27QdQAaILwB/dpQMI4S7ROnmshYSb3m/N0vVg1yxAL06ba+aUl6HPWrW4Zqya+ar 3A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2k7a3t07d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 11:12:45 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6HBCivX024322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 11:12:44 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6HBChAc002068;
        Tue, 17 Jul 2018 11:12:43 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 04:12:42 -0700
Date:   Tue, 17 Jul 2018 14:12:33 +0300
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
Subject: Re: [PATCH 12/32] staging: gasket: gasket_wait_with_reschedule
 return when condition hit
Message-ID: <20180717111233.5jsxqfyveibe6b7j@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
 <20180717020926.176408-13-toddpoynor@gmail.com>
 <20180717101329.yl4hwob2jbjlp2uh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717101329.yl4hwob2jbjlp2uh@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=600
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:13:29PM +0300, Dan Carpenter wrote:
> On Mon, Jul 16, 2018 at 07:09:06PM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> > 
> > Return right away instead of break out of while and then return.
> > 
>

Btw, I wasn't going to complain about this but since Greg is being extra
critical about commit messages that don't explain *why* it just creates
an environment why I also feel free to complain...  I couldn't
understand what this commit does without looking at the code in context.

A possible commit message here is:

[PATCH 12/32] staging: gasket: small cleanup in gasket_wait_with_reschedule()

gasket_wait_with_reschedule() is a little more clear if we just return
directly.

regards,
dan carpenter

