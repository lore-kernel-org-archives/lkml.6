Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB4EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4BC21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4BC21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbeKOAkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:40:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbeKOAkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:40:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F38988E59F;
        Wed, 14 Nov 2018 14:37:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 098A95D75C;
        Wed, 14 Nov 2018 14:37:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Nov 2018 15:37:10 +0100 (CET)
Date:   Wed, 14 Nov 2018 15:37:06 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chanho Min <chanho.min@lge.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        'Pavel Machek' <pavel@ucw.cz>,
        'Len Brown' <len.brown@intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Eric W. Biederman'" <ebiederm@xmission.com>,
        'Christian Brauner' <christian@brauner.io>,
        'Anna-Maria Gleixner' <anna-maria@linutronix.de>,
        'Alexander Viro' <viro@zeniv.linux.org.uk>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        'Seungho Park' <seungho1.park@lge.com>,
        'Inkyu Hwang' <inkyu.hwang@lge.com>,
        'Donghwan Jung' <donghwan.jung@lge.com>,
        'Jongsung Kim' <neidhard.kim@lge.com>
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Message-ID: <20181114143705.GB13885@redhat.com>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
 <20181113145339.GD16182@dhcp22.suse.cz>
 <20181113161858.GE30990@redhat.com>
 <20181113180058.GT15120@dhcp22.suse.cz>
 <014a01d47c03$6b64eef0$422eccd0$@lge.com>
 <20181114103014.GN23419@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114103014.GN23419@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 14 Nov 2018 14:37:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14, Michal Hocko wrote:
>
> > I don't understand why it isn't appropriate for exec to block. The
> > exec can freeze. When tasks are thawed, the killed sub-thread will die
> > and wake de_thread(). The exec will continue to work from resume.
>
> Because this is fragile.

I don't really agree, but...

> I haven't checked the full set of resources the
> task holds when in this path but I can imagine we can introduce lock
> dependency on freezing really easily.

And you are right, see another email I sent you a minute ago.

But again, we need to change de_thread to sleep without cred_guard_mutex
anyway, so I think this change is fine. At least in that it can't add the
new problems.

Oleg.

