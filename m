Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D289C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C56208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KqA/37ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C56208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbeGBTy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:54:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51418 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbeGBTyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:54:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62JsQp7054146;
        Mon, 2 Jul 2018 19:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=Aph7wy/2jJBdEm68+lX0P9wqZYlnzuuxGjOOCwNELi4=;
 b=KqA/37udbmVUbTyfaWS6KfqgaCrXS7okp/cmSx0WmGuxxIfgY30sWcgiuUJxXIut+/LP
 O9Xa8PMVRBGjRsvY9EI1K3C0SpFHznJ8fzEplt6Ot9qFtqpn39dW+aW3712Q07P1x5iL
 z7nPxQNj3JMOPyeceuSOzo/mD9TMtJ6cXT+ttXojBMCpIczHGkHCKjArnXET0NjWqrY7
 EmIOjROV4QsuZKvO3L6DZyp/monIAe95v0zKSeO+ADcXBngp8Hj4Fy1CXkzXRG4F5kS6
 ihyUqf/8TysLPbPJ9CWh9g8crVgdrPJmDIAhEwGmb54Ve4TV3/Za5hJjfniwJFT/ZoLO Mg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jx19snwfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Jul 2018 19:54:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w62JsPbE017832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jul 2018 19:54:25 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w62JsNiB014330;
        Mon, 2 Jul 2018 19:54:23 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 12:54:23 -0700
Subject: Re: [PATCH v3 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
To:     Dave Hansen <dave.hansen@intel.com>, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        jack@suse.cz, jglisse@redhat.com, jrdr.linux@gmail.com,
        bhe@redhat.com, gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-3-pasha.tatashin@oracle.com>
 <552d5a9b-0ca9-cc30-d8c2-33dc1cde917f@intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <b227cf00-a1dd-5371-aafd-9feb332e9d02@oracle.com>
Date:   Mon, 2 Jul 2018 15:54:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <552d5a9b-0ca9-cc30-d8c2-33dc1cde917f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2018 03:47 PM, Dave Hansen wrote:
> On 07/01/2018 07:04 PM, Pavel Tatashin wrote:
>> +	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
>> +		int nid = sparse_early_nid(__nr_to_section(pnum_end));
>>  
>> +		if (nid == nid_begin) {
>> +			map_count++;
>>  			continue;
>>  		}
> 
>> +		sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
>> +		nid_begin = nid;
>> +		pnum_begin = pnum_end;
>> +		map_count = 1;
>>  	}
> 
> Ugh, this is really hard to read.  Especially because the pnum "counter"
> is called "pnum_end".

I called it pnum_end, because that is what is passed to sparse_init_nid(), but I see your point, and I can rename pnum_end to simply pnum if that will make things look better.

> 
> So, this is basically a loop that collects all of the adjacent sections
> in a given single nid and then calls sparse_init_nid().  pnum_end in
> this case is non-inclusive, so the sparse_init_nid() call is actually
> for the *previous* nid that pnum_end is pointing _past_.
> 
> This *really* needs commenting.

There is a comment before sparse_init_nid() about inclusiveness:

434 /*
435  * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
436  * And number of present sections in this node is map_count.
437  */
438 static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
439                                    unsigned long pnum_end,
440                                    unsigned long map_count)


Thank you,
Pavel
