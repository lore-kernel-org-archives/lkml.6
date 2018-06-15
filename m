Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 53766C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E2620891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o7MQxgwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E2620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965515AbeFOCHo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:07:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38936 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965440AbeFOCHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:07:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F23uAE037776;
        Fri, 15 Jun 2018 02:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=hFGjZl2zM6CbnYti9FdoE6OUqvBJMuwG6kXhNGMMuzE=;
 b=o7MQxgwWRDziM3NlXlheDdCfavAWLR0Kyh9edoQBdkSZ4JgLX/HD5Opt7T2ZTWUTBEi4
 lnGIGa6Mqzjer5yYf4d7oAeuQksqmT+la/3p2e1M7x0BXnm1xbB6L3M1+7TspDOdJVmq
 XxeuQE8yXxRd4RbsL7sLh1K2Lbe/Ak+EEhX5t+fE/93U2/g0ceRiOUU+fr+oVt9R8JZi
 PsauEZgG5XZtrUddB6T6BwjrOQlWCWxtIRa17Wg7BfszJzvohDQguA/wHGqLZtZt4a9C
 ayenSa92SR688dwq0tebF29UNHPKKIGrdSxRSLoKTA4K5kGpB84p1MzZjlQF1ebskHmB 5w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jk0xrq7va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 02:07:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5F272VF000788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 02:07:03 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5F271IB022906;
        Fri, 15 Jun 2018 02:07:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 19:07:01 -0700
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] Use sbitmap instead of percpu_ida
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180612190545.10781-1-willy@infradead.org>
Date:   Thu, 14 Jun 2018 22:06:58 -0400
In-Reply-To: <20180612190545.10781-1-willy@infradead.org> (Matthew Wilcox's
        message of "Tue, 12 Jun 2018 12:05:42 -0700")
Message-ID: <yq136xols59.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=88 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=88 mlxscore=88 mlxlogscore=-84
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew,

> Removing the percpu_ida code nets over 400 lines of removal.  It's not
> as spectacular as deleting an entire architecture, but it's still a
> worthy reduction in lines of code.

Since most of the changes are in scsi or target, should I take this
series through my tree?

-- 
Martin K. Petersen	Oracle Linux Engineering
