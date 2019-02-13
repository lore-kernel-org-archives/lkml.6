Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C8A222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550101505;
	bh=Wnc8yA/bMRVMOlaDVr9KHYpXiySYH6At+CYbzsXZbTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qm8/rwR4mKWsutGqslB7KyYXNPDSg0NQT7IrBK1IV7oHDjfMX/mGS3Ac/VwdFdMgg
	 nRSJIW4QHpIi8hq+LB+u0ymeISaaTBvTsykZKOAOTcSJj8A1JkJyMTehYauFWOXeCq
	 QVX0y3h0xztiAeaiAhRWNMbAX0CBshvXl+xg1ejo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393415AbfBMXpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730326AbfBMXpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:45:03 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4672229F;
        Wed, 13 Feb 2019 23:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550101502;
        bh=Wnc8yA/bMRVMOlaDVr9KHYpXiySYH6At+CYbzsXZbTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tNBRJUnoQIUHenUPhIy6T2aGiqPh3lj4WOUkvdClNcvFWAASqa15oKkSakwqpfypK
         NeaPqS7bJ4qXHJfN/sdkRMFKzestciH+X39tZ9dsbHVwaKHfNqBFAesst/dHouAJrS
         +ZkbUq0ZaooA/Jcl1CLo3tmMegHQbTTGcjpaRil4=
Date:   Thu, 14 Feb 2019 08:44:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip v3 05/10] kprobes: Search non-suffixed symbol in
 blacklist
Message-Id: <20190214084458.2b2d89f971201f0f67774461@kernel.org>
In-Reply-To: <20190213071711.GB121801@gmail.com>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
        <154998799234.31052.6136378903570418008.stgit@devbox>
        <20190213071316.GA121801@gmail.com>
        <20190213071711.GB121801@gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 08:17:11 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Newer gcc can generate some different instances of a function
> > > with suffixed symbols if the function is optimized and only
> > > has a part of that. (e.g. .constprop, .part etc.)
> > > 
> > > In this case, it is not enough to check the entry of kprobe
> > > blacklist because it only records non-suffixed symbol address.
> > > 
> > > To fix this issue, search non-suffixed symbol in blacklist if
> > > given address is within a symbol which has a suffix.
> > > 
> > > Note that this can cause false positive cases if a kprobe-safe
> > > function is optimized to suffixed instance and has same name
> > > symbol which is blacklisted.
> > > But I would like to chose a fail-safe design for this issue.
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Why did you not add Steven's Reviewed-by tag?
> 
> The series looks fine otherwise, so I applied it with Steve's reviewed-by 
> tag added.


Oops, sorry! I missed to add that. :-(

Thank you,

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
