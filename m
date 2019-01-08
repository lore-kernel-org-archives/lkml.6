Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F17220827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5cBHudKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfAHSyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:54:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33648 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfAHSyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:54:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x08InU4c076058;
        Tue, 8 Jan 2019 18:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=r1di9JAuGg6uqIyugtF2TALOZWxQQwZkzRHGqhkhB9E=;
 b=5cBHudKNrG8DG84WHDAwWa7Rdj0916Q6GgH1tOcFvF8Na3gwMcU47tnUZYWxJCWilWTS
 b8b9eKBkY3H7M6LXs3Miv6gl9tPhGEI6x2htEAXCl1u+t5nFQK6FaeT3zNBmWHlyVKpx
 kyWDCvb092iPwFpLlvJ5KTJ1niV9Wo8GwqbtgYJm8oKS2WO4CLjwxd1lmDWdWhqJe/sU
 Bxopk92sZ0Xw2FRZSboiwXhhbbzeyY2tms0qHltQGt9z6e8HN4OXvNjnAsKY6V8yd2Zi
 xtD0yVSPhqNhU/QJbUtUEz3LdMtqMswF6pUrad0UZxuSeMlvvFVWo8+NtRmhhB7rocB5 Cw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ptm0u5dmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 18:54:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x08Is0aB014830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 18:54:01 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x08Is0ZR018538;
        Tue, 8 Jan 2019 18:54:00 GMT
Received: from kadam (/10.175.191.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 10:53:59 -0800
Date:   Tue, 8 Jan 2019 21:53:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, cohuck@redhat.com
Subject: Re: [PATCH] vfio/type1: Fix unmap overflow off-by-one
Message-ID: <20190108185347.GG3253@kadam>
References: <154696559827.32763.11706407320970225120.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154696559827.32763.11706407320970225120.stgit@gimli.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=754
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, sorry about that.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

