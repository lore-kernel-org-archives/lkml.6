Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787D5ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489C12083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489C12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJSXge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbeJSXge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:36:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 049C03084027;
        Fri, 19 Oct 2018 15:29:59 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AACA1A922;
        Fri, 19 Oct 2018 15:29:58 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 9ED0C3B15; Fri, 19 Oct 2018 12:30:00 -0300 (BRT)
Date:   Fri, 19 Oct 2018 12:30:00 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     =?iso-8859-1?Q?S=E9bastien?= Boisvert <sboisvert@gydle.com>
Cc:     Hongxu Jia <hongxu.jia@windriver.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kim.phillips@arm.com, brueckner@linux.ibm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mpe@ellerman.id.au, peterz@infradead.org,
        ravi.bangoria@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        namhyung@kernel.org
Subject: Re: [PATCH V2] perf arm64: Fix generate system call table failed
 with /tmp mounted with noexec
Message-ID: <20181019153000.GC5565@redhat.com>
References: <1c6964d0-a7d2-83ef-16f2-bdf349e3f0af@gydle.com>
 <1539915379-11910-1-git-send-email-hongxu.jia@windriver.com>
 <9da3ccbf-ec36-c676-7472-fe7d642cd7e0@gydle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9da3ccbf-ec36-c676-7472-fe7d642cd7e0@gydle.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 19 Oct 2018 15:29:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 19, 2018 at 11:22:38AM -0400, Sébastien Boisvert escreveu:
> 
> 
> On 2018-10-18 10:16 p.m., Hongxu Jia wrote:
> > When /tmp is mounted with noexec, mksyscalltbl fails.
> > [snip]
> > |perf-1.0/tools/perf/arch/arm64/entry/syscalls//mksyscalltbl:
> > /tmp/create-table-6VGPSt: Permission denied
> > [snip]
> > 
> > Add variable TMPDIR as prefix dir of the temporary file, if it is set,
> > replace default /tmp
> > 
> > Remove extra slash from `syscalls//mksyscalltbl'
> > 
> > Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")
> > 
> > Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> > ---
> >  tools/perf/arch/arm64/Makefile                    | 2 +-
> >  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> > index dbef716..bc2a284 100644
> > --- a/tools/perf/arch/arm64/Makefile
> > +++ b/tools/perf/arch/arm64/Makefile
> > @@ -13,7 +13,7 @@ out    := $(OUTPUT)arch/arm64/include/generated/asm
> >  header := $(out)/syscalls.c
> >  incpath := $(srctree)/tools
> >  sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
> > -sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
> > +sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls
> 
> Should this appear in different patch, since it is unrelated to adding TMPDIR support ?

Exactly.

So, to move forward, just send a new patch specifically for this part,
i.e. the removal of the harmless but unneeded extra slash, the other
part I already took care of.

- Arnaldo
 
> Thanks
> 
> >  systbl := $(sysprf)/mksyscalltbl
> >  
> >  # Create output directory if not already present
> > diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> > index 2dbb8cad..c88fd32 100755
> > --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> > +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> > @@ -23,7 +23,7 @@ create_table_from_c()
> >  {
> >  	local sc nr last_sc
> >  
> > -	create_table_exe=`mktemp /tmp/create-table-XXXXXX`
> > +	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
> >  
> >  	{
> >  
> > 
