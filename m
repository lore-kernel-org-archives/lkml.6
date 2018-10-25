Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D4EECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767CF20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767CF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeJZA72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:59:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeJZA72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:59:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B639B308ED5F;
        Thu, 25 Oct 2018 16:25:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id D4154608F3;
        Thu, 25 Oct 2018 16:25:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Oct 2018 18:25:57 +0200 (CEST)
Date:   Thu, 25 Oct 2018 18:25:54 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181025162554.GG3725@redhat.com>
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com>
 <d11bc954-5a30-e6bd-1668-866a187e0aac@i-love.sakura.ne.jp>
 <20181025155503.GF3725@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025155503.GF3725@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 25 Oct 2018 16:25:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, Oleg Nesterov wrote:
>
> Because our rcu read-lock critical section extends beyond the return from
> synchronize_rcu(), and thus we must have a full memory barrier _between_
> that synchronize_rcu() and our rcu_read_lock(). We must see all memory updates,
> including thread_pid = NULL which makes pid_alive() == F.

In case I was not clear....

Suppose we have int X = 0. If some CPU does

	X = 1;
	synchronize_rcu();

and another CPU does

	rcu_read_lock();
	x = X;
	rcu_read_unlock();

then x should be == 1 in case when rcu_read_unlock() happens _after_ return
from synchronize_rcu().

Oleg.

