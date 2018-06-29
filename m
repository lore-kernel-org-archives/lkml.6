Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA99C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CDF278CB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r3v60Jjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CDF278CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935089AbeF2SBh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:01:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57476 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbeF2SBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:01:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5THx8pO105086;
        Fri, 29 Jun 2018 18:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=fHfs3+y2/+wWHdgODgDEVQX9J+qFhWQxIsHz0R694AU=;
 b=r3v60Jjn5+wRo4wKrVBFDRC9RchkQCmiXtMcmYeCwr/Djxgm3nH64wEZf3YbmSIbB/3Q
 iatzX0XAK4Kbeptw2JHNqV0vbFeqo3iFbWOJrOUF/23621lvocvzIBL1OejrMlBtXNQ0
 wtpxfTDwbNEdoAywUn7PdH79b386EVAqT9AiNKyRAjFqd5srZV78SVnU0voOj5ZqdrJ6
 eq7cT7J3LJEzFQdKhYISJq6tbm37MJVq2HBAzAMX8R/SJTCvIuHdMil1KK67lXpPNesU
 +IqY54SRVqoXWqpgzU85Ax+PFE/ZdwT8PXnSLUiEC31vu1bx/tOeshokprqwPQWQkezR +g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jukmu7jqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 18:01:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5TI1G2W031142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 18:01:16 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5TI1FAP000840;
        Fri, 29 Jun 2018 18:01:15 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 18:01:15 +0000
Subject: Re: [PATCH v5 4/4] mm/sparse: Optimize memmap allocation during
 sparse_init()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     bhe@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
References: <20180627013116.12411-1-bhe@redhat.com>
 <20180627013116.12411-5-bhe@redhat.com>
 <cb67381c-078c-62e6-e4c0-9ecf3de9e84d@intel.com>
 <CAGM2rebsL_fS8XKRvN34NWiFN3Hh63ZOD8jDj8qeSOUPXcZ2fA@mail.gmail.com>
 <88f16247-aea2-f429-600e-4b54555eb736@intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <b8d5b9cb-ca09-4bcc-0a31-3db1232fe787@oracle.com>
Date:   Fri, 29 Jun 2018 14:01:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <88f16247-aea2-f429-600e-4b54555eb736@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=690
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 01:52 PM, Dave Hansen wrote:
> On 06/29/2018 10:48 AM, Pavel Tatashin wrote:
>> Here is example:
>> Node1:
>> map_map[0] -> Struct pages ...
>> map_map[1] -> NULL
>> Node2:
>> map_map[2] -> Struct pages ...
>>
>> We always want to configure section from Node2 with struct pages from
>> Node2. Even, if there are holes in-between. The same with usemap.
> 
> Right...  But your example consumes two mem_map[]s.
> 
> But, from scanning the code, we increment nr_consumed_maps three times.
> Correct?

Correct: it should be incremented on every iteration of the loop. No matter if the entries contained valid data or NULLs. So we increment in three places:

if map_map[] has invalid entry, increment, continue
if usemap_map[] has invalid entry, increment, continue
at the end of the loop, everything was valid we increment it

This is done so nr_consumed_maps does not get out of sync with the current pnum. pnum does not equal to nr_consumed_maps, as there are may be holes in pnums, but there is one-to-one correlation.

Pavel
