Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D307C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C252075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C252075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeIFR5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:57:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728724AbeIFR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:57:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86DENMs014791
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 09:21:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mb4sugt3g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:21:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 14:21:35 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 14:21:30 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86DLTPC37355706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 13:21:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E290A4055;
        Thu,  6 Sep 2018 16:21:21 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65CC0A4051;
        Thu,  6 Sep 2018 16:21:20 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Sep 2018 16:21:20 +0100 (BST)
Date:   Thu, 6 Sep 2018 16:21:26 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/29] mm: remove bootmem allocator
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180906091538.GN14951@dhcp22.suse.cz>
 <46ae5e64-7b1a-afab-bfef-d00183a7ef76@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ae5e64-7b1a-afab-bfef-d00183a7ef76@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090613-0016-0000-0000-000002014382
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090613-0017-0000-0000-00003257EDDE
Message-Id: <20180906132126.GK27492@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=546 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:04:47PM +0000, Pasha Tatashin wrote:
> 
> 
> On 9/6/18 5:15 AM, Michal Hocko wrote:
> > On Wed 05-09-18 18:59:15, Mike Rapoport wrote:
> > [...]
> >>  325 files changed, 846 insertions(+), 2478 deletions(-)
> >>  delete mode 100644 include/linux/bootmem.h
> >>  delete mode 100644 mm/bootmem.c
> >>  delete mode 100644 mm/nobootmem.c
> > 
> > This is really impressive! Thanks a lot for working on this. I wish we
> > could simplify the memblock API as well. There are just too many public
> > functions with subtly different semantic and barely any useful
> > documentation.
> > 
> > But even this is a great step forward!
> 
> This is a great simplification of boot process. Thank you Mike!
> 
> I agree, with Michal in the future, once nobootmem kernel stabalizes
> after this effort, we should start simplifying memblock allocator API:
> it won't be as big effort as this one, as I think, that can be done in
> incremental phases, but it will help to make early boot much more stable
> and uniform across arches.

It's not only about the memblock APIs. Every arch has its own way of memory
detection and initialization, all this should be revisited at some point.
But yes, apart from the memblock APIs update which will be quite
disruptive, the arches memory initialization can be updated incrementally.
 
> Thank you,
> Pavel

-- 
Sincerely yours,
Mike.

