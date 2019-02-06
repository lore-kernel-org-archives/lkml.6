Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A95DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4B7218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eni2uIBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfBFDKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:10:30 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:20453 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbfBFDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:10:30 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 5AE91E05;
        Tue,  5 Feb 2019 19:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1549422629;
        bh=bGGPhGmbcYhx+29tLhYNeqoBW22IGCZWaAvPb0f9SBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eni2uIBUkQSWwV/ApwpUrgfns8VSmUxX60QikkMZ1X6038EwOda9NKQi+99/yyEdm
         DzzBPvSo1ONaz5wV9fg7QNIv3mf8CGS354qNsaV6zYOOzSQRe6xHyujTog9wSPDhIh
         AZELdTf+7Ie2zql6+7YRwcTt6xrRSS8EIlTxn3TxCScSlGnHmEFKvathT+VGUJiGMx
         sPBBWqYqCpsBzA3ErjcAt2gZxMETW8aaKB16wx4zXinxUJnqsy7bx/64FqFnn0mY4H
         /zmw4Raz1hpsHWePBZAkb6p43W95Ponxt/C8VVPNXYaHPQaRrUUkW56H0Q09y2sdlN
         Axpwa/oOsYMMw==
Received: from visor (unknown [172.20.208.17])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 4D8E0E01;
        Tue,  5 Feb 2019 19:10:29 -0800 (PST)
Date:   Tue, 5 Feb 2019 19:10:29 -0800
From:   Ivan Delalande <colona@arista.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] exec: don't force_sigsegv processes with a pending
 fatal signal
Message-ID: <20190206031029.GB9368@visor>
References: <20190205025308.GA24455@visor>
 <20190205131119.3e388a0a1a69c0a041ed87ef@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205131119.3e388a0a1a69c0a041ed87ef@linux-foundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 01:11:19PM -0800, Andrew Morton wrote:
> On Mon, 4 Feb 2019 18:53:08 -0800 Ivan Delalande <colona@arista.com> wrote:
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1660,7 +1660,12 @@ int search_binary_handler(struct linux_binprm *bprm)
> >  		if (retval < 0 && !bprm->mm) {
> >  			/* we got to flush_old_exec() and failed after it */
> >  			read_unlock(&binfmt_lock);
> > -			force_sigsegv(SIGSEGV, current);
> > +			if (!fatal_signal_pending(current)) {
> > +				if (print_fatal_signals)
> > +					pr_info("load_binary() failed: %d\n",
> > +						retval);
> 
> Should we be using print_fatal_signal() here?

I don't think so, the force_sigsegv() already ensures it will be called
from get_signal() when the signal is handled, and so the process
information will be printed then.

> > +				force_sigsegv(SIGSEGV, current);
> > +			}
> >  			return retval;
> >  		}
> >  		if (retval != -ENOEXEC || !bprm->file) {


Thanks,

-- 
Ivan Delalande
Arista Networks
