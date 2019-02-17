Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8204DC10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFDD217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfBQSp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 13:45:58 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46212 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfBQSp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 13:45:58 -0500
Received: from mail.ispras.ru (localhost [127.0.0.1])
        by mail.ispras.ru (Postfix) with ESMTPSA id 632C6540093;
        Sun, 17 Feb 2019 21:45:54 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 17 Feb 2019 21:45:54 +0300
From:   efremov <efremov@ispras.ru>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Edwin Zimmerman <edwin@211mainstreet.net>,
        'Casey Schaufler' <casey@schaufler-ca.com>,
        "'Eric W. Biederman'" <ebiederm@xmission.com>,
        'Eric Paris' <eparis@parisplace.org>,
        'Kees Cook' <keescook@chromium.org>,
        'John Johansen' <john.johansen@canonical.com>,
        'James Morris' <jmorris@namei.org>,
        "'Serge E. Hallyn'" <serge@hallyn.com>,
        'Paul Moore' <paul@paul-moore.com>,
        'Kentaro Takeda' <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        owner-linux-security-module@vger.kernel.org
Subject: Re: [PATCH 06/10] security: fix documentation for the path_chmod hook
Organization: ISPRAS
In-Reply-To: <20190207144654.GB2217@ZenIV.linux.org.uk>
References: <cover.1549540487.git.efremov@ispras.ru>
 <0275d06334cdb1d2a87384d7971924a70776b3cb.1549540487.git.efremov@ispras.ru>
 <20190207134939.GA2217@ZenIV.linux.org.uk>
 <000001d4beee$caa8eff0$5ffacfd0$@211mainstreet.net>
 <20190207144654.GB2217@ZenIV.linux.org.uk>
Message-ID: <abeba1c9e7b0df7097834b65f3af6934@ispras.ru>
X-Sender: efremov@ispras.ru
User-Agent: Roundcube Webmail/1.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Al Viro писал 2019-02-07 17:46:
> On Thu, Feb 07, 2019 at 09:09:49AM -0500, Edwin Zimmerman wrote:
>> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> > > index cb93972257be..5d6428d0027b 100644
>> > > --- a/include/linux/lsm_hooks.h
>> > > +++ b/include/linux/lsm_hooks.h
>> > > @@ -304,8 +304,7 @@
>> > >   *	Return 0 if permission is granted.
>> > >   * @path_chmod:
>> > >   *	Check for permission to change DAC's permission of a file or directory.
>> > > - *	@dentry contains the dentry structure.
>> > > - *	@mnt contains the vfsmnt structure.
>> > > + *	@path contains the path structure.
>> >
>> > May I politely inquire about the value of these comments?  How much information
>> > is provided by refering to an argument as "the dentry structure" or "the path
>> > structure", especially when there's nothing immediately above that would introduce
>> > either.  "Type of 'dentry' argument is somehow related to struct dentry,
>> > try and guess what the value might be - we don't care, we just need every
>> > argument commented"?
>> >
>> > Who needs that crap in the first place?
>> 
>> The comments fill a valuable place to folks like me who are new to the 
>> linux security modules.
>> In my spare time, I'm writing a new LSM specifically geared for 
>> parental controls uses, and the
>> comments in lsm_hooks.h have helped me out more than once.  Perhaps 
>> the comments could
>> be inproved by changing them to something like this:
>> "@[arg] contains the [type] structure, defined in linux/[?].h"
> 
> Um...   The _type_ of argument is visible in declaration already;
> it doesn't say a damn thing about the value of that argument.
> 
> In this particular case, dentry/mnt pair (whichever way it gets
> passed; struct path is exactly such a pair) is actually used to
> specify the location of file or directory in question, but
> try to guess that by description given in this "documentation"...
> 
> As for "defined in"... that's what grep/ctags/etc. are for.
> Again, the useful information about an argument is _what_ gets
> passed in it, not just which type it is...

While I completely agree about the doubtful value of such comments,
the whole documentation is written in style like that. Unfortunately,
I don't have the knowledge to rewrite the documentation in every case
even for functions from this patchset. And I will be surprised if a
single person could do it for the whole LSM set.
The patchset only minimally updates the documentation to lift it up
to the current LSM declarations. And maybe to show once again that
despite we've got the documentation on a hook it maybe not actual
for 12 years since the hook was changed in 2006. But of course, it
doesn't mean that documentation is not needed.
This can give the maintainers additional arguments for stricter checks
before accepting new hooks and changing the existing ones.
I will try to improve the description in the second version of the
patchset.
