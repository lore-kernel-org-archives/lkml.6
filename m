Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D1FC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7AD2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7AD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeLHRMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:12:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726159AbeLHRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:12:02 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB8H3tDs100924
        for <linux-kernel@vger.kernel.org>; Sat, 8 Dec 2018 12:12:00 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p87sst1ek-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 12:12:00 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sat, 8 Dec 2018 17:11:59 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Dec 2018 17:11:55 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB8HBsRM45678824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Dec 2018 17:11:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDD4EA4040;
        Sat,  8 Dec 2018 17:11:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2935A404D;
        Sat,  8 Dec 2018 17:11:53 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.137])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  8 Dec 2018 17:11:53 +0000 (GMT)
Date:   Sat, 8 Dec 2018 19:11:50 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Sam Creasey <sammy@sammy.net>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] m68k: Fix memblock-related crashes
References: <20181207165011.31497-1-geert@linux-m68k.org>
 <20181207210224.GA19067@rapoport-lnx>
 <CAMuHMdVHDn5=3SBvmHSHsY5rCZKgRXRbk258RAKJp8V8__Hi8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVHDn5=3SBvmHSHsY5rCZKgRXRbk258RAKJp8V8__Hi8w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120817-0008-0000-0000-0000029EBBFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120817-0009-0000-0000-000022092B62
Message-Id: <20181208171143.GB19067@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812080160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 11:51:38AM +0100, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Fri, Dec 7, 2018 at 10:02 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > On Fri, Dec 07, 2018 at 05:50:11PM +0100, Geert Uytterhoeven wrote:
> > > Sun-3 must be broken before this fix, as it fills in m68k_memory[0] in
> > > config_sun3(), i.e. after m68k_parse_bootinfo().
> > > Sun-3 is not fixed by this fix, as it uses its own paging_init(), not
> > > the one in motorola.c.
> > > Fixing Sun-3 requires adding memblock_add()/memblock_reserve() calls to
> > > the Sun-3 memory management code.
> >
> > I think that adding memblock_add() to config_sun3 would be sufficient,
> > something like the diff below. This will make memblock aware of the
> > available physical memory and it seems there no allocations in sun3 before
> > paging_init().
> >
> > diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
> > index 542c440..9a5b9dd 100644
> > --- a/arch/m68k/sun3/config.c
> > +++ b/arch/m68k/sun3/config.c
> > @@ -150,6 +150,7 @@ void __init config_sun3(void)
> >
> >         m68k_num_memory=1;
> >          m68k_memory[0].size=*(romvec->pv_sun3mem);
> > +       memblock_add(memory_start, memory_end - memory_start);
> >
> >         sun3_bootmem_alloc(memory_start, memory_end);
> >  }
> 
> Thanks!
> 
> It doesn't need a memblock_reserve() for the kernel, as memory_start is
> already adjusted for that, right?

Yes, unless I've missed something.
 
> Anyone who can test this is on Sun-3? Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

-- 
Sincerely yours,
Mike.

