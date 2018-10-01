Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC44C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500B82084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500B82084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeJAPwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:52:35 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48251 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbeJAPwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:52:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g6uIr-0003Nx-Pv; Mon, 01 Oct 2018 03:15:45 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g6uIq-0003zv-Cz; Mon, 01 Oct 2018 03:15:45 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrey Vagin <avagin@virtuozzo.com>,
        Dmitry Safonov <dima@arista.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "criu\@openvz.org" <criu@openvz.org>,
        "linux-api\@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kselftest\@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20180919205037.9574-1-dima@arista.com>
        <874lej6nny.fsf@xmission.com>
        <20180924205119.GA14833@outlook.office365.com>
        <874leezh8n.fsf@xmission.com>
        <20180925014150.GA6302@outlook.office365.com>
        <87zhw4rwiq.fsf@xmission.com>
        <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
        <87mus1ftb9.fsf@xmission.com>
        <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de>
Date:   Mon, 01 Oct 2018 11:15:32 +0200
In-Reply-To: <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Fri, 28 Sep 2018 21:32:15 +0200
        (CEST)")
Message-ID: <877ej2xc23.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g6uIq-0003zv-Cz;;;mid=<877ej2xc23.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+lpdnsAg3tLJzTn1LCNtd/EXOpsraF/oc=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Setting monotonic time?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the context of process migration there is a simpler subproblem that I
think it is worth exploring if we can do something about.

For a cluster of machines all running with synchronized
clocks. CLOCK_REALTIME matches. CLOCK_MONOTNIC does not match between
machines.   Not having a matching CLOCK_MONOTONIC prevents successful
process migration between nodes in that cluster.

Would it be possible to allow setting CLOCK_MONOTONIC at the very
beginning of time?  So that all of the nodes in a cluster can be in
sync?

No change in skew just in offset for CLOCK_MONOTONIC.

There are also dragons involved in coordinating things so that
CLOCK_MONOTONIC gets set before CLOCK_MONOTONIC gets used.  So I don't
know if allowing CLOCK_MONOTONIC to be set would be practical but it
seems work exploring all on it's own.

Dmitry would setting CLOCK_MONOTONIC exactly once at boot time solve
your problem that is you are looking at a time namespace to solve?

Eric
