Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD4920659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfANRJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:09:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32891 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfANRJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:09:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C17E49D432;
        Mon, 14 Jan 2019 17:09:37 +0000 (UTC)
Received: from treble (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B7565D744;
        Mon, 14 Jan 2019 17:09:34 +0000 (UTC)
Date:   Mon, 14 Jan 2019 11:09:32 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Nicolai Stange <nstange@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org,
        Torsten Duwe <duwe@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Kosina <jkosina@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190114170932.awhuv7livfxhrcee@treble>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
 <87bm4ocbbt.fsf@suse.de>
 <20190111010808.GA17858@redhat.com>
 <87fttzbpid.fsf@suse.de>
 <20190114040937.GA6739@redhat.com>
 <877ef7bt6j.fsf@suse.de>
 <20190114164659.GA18643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190114164659.GA18643@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 14 Jan 2019 17:09:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:46:59AM -0500, Joe Lawrence wrote:
> @@ -158,11 +158,21 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
>  			return 1; /* invalid backlink, too far up. */
>  		}
>  
> +		/* We can only trust the bottom frame's backlink, the rest
> +		 * of the frame may be uninitialized, continue to the next. */
> +		if (firstframe--)
> +			goto next;

Won't this decrement firstframe on every iteration, so when firstframe
is 0, it will decrement it to -1, causing it to 'goto next' on all
future iterations?

-- 
Josh
