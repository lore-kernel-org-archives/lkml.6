Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7579C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800F92081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800F92081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeLGQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:06:40 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:54126 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbeLGQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:06:39 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 414EFB40057;
        Fri,  7 Dec 2018 16:06:38 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Dec 2018 08:06:34 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: Re: [PATCH v2 0/4] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
References: <cover.1543200841.git.jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Message-ID: <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
Date:   Fri, 7 Dec 2018 16:06:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <cover.1543200841.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24268.005
X-TM-AS-Result: No-4.672000-4.000000-10
X-TMASE-MatchedRID: VfovoVrt/oYDJrf2+hNOhVPjo7D4SFg47f6JAS2hKPjFJnEpmt9OE2WW
        d1VBI96H+QvemMQMGWw/D4CGpgn7NR+GMJJQ53gz3fn7n/ZHGqZ/aDoolm3GXUYvSDWdWaRhdnl
        a+4sEPupjq1QXe0nVE2/bkgMClkivkUIGI5Jp9O6PYUYzX2Xjl1AI6wCVrE3vYDnBmMnH0bAG42
        yGukqJh7C1ePQuNeNe0RugigfesRTxoV3DFZL29RHRbGr1ECgHJPS3/6nvMcdDilB45O77xRk5K
        K4/zwVM94kvTNM1tWcH4jvnDtS/yk1+zyfzlN7ygxsfzkNRlfLdB/CxWTRRu+rAZ8KTspSzseDy
        ISflYBoMcOhAxODlIZcjbN19J10h+ZrTzn8+Y5ZbjM+MPZT/hDDB+c7h/UTREeTjIe2tHYdSqsz
        Zdd/QoLfcZeWoUNRpWswIoFcXV3ojZU2CAxYkI/guCCuaxGC9PA0H4ETs+eV+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.672000-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24268.005
X-MDID: 1544198798-geKmvpATCBck
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this has been pointed out before (it's a very long thread), but
 in the out-of-line implementation, it appears that static_call_update()
 never alters key->func.  Am I right in thinking that this should be
 fixed by adding 'WRITE_ONCE(key->func, func);' just after the call to
 arch_static_call_transform() on line 159 of include/linux/static_call.h?

Some background (why does key->func matter for the
 CONFIG_HAVE_STATIC_CALL_OUTLINE case?): I am experimenting with
 combining these static calls with the 'indirect call wrappers' notion
 that Paolo Abeni has been working on [1], using runtime instrumentation
 to determine a list of potential callees.  (This allows us to cope with
 cases where the callees are in modules, or where different workloads may
 use different sets of callees for a given call site, neither of which is
 handled by Paolo's approach).
The core of my design looks something like:

static int dynamic_call_xyz(int (*func)(some_args), some_args)
{
	if (func == dynamic_call_xyz_1.func)
		return static_call(dynamic_call_xyz_1, some_args);
	if (func == dynamic_call_xyz_2.func)
		return static_call(dynamic_call_xyz_2, some_args);
	return (*func)(some_args);
}

albeit with a bunch of extra (and currently rather ugly) stuff to collect
 the statistics needed to decide what to put in the static call keys, and
 mechanisms (RCU in my current case) to ensure that the static call isn't
 changed between checking its .func and actually calling it.

-Ed

PS: not on list, please keep me in CC.

[1] https://lwn.net/Articles/773985/
