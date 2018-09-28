Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF0C004D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F6020684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F6020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeI1PAP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:00:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728820AbeI1PAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:00:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8S8Y4ua109366
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 04:37:35 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2msfksua0n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 04:37:34 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 28 Sep 2018 09:37:32 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Sep 2018 09:37:29 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8S8bSiM64815264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Sep 2018 08:37:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DE2DA4040;
        Fri, 28 Sep 2018 11:37:08 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CADCA4055;
        Fri, 28 Sep 2018 11:37:08 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.97.62])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Sep 2018 11:37:08 +0100 (BST)
Date:   Fri, 28 Sep 2018 10:37:26 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
        <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
        <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 18092808-0008-0000-0000-00000278299F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092808-0009-0000-0000-000021E1358C
Message-Id: <20180928103726.07761672@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 09:12:10 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Thomas,
> 
> On Fri, Sep 28, 2018 at 8:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 27 Sep 2018, Andy Lutomirski wrote:  
> > > I have a couple questions here:
> > >
> > >  - Is this actually okay on all architectures?  That is, are there
> > >    cases where we'll screw up if we fail a USER_DS access this early?
> > >    s390 stands out as the obvious special case (where USER_DS is not
> > >    than just a subset of KERNEL_DS), but s390 opts out.
> > >
> > >  - Why doesn't x86 set HAVE_FUTEX_CMPXCHG?  Or do we still support
> > >    some 32-bit configurations that don't have cmpxchg and don't know
> > >    about it at compile time?  
> >
> > I'm not entirely sure. Have to dig into the details. I assume S390 just can
> > set it though.  
> 
> Not sure. My "[PATCH] futex: Switch to USER_DS for futex test"
> (https://www.spinics.net/lists/stable/msg28846.html), which is
> basically the same
> as this patch, broke s390, so it was never merged.
> 
> See "[BUG -next] "futex: switch to USER_DS for futex test" breaks s390"
> (https://www.spinics.net/lists/linux-next/msg27902.html)
> 
> Heiko said:
> | Martin and I discussed this today and we will change the s390 code so that
> | it will also survive very early USER_DS accesses (without valid current->mm)
> | since we also discovered a couple of other oddities in our code.
> 
> I don't know if that has happened, and whether it would work on s390 now.

commit 03b8c7b623c80af264c4c8d6111e5c6289933666
Author: Heiko Carstens <heiko.carstens@de.ibm.com>
Date:   Sun Mar 2 13:09:47 2014 +0100

    futex: Allow architectures to skip futex_atomic_cmpxchg_inatomic() test
    
    If an architecture has futex_atomic_cmpxchg_inatomic() implemented and there
    is no runtime check necessary, allow to skip the test within futex_init().
    
    This allows to get rid of some code which would always give the same result,
    and also allows the compiler to optimize a couple of if statements away.
    
    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
    Cc: Finn Thain <fthain@telegraphics.com.au>
    Cc: Geert Uytterhoeven <geert@linux-m68k.org>
    Link: http://lkml.kernel.org/r/20140302120947.GA3641@osiris
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


Heiko created the CONFIG_HAVE_FUTEX_CMPXCHG to get around this issue.
We just skip the runtime check as well as arc, m68k and sh. Not sure
about xtensa, the set it config option only for !MMU.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

