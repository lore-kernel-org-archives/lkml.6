Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0286C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92F9222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394969AbfBMVlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:41:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732893AbfBMVla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:41:30 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DLchVs057890
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:41:29 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmtjjhxdh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:41:28 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 13 Feb 2019 21:41:22 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Feb 2019 21:41:19 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1DLfIjG7471430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 21:41:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 564F511C050;
        Wed, 13 Feb 2019 21:41:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4200211C058;
        Wed, 13 Feb 2019 21:41:17 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.163])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Feb 2019 21:41:17 +0000 (GMT)
Date:   Wed, 13 Feb 2019 23:41:15 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] initramfs: proide a generic free_initrd_mem
 implementation
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-8-hch@lst.de>
 <20190213184139.GC15270@rapoport-lnx>
 <20190213184448.GB20399@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213184448.GB20399@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021321-0016-0000-0000-0000025622C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021321-0017-0000-0000-000032B04C09
Message-Id: <20190213214114.GE15270@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:44:48PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 13, 2019 at 08:41:40PM +0200, Mike Rapoport wrote:
> > csky seems to open-code free_reserved_page with the only
> > difference that it's also increments totalram_pages for the freed pages,
> > which doesn't seem correct anyway...
> > 
> > That said, I suppose arch/csky can be also added to the party.
> 
> Yes, I noticed that.  But I'd rather move it over manually in
> another patch post rc1 or for the next merge window.

Fair enough.
 
> > > +void __weak free_initrd_mem(unsigned long start, unsigned long end)
> > > +{
> > > +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> > 
> > Some architectures have pr_info("Freeing initrd memory..."), I'd add it for
> > the generic version as well.
> 
> Well, if we think such a printk is useful it should probably be
> moved to the caller in init/initramfs.c instead.  I can include a
> patch for that in the next iteration of the series.

I found it useful during board bring ups, this gave some starting point
when everything hangs and you are out to catch the lion in the desert.

> > Another thing that I was thinking of is that x86 has all those memory
> > protection calls in its free_initrd_mem, maybe it'd make sense to have them
> > in the generic version as well?
> 
> Maybe.  But I'd rather keep it out of the initial series as it looks
> a little more complicated.  Having a single implementation
> of free_initrd_mem would be great, though.

Ok.

BTW, the memblock_free() arm64 does, seems to be relevant for architectures
with CONFIG_ARCH_DISCARD_MEMBLOCK=n.
On powerpc the freed initrd region shows up in
/sys/kernel/debug/memblock/reserved.

-- 
Sincerely yours,
Mike.

