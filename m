Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AE6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C0F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C0F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbeKTKLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:11:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbeKTKLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:11:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB472C074EFC;
        Mon, 19 Nov 2018 23:45:29 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54A7561B8D;
        Mon, 19 Nov 2018 23:45:29 +0000 (UTC)
Date:   Mon, 19 Nov 2018 18:45:28 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
Message-ID: <20181119234528.GJ29258@redhat.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
 <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
 <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1811182358370.21108@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1811191433100.1537@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1811191438290.21108@cbobk.fhfr.pm>
 <20181119193253.GE29258@redhat.com>
 <4d102977-f516-e0b3-b728-e318e36c1449@intel.com>
 <20181119231649.GI29258@redhat.com>
 <f420095a-e4a7-6483-e250-0eca535905c2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f420095a-e4a7-6483-e250-0eca535905c2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 19 Nov 2018 23:45:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 03:25:41PM -0800, Dave Hansen wrote:
> On 11/19/18 3:16 PM, Andrea Arcangeli wrote:
> > So you may want to ask why it wasn't written as your "any" vs "any" email:
> 
> Presumably because the authors really and truly meant what they said.  I
> was not being as careful in my wording as they were.  :)
> 
> There is nothing in the spec that says that STIBP disables branch
> prediction itself, or that it keeps a thread from influencing *itself*.

Just in case, another thing come to mind, what about mistraining the
BTB with STIBP set inside the SECCOMP jail and then going to sleep or
being migrated by the scheduler to another core which clears STIBP on
the core? Can the mistraining happened inside the SECCOMP jail with
STIBP set influence the code outside SECCOMP after STIBP is cleared?
