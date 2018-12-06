Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F889C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C13D20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C13D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbeLFOuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:50:40 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:44743 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731382AbeLFOrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:12 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gUuvl-0006KF-SQ; Thu, 06 Dec 2018 07:47:09 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gUuvk-0007EM-V4; Thu, 06 Dec 2018 07:47:09 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Florian Weimer <fweimer@redhat.com>
Cc:     =?utf-8?Q?J=C3=BCrg?= Billeter <j@bitron.ch>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org
References: <20181206121858.12215-1-christian@brauner.io>
        <87h8fq7s84.fsf@oldenburg2.str.redhat.com>
        <b0e946bcac12358841c9a99017da819b00794d9c.camel@bitron.ch>
        <87pnue6bp2.fsf@oldenburg2.str.redhat.com>
        <87efaun587.fsf@xmission.com>
        <877egm6a7v.fsf@oldenburg2.str.redhat.com>
Date:   Thu, 06 Dec 2018 08:46:57 -0600
In-Reply-To: <877egm6a7v.fsf@oldenburg2.str.redhat.com> (Florian Weimer's
        message of "Thu, 06 Dec 2018 14:44:36 +0100")
Message-ID: <87bm5yiufy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gUuvk-0007EM-V4;;;mid=<87bm5yiufy.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19jtjKamkrEUK9Q6nfr2VyLBcCUuaxvkmM=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fweimer@redhat.com> writes:

> * Eric W. Biederman:
>
>> Floriam are you seeing a problem with this behavior or the way Christian
>> was describing it?
>
> My hope is that you could use taskfd_send_signal one day to send a
> signal to a process which you *known* (based on how you've written your
> application) should be running and not in a zombie state, and get back
> an error if it has exited.
>
> If you get this error, only then you wait on the process, using the file
> descriptor you have, and run some recovery code.
>
> Wouldn't that be a reasonable approach once we've got task descriptors?

Getting an error back if the target was a zombie does seem reasonable,
as in principle it is an easy thing to notice, and post zombie once the
process has been reaped we definitely get an error back.

I also agree that it sounds like an extension, as changing the default
would violate the princile of least surprise.

Eric
