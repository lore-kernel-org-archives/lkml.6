Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C91C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E6D20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E6D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeILTcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:32:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbeILTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:32:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CEOITq139517
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:27:26 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf2ss5mdw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:27:26 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 12 Sep 2018 15:27:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 15:27:19 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CERISk59769082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 14:27:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 970ECAE04D;
        Wed, 12 Sep 2018 17:26:33 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69643AE058;
        Wed, 12 Sep 2018 17:26:33 +0100 (BST)
Received: from thinkpad (unknown [9.152.212.168])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Sep 2018 17:26:33 +0100 (BST)
Date:   Wed, 12 Sep 2018 16:27:17 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com, osalvador@suse.de
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
In-Reply-To: <20180912133933.GI10951@dhcp22.suse.cz>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
        <20180910131754.GG10951@dhcp22.suse.cz>
        <20180912150356.642c1dab@thinkpad>
        <20180912133933.GI10951@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18091214-0028-0000-0000-000002F847ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091214-0029-0000-0000-000023B1E7B8
Message-Id: <20180912162717.5a018bf6@thinkpad>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 15:39:33 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 12-09-18 15:03:56, Gerald Schaefer wrote:
> [...]
> > BTW, those sysfs attributes are world-readable, so anyone can trigger
> > the panic by simply reading them, or just run lsmem (also available for
> > x86 since util-linux 2.32). OK, you need a special not-memory-block-aligned
> > mem= parameter and DEBUG_VM for poison check, but w/o DEBUG_VM you would
> > still access uninitialized struct pages. This sounds very wrong, and I
> > think it really should be fixed.  
> 
> Ohh, absolutely. Nobody is questioning that. The thing is that the
> code has been likely always broken. We just haven't noticed because
> those unitialized parts where zeroed previously. Now that the implicit
> zeroying is gone it is just visible.
> 
> All that I am arguing is that there are many places which assume
> pageblocks to be fully initialized and plugging one place that blows up
> at the time is just whack a mole. We need to address this much earlier.
> E.g. by allowing only full pageblocks when adding a memory range.

Just to make sure we are talking about the same thing: when you say
"pageblocks", do you mean the MAX_ORDER_NR_PAGES / pageblock_nr_pages
unit of pages, or do you mean the memory (hotplug) block unit?

I do not see any issue here with MAX_ORDER_NR_PAGES / pageblock_nr_pages
pageblocks, and if there was such an issue, of course you are right that
this would affect many places. If there was such an issue, I would also
assume that we would see the new page poison warning in many other places.

The bug that Mikhails patch would fix only affects code that operates
on / iterates through memory (hotplug) blocks, and that does not happen
in many places, only in the two functions that his patch fixes.

When you say "address this much earlier", do you mean changing the way
that free_area_init_core()/memmap_init() initialize struct pages, i.e.
have them not use zone->spanned_pages as limit, but rather align that
up to the memory block (not pageblock) boundary?

