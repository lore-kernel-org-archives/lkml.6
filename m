Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A49C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549C82151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549C82151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeI0Aqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:46:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbeI0Aqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:46:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QIUDRB024755
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:32:16 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mreu4hv2r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:32:15 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 19:32:12 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 19:32:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8QIVxwW65994892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 18:31:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 826B4A405D;
        Wed, 26 Sep 2018 21:31:40 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C9ACA4040;
        Wed, 26 Sep 2018 21:31:36 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.204.125])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 26 Sep 2018 21:31:35 +0100 (BST)
Date:   Wed, 26 Sep 2018 21:31:53 +0300
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdP=78RsWHMxFu4PD8a3AhA3eNcG68Z_9aGY0vhOKf7xA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092618-0020-0000-0000-000002CBF8A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092618-0021-0000-0000-0000211A1CA6
Message-Id: <20180926183152.GA4597@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 09:58:41AM -0700, Alexander Duyck wrote:
> On Fri, Sep 14, 2018 at 5:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >
> > All architecures use memblock for early memory management. There is no need
> > for the CONFIG_HAVE_MEMBLOCK configuration option.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> <snip>
> 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 5169205..4ae91fc 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -2,7 +2,6 @@
> >  #define _LINUX_MEMBLOCK_H
> >  #ifdef __KERNEL__
> >
> > -#ifdef CONFIG_HAVE_MEMBLOCK
> >  /*
> >   * Logical memory blocks.
> >   *
> > @@ -460,7 +459,6 @@ static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
> >  {
> >         return 0;
> >  }
> > -#endif /* CONFIG_HAVE_MEMBLOCK */
> >
> >  #endif /* __KERNEL__ */
> 
> There was an #else above this section and I believe it and the code
> after it needs to be stripped as well.

Right, I've already sent the fix [1] and it's in mmots.

[1] https://lkml.org/lkml/2018/9/19/416

-- 
Sincerely yours,
Mike.

