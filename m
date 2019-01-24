Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA12C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA221855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548336370;
	bh=TbEKS4grrYv8aGXZIGGlSPe47UG4tcuYxSWh9Zjj14k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sg36MN24tWD4gV9zm7+bOUEu18DBBhmHqyL3DHoqfbkGMiqh19OC40ce6e5m9Yixr
	 EXPd+F1q0g6dc27n/i0TDaB9n4DeO4Xxi482KTnUkjpJSV9qG+i/iLW4an9T5GhZqF
	 nFbu1q4N8VE3m34wch5tBqj5yMDDXBuMZeEi8u3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfAXN0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfAXN0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:26:07 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8F621855;
        Thu, 24 Jan 2019 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548336366;
        bh=TbEKS4grrYv8aGXZIGGlSPe47UG4tcuYxSWh9Zjj14k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1I9SEfWwXjq9dvU0r3KcKMczNcQNlBnz59410pyaTYcvuQtU21NloknUbcGGDCDB
         ssp9nhancxQ2dxjNP27P+jdU6I4eSVnDVutu7NteF7vtC2tB+HYIhYfFUgjmOX6dag
         MJmNVrPfBQh+uaWjq/ig2ATbvDzSmVd9wMFNkgv0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 78C124034F; Thu, 24 Jan 2019 14:26:04 +0100 (CET)
Date:   Thu, 24 Jan 2019 14:26:04 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/6] Fix issues with Python3 scripting
Message-ID: <20190124132604.GB30768@kernel.org>
References: <20190124005229.16146-1-tonyj@suse.de>
 <20190124103922.GB13852@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124103922.GB13852@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 24, 2019 at 11:39:22AM +0100, Jiri Olsa escreveu:
> On Wed, Jan 23, 2019 at 04:52:23PM -0800, Tony Jones wrote:
> > Seeteena posted, earlier this week, some patches to add Python3 support
> > to scripts/python/*.py.  Unfortunately there were some issues with these
> > patches (such as: https://lkml.org/lkml/2019/1/17/351)
> > 
> > Since I already had a tested set of patches in openSUSE:Factory and 
> > SLE15-SP1 and was about to submit them, Seeteena and I that agreed I 
> > should post my patches not involving scripts/python/*.py and Seeteena 
> > will later resubmit the patches for scripts/python/*.py incorporating 
> > my review feedback under a joint signed-off-by.
> > 
> > It should be noted that the use of "from __future__ import print_function" 
> > (see: https://lkml.org/lkml/2019/1/16/641) and "except as" (see change to:
> > tests/attr.py) implies Python2 >= 2.6 as the necessary support has not 
> > been backported to prior versions.  I am not sure if it's worth detecting 
> > <2.6 at build time or whether it's sufficiently old as to be a non-issue?
> > 
> > The shebang changes were driven mostly by our build process as it scans
> > all files within an rpm and the shebangs would result in a rpm requires
> > on the python2 binary when BuildRequires was python3-devel. I think they 
> > make sense to apply upstream but understand totally if it's prefered we 
> > keep them local.
> > 
> > These changes have been tested with PYTHON=python2 (v2.7) and 
> > PYTHON=python3 (v3.6) on latest openSUSE Tumbleweed.  I did notice that 
> 
> please try latest code from Arnaldo, we just had fix in that area
> 
> > test #18 "'import perf' in python" is failing on my system without these 
> > changes. I'll look at it further but didn't want to hold up Seeteena's 
> > resubmit.
> > 
> > Tony Jones (6):
> >   perf script python: Add trace_context extension module to sys,modules
> >   perf script python: Use PyBytes for attr in trace-event-python
> >   perf script python: remove explicit shebang from setup.py
> >   perf script python: remove explicit shebang from tests/attr.c
> >   perf script python: remove explicit shebang from Python scripts
> >   perf script python: add Python3 support to tests/attr.py
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, tested and applied.

- Arnaldo
