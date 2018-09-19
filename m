Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C30C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C7121521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3tex9Dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C7121521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbeITCSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731460AbeITCSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:18:20 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE752151B;
        Wed, 19 Sep 2018 20:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537389523;
        bh=qRADQrZoc+NIumfJBVRIUA3TFNI41caX+BnDt0ibD34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3tex9DnyZG1Cihvl+lgYY2b0nyDxkJi08MPmo/VeG1GrdP8RdRxqs6wb8Ax6hlsC
         iT/NV+2vncNtYAkKSrGrcesCaOrEiap+SmT0Bs1VQs2cRAmNJCrZnqP2fciPw8lALz
         tf7P8T+nQEkQgvajMtDp4A3PNvplraruKdUbHGZw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C3F86140260; Wed, 19 Sep 2018 17:38:40 -0300 (-03)
Date:   Wed, 19 Sep 2018 17:38:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1 03/10] tools, perf, script: Add --insn-trace for
 instruction decoding
Message-ID: <20180919203840.GL31812@kernel.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
 <20180829171834.6590-4-andi@firstfloor.org>
 <20180919181247.GC31812@kernel.org>
 <20180919200202.lzopwvlgdnsrokyh@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919200202.lzopwvlgdnsrokyh@two.firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 19, 2018 at 01:02:04PM -0700, Andi Kleen escreveu:
> On Wed, Sep 19, 2018 at 03:12:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Aug 29, 2018 at 10:18:27AM -0700, Andi Kleen escreveu:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > Add a --insn-trace short hand option for decoding and disassembling
> > > instruction streams for intel_pt. This automatically pipes the
> > > output into the xed disassembler to generate disassembled instructions.
> > > This just makes this use model much nicer to use
> > 
> > Would be nice to provide at least an URL to where to find xed, I tried
> > this:
> > 
> > [root@seventh ~]# dnf search xed
> > Last metadata expiration check: 0:25:39 ago on Wed 19 Sep 2018 02:42:36 PM -03.
> > =================================================================================== Name Exactly Matched: xed ====================================================================================
> > xed.i686 : X-Apps [Text] Editor (Cross-DE, backward-compatible, GTK3, traditional UI)
> > xed.x86_64 : X-Apps [Text] Editor (Cross-DE, backward-compatible, GTK3, traditional UI)
> > 
> > https://github.com/intelxed
> > 
> > So I have to install a build system and then install it to then build
> > intelxed?
> 
> Yes that's right.

Sure, so please add this extra info you provided here there, please, to
help speed up testing of your work.

I think this should go in the documentation section as well.
 
> I think some distros have it already packaged.
 
> 
> git clone https://github.com/intelxed/mbuild.git mbuild
> git clone https://github.com/intelxed/xed
> cd xed
> mkdir obj
> cd obj
> ../mfile.py
> sudo ../mfile.py --prefix=/usr/local install
> 
> -Andi
