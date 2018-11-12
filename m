Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C6DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBE820871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBE820871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbeKLL6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:58:20 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36528 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeKLL6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:58:19 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gM1dN-0004JY-Rs; Sun, 11 Nov 2018 19:07:25 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gM1dN-0003el-8o; Sun, 11 Nov 2018 19:07:25 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
        <87a7mut9cm.fsf@xmission.com>
        <2f4a2d58-dc7b-3a8f-65aa-9db432ce0a1e@redhat.com>
Date:   Sun, 11 Nov 2018 20:07:20 -0600
In-Reply-To: <2f4a2d58-dc7b-3a8f-65aa-9db432ce0a1e@redhat.com> (Steven
        Whitehouse's message of "Sat, 10 Nov 2018 14:19:44 +0000")
Message-ID: <877ehjkq07.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gM1dN-0003el-8o;;;mid=<877ehjkq07.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19JeGocBiNXsFqY4fNplYAdWx7eiv1Qduo=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [git pull] mount API series
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Whitehouse <swhiteho@redhat.com> writes:

> Hi,
>
>
> On 31/10/18 15:38, Eric W. Biederman wrote:
>> Al Viro <viro@ZenIV.linux.org.uk> writes:
>>
>>> 	mount API series from David Howells.  Last cycle's objections
>>> had been of the "I'd do it differently" variety and with no such
>>> differently done variants having ever materialized over several
>>> cycles...
>> Absolutely not.
>>
>> My objections fundamentally is that I can find real problems when I look
>> at the code.  Further the changes have not been incremental changes that
>> have evolved the code from one state to another but complete
>> replacements of code that make code review very difficult and bisection
>> completely inapplicable.
>>
>> I also object that this series completely fails to fix the worst but I
>> have ever seen in the mount API.  Whit no real intrest shown in working
>> to fix it.
>>
>> A couple of bugs that I can see quickly.  Several of which I have
>> previously reported:
>>
>> - There is an easily triggered NULL pointer deference with open_tree
>>    and mount propagation.
>>
>>
> Can you share some details of what this NULL dereference is? David and
> Al have been working on the changes as requested by Linus later in
> this thread, and they'd like to tidy up this issue too at the same
> time if possible. We are not asking you to actually provide a fix, in
> case you are too busy to do so, however it would be good to know what
> the issue is so that we can make sure that it is resolved in the next
> round of patches,

https://lore.kernel.org/lkml/87bm7n5k1r.fsf@xmission.com/

Eric
