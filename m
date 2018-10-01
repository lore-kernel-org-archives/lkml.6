Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551F0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F9F206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F9F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeJAN6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:58:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41967 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbeJAN6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:58:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g6sWe-0002g3-7L; Mon, 01 Oct 2018 01:21:52 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g6sWc-0003EL-V3; Mon, 01 Oct 2018 01:21:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     laurent@vivier.eu, LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        Andrey Vagin <avagin@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20180930234628.25528-1-laurent@vivier.eu>
        <CALCETrWcQtLTVJU14ytWxu_gqoLuAYZJpyAvRsKwwgYZz7FEFg@mail.gmail.com>
Date:   Mon, 01 Oct 2018 09:21:41 +0200
In-Reply-To: <CALCETrWcQtLTVJU14ytWxu_gqoLuAYZJpyAvRsKwwgYZz7FEFg@mail.gmail.com>
        (Andy Lutomirski's message of "Sun, 30 Sep 2018 21:45:44 -0700")
Message-ID: <874le63zei.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g6sWc-0003EL-V3;;;mid=<874le63zei.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/H3S2D4Mi8j/zdvRM9Uz3j1kjHEMb8Ok=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC 0/2] ns: introduce binfmt_misc namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Sun, Sep 30, 2018 at 4:47 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> This series introduces a new namespace for binfmt_misc.
>>
>
> This seems conceptually quite reasonable, but I'm wondering if the
> number of namespace types is getting out of hand given the current
> API.  Should we be considering whether we need a new set of namespace
> creation APIs that scale better to larger numbers of namespace types?

I would rather encourage a way to make this part of an existing
namespace or find a way to make a mount of binfmt_misc control this.

Hmm.  This looks like something that can be very straight forwardly be
made part of the user namespace.  If you ever mount binfmt_misc in the
user namespace you get the new behavior.  Otherwise you get the existing
behavior.

A user namespace will definitely be required, as otherwise you run the
risk of confusing root (and suid root exectuables0 by being able to
change the behavior of executables.

What is the motivation for this?  My impression is that very few people
tweak binfmt_misc.

I also don't think this raises to the level where it makes sense to
create a new namespace for this.

Eric
