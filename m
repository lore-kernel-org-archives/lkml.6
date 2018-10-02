Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25BAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E5D20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E5D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeJBW24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:28:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeJBW24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C8473002060;
        Tue,  2 Oct 2018 15:44:56 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06C5A30912F5;
        Tue,  2 Oct 2018 15:44:56 +0000 (UTC)
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A99761809546;
        Tue,  2 Oct 2018 15:44:55 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86/speculation: Provide application property based STIBP protection
Message-Id: <ED92A4DA-E9A3-4AED-90B4-4A912864EACE@redhat.com>
Date:   Tue, 2 Oct 2018 11:44:55 -0400 (EDT)
References: <cover.1537392876.git.tim.c.chen@linux.intel.com> <0c55c162a077aadbfd57878e2694e35292c1a29c.1537392876.git.tim.c.chen@linux.intel.com> <1a501628-a232-a126-166e-814c26243f2d@redhat.com> <nycvar.YFH.7.76.1810021742540.14430@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1810021742540.14430@cbobk.fhfr.pm>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Thread-Topic: x86/speculation: Provide application property based STIBP protection
Thread-Index: E5wQ+zs/XoVUdgtZV5yWEsk5QRcA6A==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 02 Oct 2018 15:44:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quick reply: I agree, I'm just supporting this :)

-- 
Computer Architect


> On Oct 2, 2018, at 11:43, Jiri Kosina <jikos@kernel.org> wrote:
> 
> On Tue, 2 Oct 2018, Jon Masters wrote:
> 
>>> This patch provides an application property based spectre_v2
>>> protection with STIBP against attack from another app from
>>> a sibling hyper-thread.  For security sensitive non-dumpable
>>> app, STIBP will be turned on before switching to it for Intel
>>> processors vulnerable to spectre_v2.
>> 
>> A general comment. I think in practice this will be similar to the
>> speculative store buffer bypass (aka "variant 4") issue in terms of
>> opt-in mitigation. Many users won't want to take the performance hit of
>> having STIBP by default for peer threads. We should make sure that we
>> don't force users into a mitigation but retain an option. Whether it's
>> default-on or not can be debated, though I think the vendors lean toward
>> having default-off with an opt-in, and customers will probably agree. So
>> anyway, I encourage a pragmatic approach similar to that for SSBD.
> 
> Which is what Tim's patchset is implementing on top.
> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
