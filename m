Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723C7C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417FF20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417FF20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeLAB6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:58:05 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:36748 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeLAB6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:58:05 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gSk5n-000333-Gj; Fri, 30 Nov 2018 07:48:31 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gSk5X-0007ix-U3; Fri, 30 Nov 2018 07:48:31 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Radoslaw Burny <rburny@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jsperbeck@google.com
References: <20181126172607.125782-1-rburny@google.com>
        <20181127011627.GI4922@garbanzo.do-not-panic.com>
        <87k1kzjdff.fsf@xmission.com>
        <20181130010928.GM4922@garbanzo.do-not-panic.com>
Date:   Fri, 30 Nov 2018 08:48:11 -0600
In-Reply-To: <20181130010928.GM4922@garbanzo.do-not-panic.com> (Luis
        Chamberlain's message of "Thu, 29 Nov 2018 17:09:28 -0800")
Message-ID: <87k1ku39lg.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gSk5X-0007ix-U3;;;mid=<87k1ku39lg.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/2ezH0hFo2xtBtFK3oq45sUTHj7cD3Kbo=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] fs: Make /proc/sys inodes be owned by global root.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Mon, Nov 26, 2018 at 11:29:40PM -0600, Eric W. Biederman wrote:
>> Luis Chamberlain <mcgrof@kernel.org> writes:
>> > Thanks for the description of how to run into the issue described but
>> > is there also a practical use case today where this is happening? I ask
>> > as it would be good to know the severity of the issue in the real world
>> > today.
>> 
>> People trying to run containers without a root user in the container.
>> It atypical but something doable.  
>
> My question was if there are generic tools / propreitary tools which are
> doing this widely *today*. Or is this just a custom setup some folks
> use?
>
>> We spoke about this at LPC.  And this is the correct behavioral change.
>> 
>> The problem is there is a default value for i_uid and i_gid that is
>> correct in the general case.  That default value is not corect for
>> sysctl, because proc is weird.  As the sysctl permission check in
>> test_perm are all against GLOBAL_ROOT_UID and GLOBAL_ROOT_GID we did not
>> notice that i_uid and i_gid were being set wrong.
>> 
>> So all this patch does is fix the default values i_uid and i_gid.
>> 
>> The commit comment seems worth cleaning up.  But for the
>> content of the code.
>
> The logic seems sensible then, but are we implicating what a container
> does with its sysctl values onto the entire system? If so, sure, it
> seems you want this for networking purposes as there are a series of
> sysctl values a container may want to muck with, but are we sure we
> want the same for *all* sysctl entries?

No.  Please look at the patch again.  It sets the default uid and gid
for sysctl entries to 0.  AKA GLOBAL_ROOT_UID and GLOBAL_ROOT_GID
because there is a bug and they were not set to that value.

Those are the uids and gids that are tested agasint.  It just happens
you have to be in a weird configuration for this bug to become a problem.

Eric
