Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1DCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640F3213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640F3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeK3Crg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:47:36 -0500
Received: from nov-007-i650.relay.mailchannels.net ([46.232.183.204]:41163
        "EHLO nov-007-i650.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728363AbeK3Crg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:47:36 -0500
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CAB052EC0015;
        Thu, 29 Nov 2018 15:41:44 +0000 (UTC)
Received: from srv17.tophost.ch (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTPA id 529D42EC0021;
        Thu, 29 Nov 2018 15:41:41 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Thu, 29 Nov 2018 15:41:44 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Quick-Industry: 72ad060b459b633a_1543506104574_420126914
X-MC-Loop-Signature: 1543506104574:355923777
X-MC-Ingress-Time: 1543506104573
Received: from [148.252.241.226] (port=55628 helo=jx1y.guest.codethink.co.uk)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1gSORf-00Gxrx-8y; Thu, 29 Nov 2018 16:41:39 +0100
Message-ID: <f55261dbc41544363b4348820f67fb01c6d7aaec.camel@bitron.ch>
Subject: Re: [PATCH] prctl: add PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Nov 2018 15:41:38 +0000
In-Reply-To: <20181129123409.GA10645@redhat.com>
References: <20181127225408.7553-1-j@bitron.ch>
         <20181127225408.7553-2-j@bitron.ch> <20181128144230.GG30395@redhat.com>
         <87r2f5gr9g.fsf@xmission.com> <20181129123409.GA10645@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

Thanks for the review.

On Thu, 2018-11-29 at 13:34 +0100, Oleg Nesterov wrote:
> To me it would be more clean to call walk_process_tree(kill_descendant_visitor)
> unconditionally in find_new_reaper() right before "if (has_child_subreaper)", but
> then we will need to shift read_lock(tasklist) from walk_process_tree().

Yes, that's the reason why I added the call before the tasklist lock.
Let me know if you want me to move the read lock from
walk_process_tree() to PR_SET_CHILD_SUBREAPER (the only caller)
instead.

> So I think the patch is mostly fine, the only problem I can see is that
> PR_SET_KILL_DESCENDANTS_ON_EXIT can race with PR_SET_CHILD_SUBREAPER, they both
> need to update the bits in the same word.

Good point. I'll make it a regular bool instead of a bitfield for v2,
unless you have another approach in mind to fix this.

Jürg

