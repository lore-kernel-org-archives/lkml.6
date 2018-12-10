Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D649C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A1920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544472207;
	bh=KJyFyom7fFSw6+7GUcU+bxtzSltUVLEcEK6+zqctGCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sbLM1BQ3oChBUTGRqS3s1xwc/hjseN0njV/diWZ4lJncIVfuvfv1W+bSQsBst/rUN
	 b1auPvKb+DgKsWrBps85pbDanATVuXgUxa1Kj9fWhaYHBNBjBNBLBraV59Ddx+Wg3a
	 2dyJja0Y6xyvxLSLS/gZ22Fl6Wqngts1f0uAUiSo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A1920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeLJUDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:03:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:52164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbeLJUDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:03:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0B22AFCC;
        Mon, 10 Dec 2018 20:03:23 +0000 (UTC)
Date:   Mon, 10 Dec 2018 21:03:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] l1tf: drop the swap storage limit restriction when
 l1tf=off
Message-ID: <20181210200320.GX1286@dhcp22.suse.cz>
References: <20181113184910.26697-1-mhocko@kernel.org>
 <nycvar.YFH.7.76.1811132054521.19754@cbobk.fhfr.pm>
 <20181114073229.GC23419@dhcp22.suse.cz>
 <nycvar.YFH.7.76.1811191436140.21108@cbobk.fhfr.pm>
 <20181119135149.GN22247@dhcp22.suse.cz>
 <nycvar.YFH.7.76.1812092145510.17216@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1812092145510.17216@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09-12-18 21:46:57, Jiri Kosina wrote:
> On Mon, 19 Nov 2018, Michal Hocko wrote:
> 
> > > > > > +				It also drops the swap size and available
> > > > > > +				RAM limit restriction.
> > > > > 
> > > > > Minor nit: I think this should explicitly mention that those two things 
> > > > > are related to bare metal mitigation, to avoid any confusion (as otherwise 
> > > > > the l1tf cmdline parameter is purely about hypervisor mitigations).
> > > > 
> > > > Do you have any specific wording in mind?
> > > > 
> > > > It also drops the swap size and available RAM limit restrictions on both
> > > > hypervisor and bare metal.
> > > > 
> > > > Sounds better?
> > > > 
> > > > > With that
> > > > > 
> > > > > 	Acked-by: Jiri Kosina <jkosina@suse.cz>
> > > > 
> > > > Thanks!
> > > 
> > > Yes, I think that makes it absolutely clear. Thanks,
> > 
> > OK. Here is the incremental diff on top of the patch. I will fold and
> > repost later this week. I assume people are still catching up after LPC
> > and I do not want to spam them even more.
> 
> Is this queued anywhere in the meantime please?

Not yet. Thanks for the reminder. It completely fall of my radar.

Thomas, do you want me to resubmit or there are some other changes you
would like to see?
-- 
Michal Hocko
SUSE Labs
