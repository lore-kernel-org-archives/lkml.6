Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B143C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529FC2089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="MvE7nQ/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529FC2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeKKHgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 02:36:32 -0500
Received: from cmta17.telus.net ([209.171.16.90]:59948 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbeKKHgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 02:36:32 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id Lb8kggMNvP96wLb8lgF1Ty; Sat, 10 Nov 2018 14:50:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1541886604; bh=nljIwV993PC2xEIE+TtDDnIfIZAeMYFWn8TzZ8B5Lqw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=MvE7nQ/588h4TMV6mUfgzzXrqr7Xe8+ya5jB85TsUFwJdpWQgEYeLXri9wIs5gJ6a
         /X/Z+4XQzw7ExxI2/wn7JtL2woM/eYwH/X5opv2c6M/8SH15OZ2en7Ep4b0OnuXwmI
         W2N0KPCygFAHpDlN1AuThgtqTyi4RoBdAg0fVq6wLJeDkQoUJnr4+nkhDjHJtelCId
         0NEJVtRY8qXes/aIkLMNoOTaTaDAmbqq8mLq7wdkYczMHFg/ggVbXAOCclGM3WHMwn
         hbSBHWtlmXGdMMNytS3e0MNoG7mA4QKIdmJQyzy2gfNkUBgZ4ldwxInGrrpBWiNnnj
         nl3+fHWCHOaLQ==
X-Authority-Analysis: v=2.3 cv=G5vN7Os5 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=0b2Jf5Z5EBbi8pmtcvsA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: 7Sblgyz0iivID7SbmgCnar
In-Reply-To: 7Sblgyz0iivID7SbmgCnar
Subject: RE: [PATCH] cpuidle: poll_state: Revise loop termination condition
Date:   Sat, 10 Nov 2018 13:50:01 -0800
Message-ID: <001101d4793f$56535770$02fa0650$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdRaml4NAyS4Rm5GQJemmq5IMHK6MAebdjDg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfLlkR6KjhRlm8RxY6J7jZ9t39B8Ag8IfTr9blGAKcL78aZXT81ga3oiGQyQRmDrY3qO84e6QHh9/Yqbj/DmkBjkoyIYTreZkQnyM0F1kGvVLkiNU1b5c
 HAAG3k0bXHxBC6vXuuIOrg1afNtKe0B9iVM+lUo7EeOCFG0KHkLcEXlmaFfsEHVdgCp8UO7D/WKcTB/7AMHz0EYAjl2YjYrzbKjlS/nUyXUCOVb7V2elb9J5
 R8MTCOBLYhdpkc1kOGiXHoWSxDj1m5VxOODP0XzJUXXeAGvb2jMC70zPLMclBAjhQXrFSMuChMb9QtLlrjA0tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.10.02 14:51 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If need_resched() returns "false", breaking out of the loop in
> poll_idle() will cause a new idle state to be selected, so in fact
> usually it doesn't make sense to spin in it longer than the target
> residency of the second state.  [Note that the "polling" state is
> used only if there is at least one "real" state defined in addition
> to it.]  On the other hand, breaking out of it early (say in case
> the next state is disabled) shouldn't hurt as it is polling anyway.

While I agree that it is polling anyway, this change can add significant
burden when debugging and trace is enabled for cpu_idle, if idle state 0
is used often.

For example: Phoronix dbench test, 96 clients: 900 second trace:

Kernel 4.20-rc1:
idle state 0 entry exits: 686,724
Does trace being enabled effect the system under test: Yes.

Kernel 4.20-rc1 with this patch reverted:
idle state 0 entry exits: 66,185
Does trace being enabled effect the system under test: No, or minimal.

... Doug


