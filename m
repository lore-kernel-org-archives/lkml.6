Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42697C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B4320671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="K6ITB3nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B4320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389594AbeG0Vo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:44:59 -0400
Received: from imap.thunk.org ([74.207.234.97]:36780 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389206AbeG0Vo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TDQvzs0MlcLj2XQqV5YBM4S5qZ4sNAUAfpLcN7K2uT8=; b=K6ITB3nrvxlzf85JieuCsV4hne
        j0Hn/1Ol/pn2ruBIPM9NqaxMJWFShlpJYAcjSerWaghfgB/NemDtFFI82KvfgSaS1leIECs0+e5om
        BKVJn0YcuLgfWnX+NjOG7QSOncpc0pNj+xFk0WFTIhB+IOAwCfCRVLbTXgqgQxMpupZ4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fj9Em-0001Pc-NY; Fri, 27 Jul 2018 20:21:20 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5D6877A6163; Fri, 27 Jul 2018 16:21:14 -0400 (EDT)
Date:   Fri, 27 Jul 2018 16:21:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jann Horn <jannh@google.com>, salyzyn@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Golden_Miller83@protonmail.ch, Greg KH <greg@kroah.com>,
        Kees Cook <keescook@google.com>, salyzyn@android.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180727202114.GH13922@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Steven Rostedt <rostedt@goodmis.org>, Jann Horn <jannh@google.com>,
        salyzyn@google.com, Nick Desaulniers <ndesaulniers@google.com>,
        Golden_Miller83@protonmail.ch, Greg KH <greg@kroah.com>,
        Kees Cook <keescook@google.com>, salyzyn@android.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
References: <753E9YR1QhdsPhsFoYuXCwfUzfyntDrc_A93hMUkktMi7lbh3KUZMcbfqKVWUfi15zYhuiDFant-ROa4QNV5shx74ff4hGngq2BOJDv-hq4=@protonmail.ch>
 <CAG48ez1U=5nTOrnOqwMuXhdER-7XxJUYLcyYNuczwasQLQ0gXA@mail.gmail.com>
 <20180727094730.3a448629@gandalf.local.home>
 <CAKwvOdmg4DSSwy9YBccYWzc+6ZU2yKSSFmfnj72wqbYDJU0gzw@mail.gmail.com>
 <20180727143141.4b53d554@gandalf.local.home>
 <CAMx4XWv3OazvURuN1XU2+5C5tNDzPuTniMn_T=XTA4P8_uwS_A@mail.gmail.com>
 <CAG48ez25zgjTQRux_rk1fn2DUVthtK31dRU9cxE+55pBGmYjXQ@mail.gmail.com>
 <CAG48ez1MdupASE1DMt0OWXv+rqZO-2GAbfDthEQcvNXrc2pTsQ@mail.gmail.com>
 <20180727195416.GF13922@thunk.org>
 <20180727161103.797f12b7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727161103.797f12b7@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 04:11:03PM -0400, Steven Rostedt wrote:
> That said, I would assume that
> other Android utilities are using other debugfs files for system
> status and such.

Yeah, I know we probably have lost the "debugfs is only for debugging
and has no place in a production system" battle, and we should just
move on and assume we need to completely harden all of debugfs.  But
it's worth at least *asking* whether or not the use of debugfs for
Android can be avoided....

					- Ted
