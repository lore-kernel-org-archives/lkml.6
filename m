Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB57C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB6120989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbfA3Nf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:35:58 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49831 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfA3Nf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:35:57 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1goq1s-0006Pg-J5; Wed, 30 Jan 2019 06:35:50 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1goq1r-0002aq-QB; Wed, 30 Jan 2019 06:35:48 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        util-linux@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
References: <20190130120654.q5zqcexquca7u337@ws.net.home>
        <87va2716mh.fsf@xmission.com> <9871.1548853314@warthog.procyon.org.uk>
Date:   Wed, 30 Jan 2019 07:35:39 -0600
In-Reply-To: <9871.1548853314@warthog.procyon.org.uk> (David Howells's message
        of "Wed, 30 Jan 2019 13:01:54 +0000")
Message-ID: <87h8dqs1xw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1goq1r-0002aq-QB;;;mid=<87h8dqs1xw.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ZJOQetI7Lkgvv6GnlYVYn14lB/eHgqEQ=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFD] A mount api that notices previous mounts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Karel Zak <kzak@redhat.com> wrote:
>
>> It seems more elegant is to ask for Nth option as expected by fsinfo().
>
> More elegant yes, but there's an issue with atomiticity[*].  I'm in the
> process of switching to something that returns you a single buffer with all
> the options in, but each key and each value is preceded by a length count.
>
> The reasons for not using separator characters are:
>
>  (1) There's no separator char that cannot validly occur within an option[**].

*Blink*  I had missed the cifs issue.  So yes we certainly need
a better way to encode things in the buffer.  I just used a single
string as an easy way to place everything in a buffer.

>  (2) Makes it possible to return binary values if we need to.

I don't totally disagree with this.  But I will point out that
except for coda passing a file descriptor there are no filesystems
that currently take or need binary options.

I suspect that as long as userspace supports /etc/fstab and we in turn
support /proc/mounts there is going to be a lot of pressure to keep
the majority of options so they  can be encoded in a string separated by
commas.

> David
>
> [*] Atomic with respect to remount calls, that is.

There are also mount options that depend on each other and whose order
matters with respect to other mount options extN's ("sb=<NNNN>") for
example.

> [**] Oh, and look at cifs where you can *change* the separator char during
>      option parsing ("sep=<char>").
