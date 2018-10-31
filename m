Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2298AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C622081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C622081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeKAAsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:48:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbeKAAsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:48:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E2F285550;
        Wed, 31 Oct 2018 15:49:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id C02EA1001925;
        Wed, 31 Oct 2018 15:49:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 31 Oct 2018 16:49:35 +0100 (CET)
Date:   Wed, 31 Oct 2018 16:49:33 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@canonical.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181031154932.GB21207@redhat.com>
References: <20181029221037.87724-1-dancol@google.com>
 <87bm7a3et9.fsf@xmission.com>
 <20181031124435.GA9007@redhat.com>
 <CAKOZuevTF2cjJ0-nK7nv7jbgFexyW-deScaYVzE3iEPC48SAJg@mail.gmail.com>
 <20181031151007.GA21207@redhat.com>
 <CAKOZues0_jMfW8xAa0mC=QS7UnHMzkWb5nCz3S_GDf3RzPg90Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZues0_jMfW8xAa0mC=QS7UnHMzkWb5nCz3S_GDf3RzPg90Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 31 Oct 2018 15:49:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31, Daniel Colascione wrote:
>
> > Confused... why? kill_ok_by_cred() should fail?
>
> Not if we don't run it. :-) I thought you were proposing that we do
> *all* access checks in open() and let write() succeed unconditionally,

Ah, no ;)

> Anyway, I sent a v2 patch that I think closes the hole another way. In
> v2, we just require that the real user ID that opens a /proc/pid/kill
> file is the same one that writes to it. It successfully blocks the
> setuid attack above while preserving all the write-time permission
> checks and keeping the close correspondence between
> write()-on-proc-pid-kill-fd and kill(2). Can you think of any
> situation where this scheme breaks?

I see no problems...

but again, perhaps we should fix kill_pid_info_as_cred() and use it in
/proc/pid/kill? I dunno.

Oleg.

