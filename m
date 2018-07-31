Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A116C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B89320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EDYD6f5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B89320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeGaEpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:45:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57656 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeGaEpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:45:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6V34Hef151811;
        Tue, 31 Jul 2018 03:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DGaku9oeyP9hNRnd/EivIQ9PPqra02fR8H5x/ybSLnI=;
 b=EDYD6f5vzAPwtJf/Ahv+nOTT0h0mUTWEy180vek9xs3CE5sM9c7+nIdZyvoERRE+twSe
 92hMqabdktKr9Q+TYAYtnL0X8MRJ9aQ7YIbqM90RS7a8HioiqlaAvBW0DTs4XHqLUBbv
 YlTxeqc+CHZPdti80kLAVXXseOVBuAhZpPd+Bc+sQa/4YfxmCa17X0F7CNfOjs4/Xacb
 /O/g3wSwtZjOVhoRhYWbsqPjyi1LXKavL32KLsQi5eal534Zdwuuqen8LAf9GJ036mOr
 MCppsphpu3wQRo47gNaBq3YJaBxbrJj7a123k/9bIjKdOYugwz3TuE4duygKkpsc7+yg 6g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kgfwsy1nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 03:06:44 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6V36itV026810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 03:06:44 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6V36fnG010807;
        Tue, 31 Jul 2018 03:06:42 GMT
Received: from [10.154.104.120] (/10.154.104.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 20:06:41 -0700
Subject: Re: [PATCH] ipc/shm.c add ->pagesize function to shm_vm_ops
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, jack@suse.cz, jglisse@redhat.com,
        mike.kravetz@oracle.com, dave@stgolabs.net, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <20180727211727.5020-1-jane.chu@oracle.com>
 <20180728190248.GA883@bombadil.infradead.org>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <026b057d-ec11-9273-40bc-072a8958bb64@oracle.com>
Date:   Mon, 30 Jul 2018 20:06:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180728190248.GA883@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=925
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mathew,


On 7/28/2018 12:02 PM, Matthew Wilcox wrote:
> On Fri, Jul 27, 2018 at 03:17:27PM -0600, Jane Chu wrote:
>> +++ b/include/linux/mm.h
>> @@ -387,6 +387,13 @@ enum page_entry_size {
>>    * These are the virtual MM functions - opening of an area, closing and
>>    * unmapping it (needed to keep files on disk up-to-date etc), pointer
>>    * to the functions called when a no-page or a wp-page exception occurs.
>> + *
>> + * Note, when a new function is introduced to vm_operations_struct and
>> + * added to hugetlb_vm_ops, please consider adding the function to
>> + * shm_vm_ops. This is because under System V memory model, though
>> + * mappings created via shmget/shmat with "huge page" specified are
>> + * backed by hugetlbfs files, their original vm_ops are overwritten with
>> + * shm_vm_ops.
>>    */
>>   struct vm_operations_struct {
> I don't think this header file is the right place for this comment.
> I'd think a better place for it would be at the definition of hugetlb_vm_ops.

Agreed, will make the change.
Thanks for reviewing!

-jane

