Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE4C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27532075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubWDZl6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27532075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeJXCgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeJXCgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:36:49 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA0A2075D;
        Tue, 23 Oct 2018 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540318341;
        bh=hpBaZnv8DAEhQqatNoqPl5h2IImlA9i4e/jA6zOrfOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubWDZl6C4kwHrQPMchXl5MQt/xdHD0cFvCKP9Z9hLMoT1QwcyyZEA4sJl3nkTryJw
         9NrApJs0W9p06nbB9Xip6/ou6nLwXQESnJWtoSuwRzJcu+R5phunIJuFzHji8CYOQB
         Hg/Bu/sRqfnKYnHmHi814Jt2YVuZyU+XleJBIPyY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8563D142C5E; Tue, 23 Oct 2018 15:12:18 -0300 (-03)
Date:   Tue, 23 Oct 2018 15:12:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
 Add All branches report
Message-ID: <20181023181218.GB6114@kernel.org>
References: <20181001062853.28285-18-adrian.hunter@intel.com>
 <20181023075949.18920-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023075949.18920-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 23, 2018 at 10:59:49AM +0300, Adrian Hunter escreveu:
> Add a report to display branches in a similar fashion to perf script. The
> main purpose of this report is to display disassembly, however, presently,
> the only supported disassembler is Intel XED, and additionally the object
> code must be present in perf build ID cache.
> 
> To use Intel XED, libxed.so must be present. To build and install
> libxed.so:
> 	git clone https://github.com/intelxed/mbuild.git mbuild
> 	git clone https://github.com/intelxed/xed
> 	cd xed
> 	./mfile.py --share
> 	sudo ./mfile.py --prefix=/usr/local install
> 	sudo ldconfig
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V2:
> 
> 	Fix branch report not appearing for kernel-only or user-only tracing:
> 	Find branch events named like "branches:k" or "branches:u" as well as
> 	just plain "branches", by splitting the name at the colon. i.e.
> 	event = event.split(":")[0]

So, I followed the instructions then ended up with:

[acme@seventh perf]$ find /usr/local -name "*xed*" | head
/usr/local/lib/libxed.so
/usr/local/lib/libxed.a
/usr/local/lib/libxed-ild.so
/usr/local/lib/libxed-ild.a
/usr/local/include/xed
/usr/local/include/xed/xed-syntax-enum.h
/usr/local/include/xed/xed-attributes.h
/usr/local/include/xed/xed-build-defines.h
/usr/local/include/xed/xed-cpuid-rec.h
/usr/local/include/xed/xed-flags.h
[acme@seventh perf]$

Ran ldconfig as root, etc:

[acme@seventh perf]$ ldconfig -v -N | grep xed
ldconfig: Can't stat /libx32: No such file or directory
ldconfig: Path `/usr/lib' given more than once
ldconfig: Path `/usr/lib64' given more than once
ldconfig: Can't stat /usr/libx32: No such file or directory
[acme@seventh perf]$ 

[acme@seventh perf]$ file /usr/local/lib/libxed.so
/usr/local/lib/libxed.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, BuildID[sha1]=09cf45310a731f727b4575582a638052b8f3e3bb, not stripped
[acme@seventh perf]$ file /usr/local/lib/libxed-ild.so
/usr/local/lib/libxed-ild.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, BuildID[sha1]=a5601603e305bb7b7f8edc7da0e78acbc9b63eba, not stripped
[acme@seventh perf]$ 

Tried with:

export LD_LIBRARY_PATH=/usr/local/lib/

But so far couldn't get it to show the disassembly.

The "All Branches" is there, wasn't in v1 of this patch.

Ideas?

- Arnaldo
