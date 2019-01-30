Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B9BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F22620880
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfA3CAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:00:51 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36935 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfA3CAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:00:51 -0500
X-Greylist: delayed 2248 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 21:00:50 EST
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1goeb2-0008LQ-Py; Tue, 29 Jan 2019 18:23:20 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1goeb2-0002hM-6D; Tue, 29 Jan 2019 18:23:20 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        LSM <linux-security-module@vger.kernel.org>
References: <87va2716mh.fsf@xmission.com>
        <03e0993b-21db-1cc4-7a33-0236de7be20d@schaufler-ca.com>
        <87r2cvx7wz.fsf@xmission.com>
Date:   Tue, 29 Jan 2019 19:23:12 -0600
In-Reply-To: <87r2cvx7wz.fsf@xmission.com> (Eric W. Biederman's message of
        "Tue, 29 Jan 2019 19:15:24 -0600")
Message-ID: <87ef8vx7jz.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1goeb2-0002hM-6D;;;mid=<87ef8vx7jz.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+h0u/hM65+5LW6450Qd/ruXX6rx6yJOAg=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFD] A mount api that notices previous mounts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Casey Schaufler <casey@schaufler-ca.com> writes:
>> Are you taking the LSM specific mount options into account?
>
> In the design yes, and I allow setting them.  It appears in the code
> to retrieve the mount options I forgot to call security_sb_show_options.
>
> For finding the super block that you are going to mount the LSM mount
> options are not relevant.  Even nfs will not want to set those early as
> they do not help determine the nfs super block.  So the only place where
> there is anything interesting in my api is in reading back the security
> options so they can be compared to the options the mounter is setting.
>
> I will add the missing call to security_sb_show_options which is enough
> to fix selinux.  Unfortunately smack does not currently implement
> .sb_show_options.  Not implementing smack_sb_show_options means
> /proc/mounts fails to match /etc/mtab which is a bug and it is likely
> a real workd bug for the people who use smack and don't want to depend
> on /etc/mtab, or are transitioning away from it.
>
> Casey do you want to implement smack_sb_show_options or should I put it
> on my todo list?

Oh.  I should add that I am always parsing the LSM mount options out so
that there is not a chance of the individual filesystems implementing
comflicting options even when there are no LSMs active.  Without that I
am afraid we run the risk of having LSM mount otions in conflict with
ordinary filesystems options at some point and by the time we discover
it it would start introducing filesystem regressions.

That does help with stack though as there is no fundamental reason only
one LSM could process mount options.

Eric


