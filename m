Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E19C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92B920869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfA3SA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:00:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfA3SA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:00:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D781C062EA1;
        Wed, 30 Jan 2019 18:00:58 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C914B26387;
        Wed, 30 Jan 2019 18:00:53 +0000 (UTC)
Date:   Wed, 30 Jan 2019 19:00:51 +0100
From:   Karel Zak <kzak@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        util-linux@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFD] A mount api that notices previous mounts
Message-ID: <20190130180051.caonbh2t7wtsdqo5@ws.net.home>
References: <20190130120654.q5zqcexquca7u337@ws.net.home>
 <87va2716mh.fsf@xmission.com>
 <9871.1548853314@warthog.procyon.org.uk>
 <87h8dqs1xw.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8dqs1xw.fsf@xmission.com>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 30 Jan 2019 18:00:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 07:35:39AM -0600, Eric W. Biederman wrote:
> I suspect that as long as userspace supports /etc/fstab and we in turn
> support /proc/mounts there is going to be a lot of pressure to keep
> the majority of options so they  can be encoded in a string separated by
> commas.

Well, we're doing many crazy things in userspace ;-) For example we do
not distinguish between VFS flags (MS_*), FS specific mount options
and userspace mount options (loop=) in our config files. 

You already need to parse fstab/command line before you can use the 
strings for mount(2) syscall. It's already not straightforward, see
all the code in libmount...

/proc/mounts is only for backward compatibility, /proc/self/mountinfo
is better way, because it allows to see VFS and FS, etc.

IMHO it would be better to not care about way how we use mount options 
strings now (in userspace) when you think about the new API design.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
