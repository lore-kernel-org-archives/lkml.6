Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05022C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C802192D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ukH5mJMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbeLUS2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:28:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46602 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeLUS2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:28:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBLI9Ead050326;
        Fri, 21 Dec 2018 18:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=sNiyogGpZ67HvTtdf0GrSszYyzx3ZUWo0isXTeIAN0E=;
 b=ukH5mJMVaQWlRI+CdPeEMXtCLP7G9xbW99xYY9AcJx8NLUjQ7hovn2HfmLksqK9fK6gT
 9/v/bDHFJ3KXinOgnd4yGcNpDPuu937i2DUuLMAr5lo6fug6FuOqv5I609Q0jZGKxzQ5
 +NybQ0FbhQDJX3LVh8fu23AZcE3GbE4juzUR/i2bV5WBsB8fkoKK2y2URezPnM2dHotg
 Z5YBrtvwuDCfO1PIqDDi+ZYdyTSsRsXnvP73Rvuc0b00Vz6oJC420Iv13zad1BK3VKwq
 9m0vdNwpgiKT4gQrASaBILBbIbtjT/cHdn96m1aQYTi8eZme0N+dqvcsjFCYGLdMgl+M EA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pfn204pu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 18:28:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBLISSNO009879
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 18:28:28 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBLISRhg021234;
        Fri, 21 Dec 2018 18:28:27 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Dec 2018 10:28:27 -0800
Subject: Re: [PATCH v2 2/2] hugetlbfs: Use i_mmap_rwsem to fix page
 fault/truncate race
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20181218223557.5202-1-mike.kravetz@oracle.com>
 <20181218223557.5202-3-mike.kravetz@oracle.com>
 <20181221102824.5v36l6l5t2zthpgr@kshutemo-mobl1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <849f5202-2200-265f-7769-8363053e8373@oracle.com>
Date:   Fri, 21 Dec 2018 10:28:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181221102824.5v36l6l5t2zthpgr@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9114 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=444
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812210138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 2:28 AM, Kirill A. Shutemov wrote:
> On Tue, Dec 18, 2018 at 02:35:57PM -0800, Mike Kravetz wrote:
>> Instead of writing the required complicated code for this rare
>> occurrence, just eliminate the race.  i_mmap_rwsem is now held in read
>> mode for the duration of page fault processing.  Hold i_mmap_rwsem
>> longer in truncation and hold punch code to cover the call to
>> remove_inode_hugepages.
> 
> One of remove_inode_hugepages() callers is noticeably missing --
> hugetlbfs_evict_inode(). Why?
> 
> It at least deserves a comment on why the lock rule doesn't apply to it.

In the case of hugetlbfs_evict_inode, the vfs layer guarantees there are
no more users of the inode/file.  Therefore, it is safe to call without
holding the mutex.  But, I did add this comment to remove_inode_hugepages.

* Callers of this routine must hold the i_mmap_rwsem in write mode to prevent
* races with page faults.

So, I violated the rule that I documented.  Thanks for catching.

I will update the comments to note this excpetion to the rule.  Another
option is to simply take the semaphore and still note why it is technically
not needed.  Since there are no users there will be no contention of the
semaphore and the overhead should be negligible.
-- 
Mike Kravetz
