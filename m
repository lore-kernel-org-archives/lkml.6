Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BCFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785FB20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785FB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeLFMp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:45:59 -0500
Received: from nov-007-i657.relay.mailchannels.net ([46.232.183.211]:37472
        "EHLO nov-007-i657.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729069AbeLFMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:45:58 -0500
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9897BBE02DD;
        Thu,  6 Dec 2018 12:45:51 +0000 (UTC)
Received: from srv17.tophost.ch (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTPA id C7472BE0216;
        Thu,  6 Dec 2018 12:45:42 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Thu, 06 Dec 2018 12:45:51 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Imminent-Fearful: 4550cf1558334c97_1544100350449_1137243920
X-MC-Loop-Signature: 1544100350449:922322940
X-MC-Ingress-Time: 1544100350448
Received: from [80.219.231.201] (port=47390 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1gUt2C-00F9ZN-Et; Thu, 06 Dec 2018 13:45:40 +0100
Message-ID: <b0e946bcac12358841c9a99017da819b00794d9c.camel@bitron.ch>
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        serge@hallyn.com, jannh@google.com, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org
Date:   Thu, 06 Dec 2018 13:45:39 +0100
In-Reply-To: <87h8fq7s84.fsf@oldenburg2.str.redhat.com>
References: <20181206121858.12215-1-christian@brauner.io>
         <87h8fq7s84.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 13:30 +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > /* zombies */
> > Zombies can be signaled just as any other process. No special error will be
> > reported since a zombie state is an unreliable state (cf. [3]).
> 
> I still disagree with this analysis.  If I know that the target process
> is still alive, and it is not, this is a persistent error condition
> which can be reliably reported.  Given that someone might send SIGKILL
> to the process behind my back, detecting this error condition could be
> useful.

As I understand it, kill() behaves the same way. I think it's good that
this new syscall keeps the behavior as close as possible to kill().
E.g., this would allow emulating kill() (or a higher level API
equivalent) on top of taskfds without subtle differences in behavior.

As the new syscall supports flags, we could consider introducing a flag
that changes the behavior in the zombie case. However, I think that
should be a separate discussion (after merge of the syscall) and the
default behavior makes sense as is.

Jürg

