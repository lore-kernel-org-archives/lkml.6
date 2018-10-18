Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56852C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1B2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C1B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJRPks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727395AbeJRPks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:40:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27D23B047;
        Thu, 18 Oct 2018 07:41:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9C77B1E088D; Thu, 18 Oct 2018 09:41:01 +0200 (CEST)
Date:   Thu, 18 Oct 2018 09:41:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Dilger <adilger@dilger.ca>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: statx(2) API and documentation
Message-ID: <20181018074101.GJ23493@quack2.suse.cz>
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
 <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca>
 <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
 <CAOQ4uxjqS3R_0O6gKVFEUJR7BvB+rpaHekjZm+fhMA+7on8AwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjqS3R_0O6gKVFEUJR7BvB+rpaHekjZm+fhMA+7on8AwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-10-18 01:15:13, Amir Goldstein wrote:
> On Wed, Oct 17, 2018 at 10:12 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > >> - STATX_ALL definition is unclear, can this change, or is it fixed?
> > >> If it's the former, than that's a backward compatibility nightmare.
> > >> If it's the latter, then what's the point?
> > >
> > > The value can change over time.  It is intended to reflect the current
> > > state of affairs at the time the userspace program and kernel are compiled.
> > > The value sent from userspace lets the kernel know what fields are in
> > > the userspace struct, so it doesn't try to set fields that aren't there.
> >
> > What's the point of a userspace program specifying STATX_ALL?  Without
> > a way to programmatically query the interface definition it's useless:
> > there's no way to guess which mask bit corresponds to which field, and
> > what that field represents.
> >
> > And there will be programs out there which specify STATX_ALL without
> > considering that in the future it may become slower as it is now due
> > to a recompile.
> >
> > So what's the point exactly?
> >
> > > The value in the kernel allows masking off new fields from userspace that
> > > it doesn't understand.
> >
> > Okay, but that has nothing to do with the UAPI.  Even as an internal
> > flag we should be careful, as it might grow uses which can have
> > similar issues as the userspace one above.
> >
> 
> FYI, I identified a similar anti-pattern in fanotify UAPI when I wanted to
> add new flags and did not want to change the UAPI _ALL_ constants.
> This is how we plan to solve it:
> https://github.com/amir73il/linux/commit/8c2b1acadb88ee4505ccc8bfdc665863111fb4cc

Yeah, after fanotify experience I find foo_ALL constants useless if not
dangerous for userspace.  Kernel internal constants like this are IMO
useful.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
