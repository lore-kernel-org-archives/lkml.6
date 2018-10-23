Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780E3C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE020651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXfrYkzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEE020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeJXDyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeJXDyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:54:24 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9379720651;
        Tue, 23 Oct 2018 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540322978;
        bh=mR77TuKg8JxROlIV7Cpz/fqWxuvGn5/0pLiGj0/n6dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NXfrYkzB2i4wt3NvOK2hi5pvqWKd+uOVn8MXDSvS1l/yOj2tgydviV06zqFAm9C5m
         6paxSIeNHw8XQsC8JEb48WDLoGLp1FnQqaFZ7zuCLd2j2SEIUgxpYI4D3UUgILMkXL
         jD8n1SKFKWr7gbCMmkd/5a8LxI3xeTnvHKxZ5ZMc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id BC273142C5E; Tue, 23 Oct 2018 16:29:35 -0300 (-03)
Date:   Tue, 23 Oct 2018 16:29:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
 Add All branches report
Message-ID: <20181023192935.GD6114@kernel.org>
References: <20181001062853.28285-18-adrian.hunter@intel.com>
 <20181023075949.18920-1-adrian.hunter@intel.com>
 <20181023181218.GB6114@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C2B8A4D@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C2B8A4D@IRSMSX106.ger.corp.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 23, 2018 at 06:41:17PM +0000, Hunter, Adrian escreveu:
> > -----Original Message-----
> > From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> > Sent: Tuesday, October 23, 2018 9:12 PM
> > To: Hunter, Adrian <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>; Andi Kleen <ak@linux.intel.com>; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
> > Add All branches report
> > 
> > Em Tue, Oct 23, 2018 at 10:59:49AM +0300, Adrian Hunter escreveu:
> > > Add a report to display branches in a similar fashion to perf script.
> > > The main purpose of this report is to display disassembly, however,
> > > presently, the only supported disassembler is Intel XED, and
> > > additionally the object code must be present in perf build ID cache.
> > >
> > > To use Intel XED, libxed.so must be present. To build and install
> > > libxed.so:
> > > 	git clone https://github.com/intelxed/mbuild.git mbuild
> > > 	git clone https://github.com/intelxed/xed
> > > 	cd xed
> > > 	./mfile.py --share
> > > 	sudo ./mfile.py --prefix=/usr/local install
> > > 	sudo ldconfig
> > >
> > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > ---
> > >
> > >
> > > Changes in V2:
> > >
> > > 	Fix branch report not appearing for kernel-only or user-only tracing:
> > > 	Find branch events named like "branches:k" or "branches:u" as well
> > as
> > > 	just plain "branches", by splitting the name at the colon. i.e.
> > > 	event = event.split(":")[0]
> > 
> > So, I followed the instructions then ended up with:
> > 
> > [acme@seventh perf]$ find /usr/local -name "*xed*" | head
> > /usr/local/lib/libxed.so /usr/local/lib/libxed.a /usr/local/lib/libxed-ild.so
> > /usr/local/lib/libxed-ild.a /usr/local/include/xed /usr/local/include/xed/xed-
> > syntax-enum.h
> > /usr/local/include/xed/xed-attributes.h
> > /usr/local/include/xed/xed-build-defines.h
> > /usr/local/include/xed/xed-cpuid-rec.h
> > /usr/local/include/xed/xed-flags.h
> > [acme@seventh perf]$
> > 
> > Ran ldconfig as root, etc:
> > 
> > [acme@seventh perf]$ ldconfig -v -N | grep xed
> > ldconfig: Can't stat /libx32: No such file or directory
> > ldconfig: Path `/usr/lib' given more than once
> > ldconfig: Path `/usr/lib64' given more than once
> > ldconfig: Can't stat /usr/libx32: No such file or directory [acme@seventh
> > perf]$
> > 
> > [acme@seventh perf]$ file /usr/local/lib/libxed.so
> > /usr/local/lib/libxed.so: ELF 64-bit LSB shared object, x86-64, version 1
> > (SYSV), dynamically linked,
> > BuildID[sha1]=09cf45310a731f727b4575582a638052b8f3e3bb, not stripped
> > [acme@seventh perf]$ file /usr/local/lib/libxed-ild.so
> > /usr/local/lib/libxed-ild.so: ELF 64-bit LSB shared object, x86-64, version 1
> > (SYSV), dynamically linked,
> > BuildID[sha1]=a5601603e305bb7b7f8edc7da0e78acbc9b63eba, not stripped
> > [acme@seventh perf]$
> > 
> > Tried with:
> > 
> > export LD_LIBRARY_PATH=/usr/local/lib/
> > 
> > But so far couldn't get it to show the disassembly.
> > 
> > The "All Branches" is there, wasn't in v1 of this patch.
> > 
> > Ideas?
> 
> The "All Branches" report is a 2-level tree, and the disassembly displays when the next level of the tree is opened
> i.e. click the arrow at the start of the line.

Right, I pressed on those arrows, nothing appeared, do you have any
hotkey to expand them all at once?
 
> Have you tried both kernel and user space?

[root@seventh perf]# perf evlist -v
intel_pt//u: type: 8, size: 112, config: 0x300e601, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, sample_id_all: 1
dummy:u: type: 1, size: 112, config: 0x9, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, context_switch: 1
[root@seventh perf]#

Good question, it was with that //u, so just userspace, trying removing
that part.
 
> The script looks for dsos in the build id cache.  The dsos can be viewed by selecting dsos_view from the Tables menu,
> so you could check if that information looks right.
> 
> Also the script has a variable "have_disassembler", so you could hack the script to print that to find out if XED is working.
> 
