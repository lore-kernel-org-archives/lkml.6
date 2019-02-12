Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E115D20811
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K8L1rSpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfBLCjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:39:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56502 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfBLCjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:39:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1C2YOmK037020;
        Tue, 12 Feb 2019 02:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=O/QX/FWn39V0uFALG2Z67rFs8z8//8DxM3sY6IGq6S0=;
 b=K8L1rSpeXRxDKVnaoJkMwbp7BHbh75nLa/9MGsWyHyTHGzPejOqu7jXzwqFflUbEScku
 2rYCXN/KEvdAsibQReRg02IZ5twnORZH1XytvHQUsFHxkc5M1MjdzF/9/3Kryt8x8jS6
 nV+aL9ov1ItqWJyfH148ubCJG3RjxGj9A6DPCsdPXOZnPMN89RtgM7uoPxfE04IgRlFm
 FwVxqyNIQLybyMUEkrRQ7RXzrCwhknxvorJ+rjscC/1YghZRbwBxnJ3PRXN5r6n2cqIh
 /vDO4v8+utWqYiT3AZmUDZMZviQ8tYDeeMIEvymcx6JkO3uJy7ik2Yma1JTrb1ARW1jp GQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qhrek9b2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 02:38:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1C2c046023466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 02:38:00 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1C2bw4d021554;
        Tue, 12 Feb 2019 02:37:59 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Feb 2019 18:37:58 -0800
Subject: Re: [PATCH] huegtlbfs: fix page leak during migration of file pages
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20190130211443.16678-1-mike.kravetz@oracle.com>
 <917e7673-051b-e475-8711-ed012cff4c44@oracle.com>
 <20190208023132.GA25778@hori1.linux.bs1.fc.nec.co.jp>
 <07ce373a-d9ea-f3d3-35cc-5bc181901caf@oracle.com>
 <20190208073149.GA14423@hori1.linux.bs1.fc.nec.co.jp>
 <ffe58925-a301-6791-44d5-e3bec7f9ebf3@oracle.com>
 <20190212022428.GA12369@hori1.linux.bs1.fc.nec.co.jp>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <803d2349-8911-0b47-bc5b-4f2c6cc3f928@oracle.com>
Date:   Mon, 11 Feb 2019 18:37:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212022428.GA12369@hori1.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=861 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 6:24 PM, Naoya Horiguchi wrote:
> On Mon, Feb 11, 2019 at 03:06:27PM -0800, Mike Kravetz wrote:
>> While looking at this, I think there is another issue.  When a hugetlb
>> page is migrated, we do not migrate the 'page_huge_active' state of the
>> page.  That should be moved as the page is migrated.  Correct?
> 
> Yes, and I think that putback_active_hugepage(new_hpage) at the last step
> of migration sequence handles the copying of 'page_huge_active' state.
> 

Thanks!  I missed the putback_active_hugepage that takes care of making
the target migration page active.

-- 
Mike Kravetz
