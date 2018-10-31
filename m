Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7FBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7125E205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7125E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeKAAIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbeKAAIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:08:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29BBA330788;
        Wed, 31 Oct 2018 15:10:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7AB5365918;
        Wed, 31 Oct 2018 15:10:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 31 Oct 2018 16:10:10 +0100 (CET)
Date:   Wed, 31 Oct 2018 16:10:07 +0100
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
Message-ID: <20181031151007.GA21207@redhat.com>
References: <20181029221037.87724-1-dancol@google.com>
 <87bm7a3et9.fsf@xmission.com>
 <20181031124435.GA9007@redhat.com>
 <CAKOZuevTF2cjJ0-nK7nv7jbgFexyW-deScaYVzE3iEPC48SAJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevTF2cjJ0-nK7nv7jbgFexyW-deScaYVzE3iEPC48SAJg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 31 Oct 2018 15:10:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31, Daniel Colascione wrote:
>
> > perhaps it would be simpler to do
> >
> >         my_cred = override_creds(file->f_cred);
> >         kill_pid(...);
> >         revert_creds(my_cred);
>
> Thanks for the suggestion. That looks neat, but it's not quite enough.
> The problem is that check_kill_permission looks for
> same_thread_group(current, t) _before_ checking kill_of_by_cred,

Yes, you are right.

Looks like kill_pid_info_as_cred() can find another user, but probably
it needs some changes with or without /proc/pid/kill ...

> There's another problem though: say we open /proc/pid/5/kill *, with
> proc 5 being an ordinary unprivileged process, e.g., the shell. At
> open(2) time, the access check passes. Now suppose PID 5 execve(2)s
> into a setuid process. The kill FD is still open, so the kill FD's
> holder can send a signal

Confused... why? kill_ok_by_cred() should fail?

Oleg.

