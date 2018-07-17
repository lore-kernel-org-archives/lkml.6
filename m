Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC72ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A87F20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pJ6Zz2w/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A87F20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeGQKkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:40:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeGQKkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:40:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HA3x0Z046511;
        Tue, 17 Jul 2018 10:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=sUnChzybz80kh3MiedPl9Vq6KvkZc/rxL18U+C0jH+Y=;
 b=pJ6Zz2w/GS1W8C1akyOnsDwUo3ZF0qrAStVvkBNQ6V+tIHqst+FFtzBkuhSDAjdCBPcK
 e5R/dyikMy3KZQOTu2dW8wkiakqryukxRVZeEg19PHC+wBYhK/YPakWIsq2wjss5lfij
 jpUfEyvM4kbHw6fSma3vUPz+M7ypFNHithhtCIklCZ6fflDgY6ICi359VVirhXMGJJQ5
 DSs2IwS/aiNsVhJsTkh9JuPGC7pZU7zWpCmxs39fNU1ySdWGSiWa/7ntH4aUJrB0FlGM
 NdGOqoc8SFg7kXNlTcK6iHqulSJNvopW7cpw5oaU/H1sWK7lzdOPHIKaW2yo4OrvHBOn Pw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k7a3jr0sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:08:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6HA8J7G030124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:08:20 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6HA8Id3024479;
        Tue, 17 Jul 2018 10:08:18 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 03:08:18 -0700
Date:   Tue, 17 Jul 2018 13:08:09 +0300
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
Subject: Re: [PATCH 11/32] staging: gasket: gasket_wait_with_reschedule use
 msleep
Message-ID: <20180717100809.yxmto5qqhd3qjkv3@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
 <20180717020926.176408-12-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717020926.176408-12-toddpoynor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=586
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:09:05PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Replace schedule_timeout() call with msleep().
> 

Why does it matter?  I genuinely don't know the rules here.  The commit
message should normally say if there is a user visible effect or if it's
just a clean up or whatever.

regards,
dan carpenter

