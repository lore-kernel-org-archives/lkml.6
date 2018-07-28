Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E6EC67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8306B20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="l5T5JMgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8306B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbeG1B3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 21:29:09 -0400
Received: from imap.thunk.org ([74.207.234.97]:37386 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388998AbeG1B3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 21:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iczM11v4Sb9qFS0jeKu0lewIsLnK/WmUlQd/yujAJpw=; b=l5T5JMgWtqzW25h3jtub1zFYUk
        d9SrMDIAFY2HwH/pUSsg9EL+tCMB0JqrKoEbrnGCpBDhQwaQXM4G1B+qn09EQcPWqqkdE9+1+LcLR
        68h0DsycAxUtGo/FIuzCAui81pb5B5dJtCAfq0c+B8dLLMVWnb4HWbtxEgFC1s/DbXbs=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fjCir-00035d-I2; Sat, 28 Jul 2018 00:04:38 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E2AF77A6163; Fri, 27 Jul 2018 20:04:28 -0400 (EDT)
Date:   Fri, 27 Jul 2018 20:04:28 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sandeep Patil <sspatil@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jann Horn <jannh@google.com>,
        salyzyn@google.com, Nick Desaulniers <ndesaulniers@google.com>,
        Golden_Miller83@protonmail.ch, Greg KH <greg@kroah.com>,
        Kees Cook <keescook@google.com>, salyzyn@android.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180728000428.GI13922@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sandeep Patil <sspatil@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, Jann Horn <jannh@google.com>,
        salyzyn@google.com, Nick Desaulniers <ndesaulniers@google.com>,
        Golden_Miller83@protonmail.ch, Greg KH <greg@kroah.com>,
        Kees Cook <keescook@google.com>, salyzyn@android.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
References: <20180727094730.3a448629@gandalf.local.home>
 <CAKwvOdmg4DSSwy9YBccYWzc+6ZU2yKSSFmfnj72wqbYDJU0gzw@mail.gmail.com>
 <20180727143141.4b53d554@gandalf.local.home>
 <CAMx4XWv3OazvURuN1XU2+5C5tNDzPuTniMn_T=XTA4P8_uwS_A@mail.gmail.com>
 <CAG48ez25zgjTQRux_rk1fn2DUVthtK31dRU9cxE+55pBGmYjXQ@mail.gmail.com>
 <CAG48ez1MdupASE1DMt0OWXv+rqZO-2GAbfDthEQcvNXrc2pTsQ@mail.gmail.com>
 <20180727195416.GF13922@thunk.org>
 <20180727161103.797f12b7@gandalf.local.home>
 <20180727202114.GH13922@thunk.org>
 <20180727220543.GT190909@sspatil-desktop.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727220543.GT190909@sspatil-desktop.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:05:43PM -0700, Sandeep Patil wrote:
> On Fri, Jul 27, 2018 at 04:21:14PM -0400, Theodore Y. Ts'o wrote:
> > On Fri, Jul 27, 2018 at 04:11:03PM -0400, Steven Rostedt wrote:
> > > That said, I would assume that
> > > other Android utilities are using other debugfs files for system
> > > status and such.
> 
> As of today, I think a lot of information in 'bugreports' is read
> out of debugfs (including things like binder stats). We do have a plan
> to change that.

Hmm, if it's only for bugreports, maybe it can be only mounted when
about root processes getting tricked into reading from debugfs.


> Indeed, I think it can. However, the problem is the last time I tried to
> remove this a whole bunch of things just broke. So, it wasn't about losing
> a functionality here and there. Agree, we need to clean up platform to not use
> debugfs first. Then we can expect Apps or other native processes to not rely
> on debugfs at all.

Is Android controlling access to debugfs files via SELinux?  If so,
then access to debugfs can be gradually cranked down as use cases are
removed.

						- Ted


   	   	       
