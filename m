Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BE2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA95213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA95213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeLERdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:33:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:13810 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLERdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:33:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="116293645"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Dec 2018 09:33:06 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C8D93300F9B; Wed,  5 Dec 2018 09:33:06 -0800 (PST)
Date:   Wed, 5 Dec 2018 09:33:06 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf, tools: Support srccode output
Message-ID: <20181205173306.GJ18167@tassilo.jf.intel.com>
References: <20181204001848.24769-1-andi@firstfloor.org>
 <20181205122838.GH2950@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205122838.GH2950@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 01:28:38PM +0100, Jiri Olsa wrote:
> On Mon, Dec 03, 2018 at 04:18:48PM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > When looking at PT or brstackinsn traces with perf script
> > it can be very useful to see the source code. This adds a simple
> > facility to print them with perf script, if the information
> > is available through dwarf
> > 
> > % perf record ...
> > % perf script -F insn,ip,sym,srccode
> > ...
> > 
> >           4004c6 main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004c6 main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004b3 main
> > 6                       v++;
> > 
> > % perf record -b ...
> > % perf script -F insn,ip,sym,srccode,brstackinsn
> > 
> > ...
> >        main+22:
> >         0000000000400543        insn: e8 ca ff ff ff            # PRED
> > |18                     f1();
> >         f1:
> >         0000000000400512        insn: 55
> > |10       {
> >         0000000000400513        insn: 48 89 e5
> >         0000000000400516        insn: b8 00 00 00 00
> > |11             f2();
> >         000000000040051b        insn: e8 d6 ff ff ff            # PRED
> >         f2:
> >         00000000004004f6        insn: 55
> > |5        {
> >         00000000004004f7        insn: 48 89 e5
> >         00000000004004fa        insn: 8b 05 2c 0b 20 00
> > |6              c = a / b;
> >         0000000000400500        insn: 8b 0d 2a 0b 20 00
> >         0000000000400506        insn: 99
> >         0000000000400507        insn: f7 f9
> >         0000000000400509        insn: 89 05 29 0b 20 00
> >         000000000040050f        insn: 90
> > |7        }
> >         0000000000400510        insn: 5d
> >         0000000000400511        insn: c3                        # PRED
> >         f1+14:
> >         0000000000400520        insn: b8 00 00 00 00
> > |12             f2();
> >         0000000000400525        insn: e8 cc ff ff ff            # PRED
> >         f2:
> >         00000000004004f6        insn: 55
> > |5        {
> >         00000000004004f7        insn: 48 89 e5
> >         00000000004004fa        insn: 8b 05 2c 0b 20 00
> > |6              c = a / b;
> > 
> > Not supported for callchains currently, would need some
> > layout changes there.
> 
> nice, works nicely, especialy with --xed
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> I need to check, but is there a way to make this work with
> perf-with-kcore script? looks like we endup with kcore and
> won't allow vmlinux lookups for debug info

Hmm, probably not currently. Would somehow need to point
to the debuginfo. Perhaps if /proc/kcore was fixed
to report the debugid, and then could find it this way.

Or we could add an option to perf report to add a vmlinux
only for debug info that is not used for reading the code.

-andi
