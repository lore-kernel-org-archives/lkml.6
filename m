Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418A2C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A4E25AE8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A4E25AE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965627AbeF0QCS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:02:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964786AbeF0QCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:02:16 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RG1EFV081537
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:02:16 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvbcwyewn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:02:15 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 17:02:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 17:02:10 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RG29G216646372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 16:02:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 151D511C06C;
        Wed, 27 Jun 2018 17:02:01 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48BFA11C04A;
        Wed, 27 Jun 2018 17:02:00 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.205.67])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Jun 2018 17:02:00 +0100 (BST)
Date:   Wed, 27 Jun 2018 19:02:07 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mhocko@kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: why do we still need bootmem allocator?
References: <20180625140754.GB29102@dhcp22.suse.cz>
 <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
 <20180627112655.GD4291@rapoport-lnx>
 <CAL_JsqL6dV9+tP9CQ7XoCoaf0wUO6NgHZ2-QNUyQMZx2pny+xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL6dV9+tP9CQ7XoCoaf0wUO6NgHZ2-QNUyQMZx2pny+xA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18062716-0028-0000-0000-000002D5939C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062716-0029-0000-0000-0000238CFC50
Message-Id: <20180627160206.GB19182@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 07:33:55AM -0600, Rob Herring wrote:
> On Wed, Jun 27, 2018 at 5:27 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >
> > Hi,
> >
> > On Mon, Jun 25, 2018 at 10:09:41AM -0600, Rob Herring wrote:
> > > On Mon, Jun 25, 2018 at 8:08 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > Hi,
> > > > I am wondering why do we still keep mm/bootmem.c when most architectures
> > > > already moved to nobootmem. Is there any fundamental reason why others
> > > > cannot or this is just a matter of work?
> > >
> > > Just because no one has done the work. I did a couple of arches
> > > recently (sh, microblaze, and h8300) mainly because I broke them with
> > > some DT changes.
> >
> > I've tried running the current upstream on h8300 gdb simulator and it
> > failed:
> 
> It seems my patch[1] is still not applied. The maintainer said he applied it.

I've applied it manually. Without it unflatten_and_copy_device_tree() fails
to allocate memory. It indeed can be fixed with moving bootmem_init()
before, as you've noted in the commit message.

I'll try to dig deeper into it.
 
> > [    0.000000] BUG: Bad page state in process swapper  pfn:00004
> > [    0.000000] page:007ed080 count:0 mapcount:-128 mapping:00000000
> > index:0x0
> > [    0.000000] flags: 0x0()
> > [    0.000000] raw: 00000000 0040bdac 0040bdac 00000000 00000000 00000002
> > ffffff7f 00000000
> > [    0.000000] page dumped because: nonzero mapcount
> > ---Type <return> to continue, or q <return> to quit---
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc2+ #50
> > [    0.000000] Stack from 00401f2c:
> > [    0.000000]   00401f2c 001116cb 007ed080 00401f40 000e20e6 00401f54
> > 0004df14 00000000
> > [    0.000000]   007ed080 007ed000 00401f5c 0004df8c 00401f90 0004e982
> > 00000044 00401fd1
> > [    0.000000]   007ed000 007ed000 00000000 00000004 00000008 00000000
> > 00000003 00000011
> > [    0.000000]
> > [    0.000000] Call Trace:
> > [    0.000000]         [<000e20e6>] [<0004df14>] [<0004df8c>] [<0004e982>]
> > [    0.000000]         [<00051a28>] [<00001000>] [<00000100>]
> > [    0.000000] Disabling lock debugging due to kernel taint
> >
> > With v4.13 I was able to get to "no valid init found".
> >
> > I had a quick look at h8300 memory initialization and it seems it has
> > starting pfn set to 0 while fdt defines memory start at 4M.
> 
> Perhaps there's another issue.
> 
> Rob
> 
> [1] https://patchwork.kernel.org/patch/10290317/
> 

-- 
Sincerely yours,
Mike.

