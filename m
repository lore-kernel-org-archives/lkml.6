Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415761-2-12766365268453779294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415761; b=vSCqkhWOjSDSOfCBN86hqHYhHAgThaaIbAo4y+kXn4NkNDm
    gw+71+xpWW+czPuENRSjdRbMfY06+i9PVgD8Bcy5kiUR8oI/F2A6wsqNua7+WBMG
    /en72J5lpeY10NkqGhCjHWu+j2uOwypWYbKG7IHD7712iziNUPwDm1IFHSBsk3nU
    39bEz9W8VJsMRPg1s8xuAD7Nno7s2EC97DpgjtpFJ6bI3FQatDw30SVs/xPXHOUh
    327fD4Ea/bi6L4RdN4y7N3l4enf72W2w70ODMi8jZsmT7NIuo5FvgI/VGqH9OFsE
    Mg/XnRulDU9QTUNeDp7zi+VA0mfjS8bIIhtWHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415761; bh=R66NDvw82rI3rkNS1j3VwJzt3f
    OKgZV8PCxFUeJVoao=; b=h3rcPOXBTgrZEjyA2FgzFbMnr7oD9X5sr7Yfcsdy2x
    voHaToMde404FU7x6RcYQsQOTvvbthA5eD8Q0BrljSz66DsVrHMel9KpRmcvqAso
    wkFg2r7vLJGVZMhNWx6u6D26Mdrx/ruw9Gk7eWblJW4tV79G28Q+8QJAQrnWa0PR
    zlHEYoqiHBeAov9Z7+2NPH0oeDSTZC4Od3AdmOCpaEWv+F6znCmVuNnw9u8HQlxC
    K54A+FIOPqA++qliDlS/eYyFCc+i7wroQRHbzKpzvWudBFvtF9bialkUbJHWztuZ
    lDgdPpzVpVnlz8U7yvogm2cXsmgyd2eywdILw0yFBtuQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933747AbeBWTzu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:55:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933052AbeBWSo6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 061/145] powerpc/perf: Fix oops when grouping different pmu events
Date: Fri, 23 Feb 2018 19:26:07 +0100
Message-Id: <20180223170732.680009918@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>


[ Upstream commit 5aa04b3eb6fca63d2e9827be656dcadc26d54e11 ]

When user tries to group imc (In-Memory Collections) event with
normal event, (sometime) kernel crashes with following log:

    Faulting instruction address: 0x00000000
    [link register   ] c00000000010ce88 power_check_constraints+0x128/0x980
    ...
    c00000000010e238 power_pmu_event_init+0x268/0x6f0
    c0000000002dc60c perf_try_init_event+0xdc/0x1a0
    c0000000002dce88 perf_event_alloc+0x7b8/0xac0
    c0000000002e92e0 SyS_perf_event_open+0x530/0xda0
    c00000000000b004 system_call+0x38/0xe0

'event_base' field of 'struct hw_perf_event' is used as flags for
normal hw events and used as memory address for imc events. While
grouping these two types of events, collect_events() tries to
interpret imc 'event_base' as a flag, which causes a corruption
resulting in a crash.

Consider only those events which belongs to 'perf_hw_context' in
collect_events().

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-By: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/perf/core-book3s.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1381,7 +1381,7 @@ static int collect_events(struct perf_ev
 	int n = 0;
 	struct perf_event *event;
 
-	if (!is_software_event(group)) {
+	if (group->pmu->task_ctx_nr == perf_hw_context) {
 		if (n >= max_count)
 			return -1;
 		ctrs[n] = group;
@@ -1389,7 +1389,7 @@ static int collect_events(struct perf_ev
 		events[n++] = group->hw.config;
 	}
 	list_for_each_entry(event, &group->sibling_list, group_entry) {
-		if (!is_software_event(event) &&
+		if (event->pmu->task_ctx_nr == perf_hw_context &&
 		    event->state != PERF_EVENT_STATE_OFF) {
 			if (n >= max_count)
 				return -1;
