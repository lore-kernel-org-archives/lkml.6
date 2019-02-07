Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1D5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2551E2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfBGGnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:43:07 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:54613 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfBGGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:43:07 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1grdOh-0005i0-1N; Wed, 06 Feb 2019 23:42:55 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1grdOg-0002CB-81; Wed, 06 Feb 2019 23:42:54 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com>
        <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
        <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
        <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
        <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
        <8736p37xcn.fsf@xmission.com> <878syu7tcm.fsf@xmission.com>
        <87tvhi4vl7.fsf@xmission.com> <87o97q1cky.fsf_-_@xmission.com>
        <20190206180754.GA23476@redhat.com> <87imxwv9jp.fsf@xmission.com>
Date:   Thu, 07 Feb 2019 00:42:45 -0600
In-Reply-To: <87imxwv9jp.fsf@xmission.com> (Eric W. Biederman's message of
        "Wed, 06 Feb 2019 16:25:46 -0600")
Message-ID: <875ztwt7yy.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1grdOg-0002CB-81;;;mid=<875ztwt7yy.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18YobxIdNpLTtxVIqHco+MGx/48oGMoSKE=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 0/2]: Fixing unkillable processes caused by SIGHUP timers
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dmitry,

Can you please verify the follow two patches.  The first one is a
simplification of the one you have already tested and makes the
processes killable.  The second patch improves our heuristic for
detecting synchronous like SIGSEGV when the stack overflows allowing us
to process them before SIGHUP.

Eric W. Biederman (2):
      signal: Always notice exiting tasks
      signal: Better detection of synchronous signals
