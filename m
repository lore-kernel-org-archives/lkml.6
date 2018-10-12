Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50663C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2190F21470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2190F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeJLR4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:56:33 -0400
Received: from albireo.enyo.de ([5.158.152.32]:51670 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJLR4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:56:33 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gAucL-0006Et-Oj; Fri, 12 Oct 2018 10:24:25 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1gAucL-0006zI-Jo; Fri, 12 Oct 2018 12:24:25 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v5 07/27] mm/mmap: Create a guard area between VMAs
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
        <20181011151523.27101-8-yu-cheng.yu@intel.com>
        <20167c74-9b98-6fa1-972e-bcd2c9c4a1c8@linux.intel.com>
Date:   Fri, 12 Oct 2018 12:24:25 +0200
In-Reply-To: <20167c74-9b98-6fa1-972e-bcd2c9c4a1c8@linux.intel.com> (Dave
        Hansen's message of "Thu, 11 Oct 2018 13:49:09 -0700")
Message-ID: <87va67799i.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Hansen:

> On 10/11/2018 08:15 AM, Yu-cheng Yu wrote:
>> Create a guard area between VMAs to detect memory corruption.
>
> This is a pretty major change that has a bunch of end-user implications.
>  It's not dependent on any debugging options and can't be turned on/off
> by individual apps, at runtime, or even at boot.
>
> Its connection to this series is also tenuous and not spelled out in the
> exceptionally terse changelog.

I agree.  We did have application failures due to the introduction of
the stack gap, so this change is likely to cause failures when applied
to existing mappings as well.
