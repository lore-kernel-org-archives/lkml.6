Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79718C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2884922428
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2884922428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHJXQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:16:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbeHJXQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:16:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BBF2738EF;
        Fri, 10 Aug 2018 20:44:52 +0000 (UTC)
Received: from treble (ovpn-122-120.rdu2.redhat.com [10.10.122.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F71D215670D;
        Fri, 10 Aug 2018 20:44:51 +0000 (UTC)
Date:   Fri, 10 Aug 2018 15:44:49 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: reliable stacktraces
Message-ID: <20180810204449.4asgonydn6yfb6kq@treble>
References: <20180810160043.9E45568C76@newverein.lst.de>
 <20180810160311.C988D68CF4@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810160311.C988D68CF4@newverein.lst.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 10 Aug 2018 20:44:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 10 Aug 2018 20:44:52 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 06:03:11PM +0200, Torsten Duwe wrote:
> This is more an RFC in the original sense: is this basically
> the correct approach? (as I had to tweak the API a bit).
> 
> In particular the code does not detect interrupts and exception
> frames, and does not yet check whether the code address is valid.
> The latter check would also have to be omitted for the latest frame
> on other tasks' stacks. This would require some more tweaking.
> 
> unwind_frame() now reports whether we had to stop normally or due to
> an error condition; walk_stackframe() will pass that info.
> __save_stack_trace() is used for a start to check the validity of a
> frame; maybe save_stack_trace_tsk_reliable() will need its own callback.
> 
> Any comments welcome.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

Before we do this we'll need the same analysis we did for ppc64le to
figure out if objtool is needed.

-- 
Josh
