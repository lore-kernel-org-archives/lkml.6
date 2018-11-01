Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984A6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1402064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1402064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeKAXUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:20:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43858 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeKAXUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:20:02 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gIDmG-0000fQ-7d; Thu, 01 Nov 2018 08:16:52 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gIDm0-0006Zm-G8; Thu, 01 Nov 2018 08:16:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, dima@arista.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20181010161430.11633-1-laurent@vivier.eu>
        <7ed6f823-547b-922d-59ff-aba9c4c3ab39@vivier.eu>
        <1541041159.4632.6.camel@HansenPartnership.com>
        <CAG48ez3HnkRM6bUZMNjuTy5DgujgamEKhZOEWDfCjqW7fTJSzQ@mail.gmail.com>
        <fcebfa0c-b389-5c4d-19b8-2f08b487ec25@vivier.eu>
Date:   Thu, 01 Nov 2018 09:16:04 -0500
In-Reply-To: <fcebfa0c-b389-5c4d-19b8-2f08b487ec25@vivier.eu> (Laurent
        Vivier's message of "Thu, 1 Nov 2018 13:28:19 +0100")
Message-ID: <87zhusq3x7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gIDm0-0006Zm-G8;;;mid=<87zhusq3x7.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18mBMajEjWpwLtYY4VwS2HOfEP0PAvu5tc=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v6 0/1] ns: introduce binfmt_misc namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Vivier <laurent@vivier.eu> writes:

> On 01/11/2018 04:51, Jann Horn wrote:
>> On Thu, Nov 1, 2018 at 3:59 AM James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>>>
>>> On Tue, 2018-10-16 at 11:52 +0200, Laurent Vivier wrote:
>>>> Hi,
>>>>
>>>> Any comment on this last version?
>>>>
>>>> Any chance to be merged?
>>>
>>> I've got a use case for this:  I went to one of the Graphene talks in
>>> Edinburgh and it struck me that we seem to keep reinventing the type of
>>> sandboxing that qemu-user already does.  However if you want to do an
>>> x86 on x86 sandbox, you can't currently use the binfmt_misc mechanism
>>> because that has you running *every* binary on the system emulated.
>>> Doing it per user namespace fixes this problem and allows us to at
>>> least cut down on all the pointless duplication.
>> 
>> Waaaaaait. What? qemu-user does not do "sandboxing". qemu-user makes
>> your code slower and *LESS* secure. As far as I know, qemu-user is
>> only intended for purposes like development and testing.
>> 
>
> I think the idea here is not to run qemu, but to use an interpreter
> (something like gVisor) into a container to control the binaries
> execution inside the container without using this interpreter on the
> host itself (container and host shares the same binfmt_misc
> magic/mask).

Please remind me of this patchset after the merge window is over, and if
there are no issues I will take it via my user namespace branch.

Last I looked I had a concern that some of the permission check issues
were being papered over by using override cred instead of fixing the
deaper code.  Sometimes they are necessary but seeing work-arounds
instead of fixes for problems tends to be a maintenance issue, possibly
with security consequences.  Best is if the everyone agrees on how all
of the interfaces work so their are no surprises.

Eric


