Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88939C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E94820859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wpSqLqV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfBTXG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:06:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54030 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTXG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:06:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KN4MnG032340;
        Wed, 20 Feb 2019 23:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=XhTrjB4aur+YZVGJ3nVLns1sUOWJt7RR9HqnQuBC4VA=;
 b=wpSqLqV2pEPG5TUB3USVf4diH3TLpsW0djWbXMjyf32YtuqWan4K3sr15lBRa73Zlt9Y
 VfEjRwynqH0bViFZ/Q3kd9f2U+WaeuBgyeuKC4vTRZ/AV4t7x5LM+PzV5LVwJnb/Muwk
 otEQV4eqy5w8+sqfPxXJO2ZuUQKLtiLuO+Hf0ZLrkjQxa8UIrdft1IHcQASgZJcqZsv5
 xcruyyr3ypSnbkUigAtSMqGKDSESDc02dtRZfRwpyoG5ilutwwmV0qA3oIa7oGkaTjby
 foHuyiDLwH8zrqGqwKz7Bs8rAdt3fXkla1p9rpdQrxLPiPlKaxeY+0eiMwQpEPW7HXbf jg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xu4qna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 23:06:26 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KN6PhZ023820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 23:06:25 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KN6P90000812;
        Wed, 20 Feb 2019 23:06:25 GMT
Received: from ubuette (/75.80.107.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 15:06:24 -0800
Date:   Wed, 20 Feb 2019 15:06:22 -0800
From:   Larry Bassel <larry.bassel@oracle.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org
Subject: question about page tables in DAX/FS/PMEM case
Message-ID: <20190220230622.GI19341@ubuette>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1031
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=790 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on sharing page tables in the DAX/XFS/PMEM/PMD case.

If multiple processes would use the identical page of PMDs corresponding
to a 1 GiB address range of DAX/XFS/PMEM/PMDs, presumably one can instead
of populating a new PUD, just atomically increment a refcount and point
to the same PUD in the next level above.

i.e.

OLD:
process 1:
VA -> levels of page tables -> PUD1 -> page of PMDs1
process 2:
VA -> levels of page tables -> PUD2 -> page of PMDs2

NEW:
process 1:
VA -> levels of page tables -> PUD1 -> page of PMDs1
process 2:
VA -> levels of page tables -> PUD1 -> page of PMDs1 (refcount 2)

There are several cases to consider:

1. New mapping
OLD:
make a new PUD, populate the associated page of PMDs
(at least partially) with PMD entries.
NEW:
same

2. Mapping by a process same (same VA->PA and size and protections, etc.)
as one that already exists
OLD:
make a new PUD, populate the associated page of PMDs
(at least partially) with PMD entries.
NEW:
use same PUD, increase refcount (potentially even if this mapping is private
in which case there may eventually be a copy-on-write -- see #5 below)

3. Unmapping of a mapping which is the same as that from another process
OLD:
destroy the process's copy of mapping, free PUD, etc.
NEW:
decrease refcount, only if now 0 do we destroy mapping, etc.

4. Unmapping of a mapping which is unique (refcount 1)
OLD:
destroy the process's copy of mapping, free PUD, etc.
NEW:
same

5. Mapping was private (but same as another process), process writes
OLD:
break the PMD into PTEs, destroy PMD mapping, free PUD, etc..
NEW:
decrease refcount, only if now 0 do we destroy mapping, etc.
we still break the PMD into PTEs.

If I have a mmap of a DAX/FS/PMEM file and I take
a page (either pte or PMD sized) fault on access to this file,
the page table(s) are set up in dax_iomap_fault() in fs/dax.c (correct?).

If the process later munmaps this file or exits but there are still
other users of the shared page of PMDs, I would need to
detect that this has happened and act accordingly (#3 above)

Where will these page table entries be torn down?
In the same code where any other page table is torn down?
If this is the case, what would the cleanest way of telling that these
page tables (PMDs, etc.) correspond to a DAX/FS/PMEM mapping
(look at the physical address pointed to?) so that
I could do the right thing here.

I understand that I may have missed something obvious here.

Thanks.

Larry
