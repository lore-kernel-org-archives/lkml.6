Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C900C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7D320821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7D320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeJaNok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:44:40 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47740 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeJaNok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:44:40 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHiQP-00036Z-2M; Tue, 30 Oct 2018 22:48:13 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHiQO-00060O-Ec; Tue, 30 Oct 2018 22:48:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, surenb@google.com
References: <20181029221037.87724-1-dancol@google.com>
        <20181030050012.u43lcvydy6nom3ul@yavin>
Date:   Tue, 30 Oct 2018 23:47:42 -0500
In-Reply-To: <20181030050012.u43lcvydy6nom3ul@yavin> (Aleksa Sarai's message
        of "Tue, 30 Oct 2018 16:00:12 +1100")
Message-ID: <8736sm3eoh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gHiQO-00060O-Ec;;;mid=<8736sm3eoh.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/FZiJnpy7KYFhIbHPkPm2qPZFNP6dh+uI=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> writes:

> On 2018-10-29, Daniel Colascione <dancol@google.com> wrote:
>> Add a simple proc-based kill interface. To use /proc/pid/kill, just
>> write the signal number in base-10 ASCII to the kill file of the
>> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
>> 
>> Semantically, /proc/pid/kill works like kill(2), except that the
>> process ID comes from the proc filesystem context instead of from an
>> explicit system call parameter. This way, it's possible to avoid races
>> between inspecting some aspect of a process and that process's PID
>> being reused for some other process.
>
> (Aside from any UX concerns other folks might have.)
>
> I think it would be a good idea to (at least temporarily) restrict this
> so that only processes that are in the same PID namespace as the /proc
> being resolved through may use this interface. Otherwise you might have
> cases where partial container breakouts can start sending signals to
> PIDs they wouldn't normally be able to address.

No.  That is the container managers job.  If you have the wrong proc
mounted in your container or otherwise allow access to it that is the
fault of the application that set up the container.

The pid namespace limits visibility.  If something becomes visible and
you have permissions over it, it is perfectly reasonable for you to
execute those permissions.

Eric
