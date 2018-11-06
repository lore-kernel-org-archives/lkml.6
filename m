Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C2AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B532083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WLJPHzVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B532083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbeKFW2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:28:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbeKFW2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aRKW4wlwG4QS07tI8fk4RLPuTZ5oNk/YVfNKZ1kRldA=; b=WLJPHzVFJkUJWwjet7VF0xwSi
        WqEGnZksiCUfBJ/CMHsiRZnUxOvfdiy4W3zc+LOHPC/KS8o0va1GSMHnKqYqprfiuX6RK5t2wnSsS
        YkdYsXEAacatLLLLdLtpxfAztM36fmcO/gCjj323JuTekeD3VKHUt+zO7fVHZUwrYbZZ7AYl0gNWY
        lVGV1iHL3SQsFlnKalwYpu6wwjKwif4WKFO6+KRc0y3w7NsPXeWGMaHlOrkwSHSsZuT0oci6Z3tPN
        EECEXgSO6AgszzjgxbNglI0WfVDxtOwsZur4wk5hJPUFlQ71wMC/mU/vB3L69PniGlOCQJ/La2eSg
        sxF/yVu2w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK10O-0000CR-Tf; Tue, 06 Nov 2018 13:02:52 +0000
Date:   Tue, 6 Nov 2018 05:02:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH v10 4/4] ipc: Add a cyclic mode for id generation
Message-ID: <20181106130252.GC3074@bombadil.infradead.org>
References: <1541432626-27780-1-git-send-email-longman@redhat.com>
 <1541432626-27780-5-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541432626-27780-5-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 10:43:46AM -0500, Waiman Long wrote:
> The idea of using the cyclic mode to reduce id reuse came from Manfred
> Spraul <manfred@colorfullife.com>. There may be a little bit of
> additional memory/performance overhead in doing cyclic id allocation,
> but it is a slow path anyway and a bit of overhead shouldn't be an issue.
> 
> This patch differs from his as the cyclic mode is not the default and
> has to be explicitly opted in for users who want that.

I really don't like the "make the sysadmin choose" approach.  It's
shifting blame to someone who has no idea what the tradeoffs are.
We should try to get it right rather than force more people to learn
why we're incapable of making the right decision for them.

