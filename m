Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB779C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D3026431
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D3026431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933913AbeF0L1G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:27:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932884AbeF0L1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:27:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RBJL9e115370
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:27:04 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jv7g1nnkg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:27:04 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 12:27:03 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 12:26:59 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RBQwV528049444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 11:26:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C80CD52065;
        Wed, 27 Jun 2018 12:26:50 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.118])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3533D5204F;
        Wed, 27 Jun 2018 12:26:50 +0100 (BST)
Date:   Wed, 27 Jun 2018 14:26:56 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mhocko@kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: why do we still need bootmem allocator?
References: <20180625140754.GB29102@dhcp22.suse.cz>
 <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18062711-0028-0000-0000-000002D57943
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062711-0029-0000-0000-0000238CE123
Message-Id: <20180627112655.GD4291@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 25, 2018 at 10:09:41AM -0600, Rob Herring wrote:
> On Mon, Jun 25, 2018 at 8:08 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > Hi,
> > I am wondering why do we still keep mm/bootmem.c when most architectures
> > already moved to nobootmem. Is there any fundamental reason why others
> > cannot or this is just a matter of work?
> 
> Just because no one has done the work. I did a couple of arches
> recently (sh, microblaze, and h8300) mainly because I broke them with
> some DT changes.

I've tried running the current upstream on h8300 gdb simulator and it
failed:

[    0.000000] BUG: Bad page state in process swapper  pfn:00004
[    0.000000] page:007ed080 count:0 mapcount:-128 mapping:00000000
index:0x0
[    0.000000] flags: 0x0()
[    0.000000] raw: 00000000 0040bdac 0040bdac 00000000 00000000 00000002
ffffff7f 00000000
[    0.000000] page dumped because: nonzero mapcount
---Type <return> to continue, or q <return> to quit---
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc2+ #50
[    0.000000] Stack from 00401f2c:
[    0.000000]   00401f2c 001116cb 007ed080 00401f40 000e20e6 00401f54
0004df14 00000000
[    0.000000]   007ed080 007ed000 00401f5c 0004df8c 00401f90 0004e982
00000044 00401fd1
[    0.000000]   007ed000 007ed000 00000000 00000004 00000008 00000000
00000003 00000011
[    0.000000] 
[    0.000000] Call Trace:
[    0.000000]         [<000e20e6>] [<0004df14>] [<0004df8c>] [<0004e982>]
[    0.000000]         [<00051a28>] [<00001000>] [<00000100>]
[    0.000000] Disabling lock debugging due to kernel taint

With v4.13 I was able to get to "no valid init found".

I had a quick look at h8300 memory initialization and it seems it has
starting pfn set to 0 while fdt defines memory start at 4M.
 
> > Btw. what really needs to be
> > done? Btw. is there any documentation telling us what needs to be done
> > in that regards?
> 
> No. The commits converting the arches are the only documentation. It's
> a bit more complicated for platforms that have NUMA support.
> 
> Rob
> 

-- 
Sincerely yours,
Mike.

