Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F451C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CBD20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfA3MHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:07:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbfA3MHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:07:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02EB5C0601ED;
        Wed, 30 Jan 2019 12:07:00 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F7D0377B;
        Wed, 30 Jan 2019 12:06:57 +0000 (UTC)
Date:   Wed, 30 Jan 2019 13:06:54 +0100
From:   Karel Zak <kzak@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        util-linux@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFD] A mount api that notices previous mounts
Message-ID: <20190130120654.q5zqcexquca7u337@ws.net.home>
References: <87va2716mh.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va2716mh.fsf@xmission.com>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 30 Jan 2019 12:07:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:44:22PM -0600, Eric W. Biederman wrote:
> so I am proposing we change this in the new mount api.

Well, this forces me to ask what the new API is? :-)

It seems that David uses fsconfig() and fsinfo() to set and get
mount options, and your patch introduces fsset() and fsoptions().

IMHO differentiate between FS driver and FS instance is a good idea it
makes things more extendable. The sequence number in the instance is a
good example.

But for me David's fsinfo() seems better that fsoptions() and
fsspecifier(). I'm not sure about "all mount options as one string"
From your example is pretty obvious how much energy is necessary to 
split and join the strings.

It seems more elegant is to ask for Nth option as expected by fsinfo().
It also seems that fsinfo() is able to replace fsname() and fstype().

It would be better to extend David's fsinfo() to work with FS instance
and to return specifiers. And use fsconfig() rather than fsset().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
