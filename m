Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45465C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0870520879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544028876;
	bh=GHWMKDvjg3UZ+B51Fo026mwKtxcQfP91t9mCbAdTddc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ttnxAa2Lxn9QUBuc9+opfh8qmPrziMjRBysPFdsiR0SpC2tPVuqBKoy65gOPy7ClS
	 ivcNiJ5Z8dNa6LMaWqgTiPkTyNxBPt1cdO4ZHFrBCP4c8PpRPrrUC1eP2GZylq9RGY
	 lzQZsJU8Fg+pReZSXCgc8yg3LeQxvmwvjpcNzyTI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0870520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeLEQye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:54:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeLEQye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:54:34 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E90052084C;
        Wed,  5 Dec 2018 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544028873;
        bh=GHWMKDvjg3UZ+B51Fo026mwKtxcQfP91t9mCbAdTddc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C51JO9aVe+Z8f2NRVmvUHSTc0mooRat0w2wvM+YW7yl0SdlpOTwfnyC0Zl8tDIcoA
         DB2hwiglRcA/Ffz7Og8Zvow3O94NTQQY7e/n5/ViZMTJm7mR9MtPKmEAK1R1VrNkyG
         aN/4ntx4jryPqd6DLK3ZtONtqRe33dx7f1Y8gqlE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F71C4042C; Wed,  5 Dec 2018 13:54:30 -0300 (-03)
Date:   Wed, 5 Dec 2018 13:54:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf, tools: Support srccode output
Message-ID: <20181205165430.GA13522@kernel.org>
References: <20181204001848.24769-1-andi@firstfloor.org>
 <20181205122838.GH2950@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205122838.GH2950@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 05, 2018 at 01:28:38PM +0100, Jiri Olsa escreveu:
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

The above seems to imply you actually tested it, was that the case? Can
you please provide me the exact 'perf record' line you used, that is
lacking in Andi's original commit log message?

- Arnaldo
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>


