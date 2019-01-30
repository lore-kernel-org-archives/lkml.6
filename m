Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68E9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6C9218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfA3Npm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:45:42 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:34573 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3Npl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:45:41 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1goqBQ-0004WJ-6O; Wed, 30 Jan 2019 06:45:40 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1goqBP-000898-Ix; Wed, 30 Jan 2019 06:45:40 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        util-linux@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
References: <87va2716mh.fsf@xmission.com>
        <20190130120654.q5zqcexquca7u337@ws.net.home>
Date:   Wed, 30 Jan 2019 07:45:31 -0600
In-Reply-To: <20190130120654.q5zqcexquca7u337@ws.net.home> (Karel Zak's
        message of "Wed, 30 Jan 2019 13:06:54 +0100")
Message-ID: <877eemqmx0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1goqBP-000898-Ix;;;mid=<877eemqmx0.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ZPWffP5QwSJqsnLWhS+ET0er6VxPUvd8=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFD] A mount api that notices previous mounts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Zak <kzak@redhat.com> writes:

> On Tue, Jan 29, 2019 at 03:44:22PM -0600, Eric W. Biederman wrote:
>> so I am proposing we change this in the new mount api.
>
> Well, this forces me to ask what the new API is? :-)
>
> It seems that David uses fsconfig() and fsinfo() to set and get
> mount options, and your patch introduces fsset() and fsoptions().
>
> IMHO differentiate between FS driver and FS instance is a good idea it
> makes things more extendable. The sequence number in the instance is a
> good example.
>
> But for me David's fsinfo() seems better that fsoptions() and
> fsspecifier(). I'm not sure about "all mount options as one string"
> From your example is pretty obvious how much energy is necessary to 
> split and join the strings.
>
> It seems more elegant is to ask for Nth option as expected by fsinfo().
> It also seems that fsinfo() is able to replace fsname() and fstype().
>
> It would be better to extend David's fsinfo() to work with FS instance
> and to return specifiers. And use fsconfig() rather than fsset().

As David has pointed out with cifs having a sep= option we need a better
story of parsing the options in the kernel.

What my branch does is demonstrate there is at least one way we can
avoid mount options being silently different from what userspace
expects.

Which means my branch is fine for looking at semantics and possible
system calls, but not much else.

I actually used multiple system calls just so I could avoid dealing
with multi-plexor systems calls.

Eric


