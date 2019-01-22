Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EED1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4ED20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="btzN227s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfAVK55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:57:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42846 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfAVK55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:57:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so18902891edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 02:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=89a5LBbVO8YTJrZIzV4Tubq9JctJa11Qq8mbil8FPA0=;
        b=btzN227sBtTxLwWgDSgj0p0phRIGn1g+emcfqSDVYlBCxu/X/IasCZeoqo+NqX2AfJ
         lJKWxO8VdlkIVU+FnsiKAciBZihRJns+wfzRvU2IOKdEaehfS99m85lWWtwySJdK6dyH
         00VR1XSFuU1spAGOf45nLTvDqFmDYvvmrmXcrhGo+ZAXwsSDOk5OkpwYYIzvC/UNsvI7
         pZ2Q8l81drEtAsKliWyczU2kLN2GWb53VHb/S7U5q4yWSq4MBrsfZ09UlI/jizd8WWXd
         aXsATq4awGSnbZ/L6y4yC8W1X+9Ye+z3gTzVP82qi5pGeL/JQBndAzTevc9P5/m6AmB4
         9XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=89a5LBbVO8YTJrZIzV4Tubq9JctJa11Qq8mbil8FPA0=;
        b=j1zKwMN5M43vSXGMq4PHkU6XyboS6cfx9SB+8swPn0CzQ+GrWHeyIqhmcI3k0mMC/+
         u/PrW0hj9IS32j9mwuNj4R242nrAneR20Fhy8BFNlLEEv3zxEJr+xdK19IhQBUU2Cfwx
         muwkU53TehcOcCJpNgOm689Jf5++WRriEp5UNpdplW9W1HKDBoFxSQjQHLoeAUfXGf9k
         ARZ8GdtWYoIIolBZ0z3ns+AhN3jkiu2jsNVn4QvCSCseoseWM4+zn8MuZePoIlPKG7UL
         KwMN+o11uczrWpbZMjSM01alI/sni/8OPMO2o+cMWIHNieRhTSaVlmVedigFnqw7NSd6
         grkg==
X-Gm-Message-State: AJcUukeT8ah1Jx+Pj5MUK+OJ2F0yTBhNA2Tdh34hkJzNbXZTE3xUpw6d
        aeXYLGPXMy183pOOy1/wMBUOlg==
X-Google-Smtp-Source: ALg8bN5V7GlW1Y+AWf0/OkNQe30UzFodj6OhjQu+lvWoFdPJJt55RpVTB3jLb2O2rIhblWQFBwGo6Q==
X-Received: by 2002:a17:906:860a:: with SMTP id o10-v6mr27281437ejx.1.1548154675233;
        Tue, 22 Jan 2019 02:57:55 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id i14-v6sm5231241ejy.40.2019.01.22.02.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 02:57:54 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:57:48 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190122105747.6gxvghn7n5dxa65w@brauner.io>
References: <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
 <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io>
 <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io>
 <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
 <20190122093146.kmckcgdbvo2e7v3c@brauner.io>
 <20190122103009.vu2a67kviqhcb3cn@brauner.io>
 <CAK8P3a0EW6ZSMoo6FsRQ=XvyhJe50SR7YtpCtuHcPr=JO3fCtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0EW6ZSMoo6FsRQ=XvyhJe50SR7YtpCtuHcPr=JO3fCtA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:48:12AM +0100, Arnd Bergmann wrote:
> On Tue, Jan 22, 2019 at 11:30 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Tue, Jan 22, 2019 at 10:31:46AM +0100, Christian Brauner wrote:
> > > On Tue, Jan 22, 2019 at 10:26:56AM +0100, Arnd Bergmann wrote:
> > > > On Mon, Jan 21, 2019 at 11:48 PM Christian Brauner <christian@brauner.io> wrote:
> > > > >
> > > > > On Mon, Jan 21, 2019 at 03:44:17PM -0700, Jens Axboe wrote:
> > > > > > On 1/21/19 1:23 PM, Christian Brauner wrote:
> > > > > > > On Mon, Jan 21, 2019 at 09:15:27PM +0100, Arnd Bergmann wrote:
> > > > > > >> On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > >>> On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> > > > > > >>>> On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > > > >>>
> > > > > > >>> I plan on sending the pidfd branch with the new pidfd_send_signal()
> > > > > > >>> syscall for the 5.1 window. Should we somehow coordinate so that our
> > > > > > >>> branches don't conflict? Any suggestions?
> > > > > > >>
> > > > > > >> A conflict can't be avoided, but if you pick system call number 427
> > > > > > >> for pidfd_send_signal, and Jens picks numbers 424 through 426 for
> > > > > > >
> > > > > > > That sounds good to me. Since it's only one syscall for the pidfd branch
> > > > > > > is there anything that speaks against me using 424? Given that the other
> > > > > > > patchset has 4 new syscalls. :)
> > > > > > > Jens, any objections?
> > > > > >
> > > > > > I'm fine with either one, I'll have to renumber in any case. But it's 3
> > > > > > new syscalls (424, 425, 426), not 4.
> > > > > >
> > > > > > Arnd, what's the best way to make this switch now, in my tree? Would be
> > > > >
> > > > > Yeah, I'd like to know that as well.
> > > > >
> > > > > > great if I didn't have to change it again once I make the change.
> > > >
> > > > I'd suggest that you each just take the numbers we talked about and
> > > > add them in your respective git trees, at the end of the current tables.
> >
> > What should we do about unistd.h? We can't just bump that to 42*, right?
> 
> Do you mean the asm-generic uapi header? In my current series, I do that:

Yes. My idea was to only change pidfd_send_signal's entry to 424 and
leave the other ones untouched:

 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index b77538af7aca..4d86d0787d99 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -740,7 +740,7 @@ __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
-#define __NR_pidfd_send_signal 295
+#define __NR_pidfd_send_signal 424
 __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)

and also leave

#undef __NR_syscalls
#define __NR_syscalls 296

Does that work to avoid the merge conflict or do you need something
more?

Christian
