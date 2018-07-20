Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA8FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D050204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D050204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeGUAR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:17:57 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51465 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUAR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:17:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fgeo5-0006nJ-5N; Fri, 20 Jul 2018 17:27:29 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fgeo4-0001zI-F3; Fri, 20 Jul 2018 17:27:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <877em2jxyr.fsf_-_@xmission.com>
        <20180711024459.10654-7-ebiederm@xmission.com>
        <20180716125144.GA18262@redhat.com> <8736wjtetv.fsf@xmission.com>
        <CA+55aFx5gP+1coJ92v4jYgTVfatnOoN3mqrerPEGxadZE2rKNg@mail.gmail.com>
Date:   Fri, 20 Jul 2018 18:27:19 -0500
In-Reply-To: <CA+55aFx5gP+1coJ92v4jYgTVfatnOoN3mqrerPEGxadZE2rKNg@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 17 Jul 2018 09:38:44 -0700")
Message-ID: <87zhyl7ajs.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fgeo4-0001zI-F3;;;mid=<87zhyl7ajs.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+zSSjScMUfRwAtKzm5w9AudyNGTXrq84c=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 07/11] signal: Deliver group signals via PIDTYPE_TGID not PIDTYPE_PID
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jul 16, 2018 at 7:50 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> In practice since glibc does not make thread id's available I don't
>> expect anyone relies on this behavior.  Since no one relies on it we
>> can change it without creating a regression.
>
> Actually, there's a really obvious case where this simply isn't true.
>
> Just imagine you're a MIS person or a developer, doing "ps -eLf" to
> see what's going on, and want to kill one thread. Either because you
> see that one thread using all CPU, or because you are the developer
> and you know what's up.
>
> Those thread ID's are exported trivially.

True.  Which makes all of this shell script visible.  So someone may
have done something with this functionality.

I have just gone through all of my patches and updated them to ensure
that everything has the same behavior when selecting processes as it does
today.  So this will not be an issue with the next version this patch series.



I am going to come back to this as there are some really nasty corner
cases in the current kernel.  Primarily that we can send signals through
a zombie thread group leader and it can have unchangable credentials
completely out of sync with the credentials on the other threads.

Eric










