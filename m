Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B200C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FC92089F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FC92089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeKOMNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:13:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726579AbeKOMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:13:37 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAF1wj90005800
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:07:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nrvaq75q3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:07:46 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 15 Nov 2018 02:07:44 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Nov 2018 02:07:38 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAF27bul52035662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Nov 2018 02:07:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A1DA11C050;
        Thu, 15 Nov 2018 02:07:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0720A11C04C;
        Thu, 15 Nov 2018 02:07:30 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.206])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 15 Nov 2018 02:07:29 +0000 (GMT)
Date:   Wed, 14 Nov 2018 18:07:26 -0800
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Hansen <chansen3@cisco.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Miles Chen <miles.chen@mediatek.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH RFC 2/6] mm: convert PG_balloon to PG_offline
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-3-david@redhat.com>
 <20181114222321.GB1784@bombadil.infradead.org>
 <b4668081-5aa3-d7f5-6880-d01c75cfc6ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4668081-5aa3-d7f5-6880-d01c75cfc6ae@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18111502-0020-0000-0000-000002E832C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111502-0021-0000-0000-000021374AA3
Message-Id: <20181115020725.GC2353@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_20:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:49:15PM +0100, David Hildenbrand wrote:
> On 14.11.18 23:23, Matthew Wilcox wrote:
> > On Wed, Nov 14, 2018 at 10:17:00PM +0100, David Hildenbrand wrote:
> >> Rename PG_balloon to PG_offline. This is an indicator that the page is
> >> logically offline, the content stale and that it should not be touched
> >> (e.g. a hypervisor would have to allocate backing storage in order for the
> >> guest to dump an unused page).  We can then e.g. exclude such pages from
> >> dumps.
> >>
> >> In following patches, we will make use of this bit also in other balloon
> >> drivers.  While at it, document PGTABLE.
> > 
> > Thank you for documenting PGTABLE.  I didn't realise I also had this
> > document to update when I added PGTABLE.
> 
> Thank you for looking into this :)
> 
> > 
> >> +++ b/Documentation/admin-guide/mm/pagemap.rst
> >> @@ -78,6 +78,8 @@ number of times a page is mapped.
> >>      23. BALLOON
> >>      24. ZERO_PAGE
> >>      25. IDLE
> >> +    26. PGTABLE
> >> +    27. OFFLINE
> > 
> > So the offline *user* bit is new ... even though the *kernel* bit
> > just renames the balloon bit.  I'm not sure how I feel about this.
> > I'm going to think about it some more.  Could you share your decision
> > process with us?
> 
> BALLOON was/is documented as
> 
> "23 - BALLOON
>     balloon compaction page
> "
> 
> and only includes all virtio-ballon pages after the non-lru migration
> feature has been implemented for ballooned pages. Since then, this flag
> does basically no longer stands for what it actually was supposed to do.

Perhaps I missing something, but how the user should interpret "23" when he
reads /proc/kpageflags?

> To not break uapi I decided to not rename it but instead to add a new flag.

I've got a feeling that uapi was anyway changed for the BALLON flag
meaning.
 
> > 
> > I have no objection to renaming the balloon bit inside the kernel; I
> > think that's a wise idea.  I'm just not sure whether we should rename
> > the user balloon bit rather than adding a new bit.
> > 
> 
> Can we rename without breaking uapi?
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

