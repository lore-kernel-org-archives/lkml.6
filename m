Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09542C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF9920895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF9920895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeJMP6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:58:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48402 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJMP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:58:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBFBa-0005qw-GX; Sat, 13 Oct 2018 08:22:10 +0000
Date:   Sat, 13 Oct 2018 09:22:10 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Jann Horn <jannh@google.com>, cyphar@cyphar.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] namei: aggressively check for nd->root escape on
 ".." resolution
Message-ID: <20181013082210.GU32577@ZenIV.linux.org.uk>
References: <20181009070230.12884-1-cyphar@cyphar.com>
 <20181009070230.12884-4-cyphar@cyphar.com>
 <CAG48ez3Ae5b20g2UquekfBNaUw1tLt4nWy2pYm-LNRMbDVpHfA@mail.gmail.com>
 <20181009153728.2altaqxclntvyc7b@mikami>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009153728.2altaqxclntvyc7b@mikami>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:37:28AM +1100, Aleksa Sarai wrote:
> > > +static inline int nd_alloc_dpathbuf(struct nameidata *nd)
> > > +{
> > > +       if (unlikely(!nd->dpathbuf)) {
> > > +               if (nd->flags & LOOKUP_RCU) {
> > > +                       nd->dpathbuf = kmalloc(PATH_MAX, GFP_ATOMIC);
> > > +                       if (unlikely(!nd->dpathbuf))
> > > +                               return -ECHILD;
> > > +               } else {
> > > +                       nd->dpathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> > > +                       if (unlikely(!nd->dpathbuf))
> > > +                               return -ENOMEM;
> > > +               }
> > > +       }
> > > +       return 0;
> > > +}
> > 
> > Note that a fixed-size path buffer means that if the path is very
> > long, e.g. because you followed long symlinks on the way down, this
> > can cause lookup failures.
> 
> This is already an issue with __d_path (even if the buffer was larger)
> because it will not output a path longer than PATH_MAX. I imagine this
> is a pretty strong argument for why we should refactor __d_path so that
> we can *just* use the escape checking to avoid -ENAMETOOLONG.

Let me get it straight - the whole point of that buffer is to check
if __d_path() returns NULL?  So you allocate it so that you would have
place to copy the path components into... only to have them completely
ignored?

How is that different from path_is_under()?
