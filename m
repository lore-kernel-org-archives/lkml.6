Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7014C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD71F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbfA3RnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:43:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732541AbfA3RnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:43:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BEEAC7912;
        Wed, 30 Jan 2019 17:43:13 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17921608C8;
        Wed, 30 Jan 2019 17:43:10 +0000 (UTC)
Date:   Wed, 30 Jan 2019 18:43:06 +0100
From:   Karel Zak <kzak@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        util-linux@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFD] A mount api that notices previous mounts
Message-ID: <20190130174306.4nbrh2m53re35qch@ws.net.home>
References: <20190130120654.q5zqcexquca7u337@ws.net.home>
 <87va2716mh.fsf@xmission.com>
 <9871.1548853314@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9871.1548853314@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 30 Jan 2019 17:43:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:01:54PM +0000, David Howells wrote:
> Karel Zak <kzak@redhat.com> wrote:
> 
> > It seems more elegant is to ask for Nth option as expected by fsinfo().
> 
> More elegant yes, but there's an issue with atomiticity[*].  I'm in the
> process of switching to something that returns you a single buffer with all
> the options in, but each key and each value is preceded by a length count.

Sounds good, for me is important to avoid all the split/join
operations with the strings.

> The reasons for not using separator characters are:
> 
>  (1) There's no separator char that cannot validly occur within an option[**].

Yes, it's pretty common for selinux mount options where "," is
used within an option, so mount options string looks like

    'context="system_u:object_r:tmp_t:s0:c127,c456",noexec'

and I have doubts all the parses in userspace are compatible with this
use case...

>  (2) Makes it possible to return binary values if we need to.

Yes.

> [**] Oh, and look at cifs where you can *change* the separator char during
>      option parsing ("sep=<char>").

No comment :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
