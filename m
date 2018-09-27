Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30AAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6C21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA6C21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeI0LHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:07:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbeI0LHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:07:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8R4nLaQ055856
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:50:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mrpysua8d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:50:42 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 27 Sep 2018 05:50:38 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 05:50:27 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8R4oQJu65470530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 04:50:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E5984C040;
        Thu, 27 Sep 2018 07:50:10 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15E3A4C059;
        Thu, 27 Sep 2018 07:50:06 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.204.81])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Sep 2018 07:50:05 +0100 (BST)
Date:   Thu, 27 Sep 2018 07:50:20 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, chris@zankel.net,
        David Miller <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>, green.hu@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>, gxt@pku.edu.cn,
        Ingo Molnar <mingo@redhat.com>, jejb@parisc-linux.org,
        jonas@southpole.se, Jonathan Corbet <corbet@lwn.net>,
        lftan@altera.com, msalter@redhat.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        mattst88@gmail.com, mpe@ellerman.id.au,
        Michal Hocko <mhocko@suse.com>, monstr@monstr.eu,
        palmer@sifive.com, paul.burton@mips.com, rkuo@codeaurora.org,
        richard@nod.at, dalias@libc.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        fancer.lancer@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, vgupta@synopsys.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
Subject: Re: [PATCH 03/30] mm: remove CONFIG_HAVE_MEMBLOCK
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAKgT0UdP=78RsWHMxFu4PD8a3AhA3eNcG68Z_9aGY0vhOKf7xA@mail.gmail.com>
 <20180926183152.GA4597@rapoport-lnx>
 <CAKgT0UcC-GTtyPK9ynvj6r3YFqy8kE40iMJxzPowbNoXGf9iWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcC-GTtyPK9ynvj6r3YFqy8kE40iMJxzPowbNoXGf9iWg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092704-0012-0000-0000-000002AF2296
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092704-0013-0000-0000-000020E33E60
Message-Id: <20180927045019.GA16740@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:34:32PM -0700, Alexander Duyck wrote:
> On Wed, Sep 26, 2018 at 11:32 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >
> > On Wed, Sep 26, 2018 at 09:58:41AM -0700, Alexander Duyck wrote:
> > > On Fri, Sep 14, 2018 at 5:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > > >
> > > > All architecures use memblock for early memory management. There is no need
> > > > for the CONFIG_HAVE_MEMBLOCK configuration option.
> > > >
> > > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > >
> > > <snip>
> > >
> > > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > > index 5169205..4ae91fc 100644
> > > > --- a/include/linux/memblock.h
> > > > +++ b/include/linux/memblock.h
> > > > @@ -2,7 +2,6 @@
> > > >  #define _LINUX_MEMBLOCK_H
> > > >  #ifdef __KERNEL__
> > > >
> > > > -#ifdef CONFIG_HAVE_MEMBLOCK
> > > >  /*
> > > >   * Logical memory blocks.
> > > >   *
> > > > @@ -460,7 +459,6 @@ static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
> > > >  {
> > > >         return 0;
> > > >  }
> > > > -#endif /* CONFIG_HAVE_MEMBLOCK */
> > > >
> > > >  #endif /* __KERNEL__ */
> > >
> > > There was an #else above this section and I believe it and the code
> > > after it needs to be stripped as well.
> >
> > Right, I've already sent the fix [1] and it's in mmots.
> >
> > [1] https://lkml.org/lkml/2018/9/19/416
> >
> 
> Are you sure? The patch you reference appears to be for
> drivers/of/fdt.c, and the bit I pointed out here is in
> include/linux/memblock.h.

Ah, sorry. You are right, will fix. Thanks for spotting it!
 
> - Alex
> 

-- 
Sincerely yours,
Mike.

