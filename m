Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F10C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1FA20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1FA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbeLMMHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:07:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60452 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbeLMMHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:07:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AED25A78;
        Thu, 13 Dec 2018 04:07:32 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E06FA3F575;
        Thu, 13 Dec 2018 04:07:30 -0800 (PST)
Date:   Thu, 13 Dec 2018 12:07:28 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        shankerd@codeaurora.org
Subject: Re: [PATCH 0/6] add system vulnerability sysfs entries
Message-ID: <20181213120726.GB3505@e103592.cambridge.arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206234408.1287689-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:44:02PM -0600, Jeremy Linton wrote:
> Part of this series was originally by Mian Yousaf Kaukab.
> 
> Arm64 machines should be displaying a human readable
> vulnerability status to speculative execution attacks in
> /sys/devices/system/cpu/vulnerabilities 

Is there any agreement on the strings that will be returned in there?

A quick search didn't find anything obvious upstream.  There is
documentation proposed in [1], but I don't know what happened to it and
it doesn't define the mitigation strings at all.  (I didn't follow the
discussion, so there is likely background here I'm not aware of.)

If the mitigation strings are meaningful at all, they really ought to be
documented somewhere since this is ABI.

> This series enables that behavior by providing the expected
> functions. Those functions expose the cpu errata and feature
> states, as well as whether firmware is responding appropriately
> to display the overall machine status. This means that in a
> heterogeneous machine we will only claim the machine is mitigated
> or safe if we are confident all booted cores are safe or
> mitigated. Otherwise, we will display unknown or unsafe
> depending on how much of the machine configuration can
> be assured.

Can the vulnerability status change once we enter userspace?

I see no locking or other concurrency protections, and various global
variables that could be __ro_after_init if nothing will change them
after boot.

If they can change after boot, userspace has no way to be notified,

(I haven't grokked the patches fully, so the answer to this question may
be reasonably straightforward...)


Cheers
---Dave

[1] https://lkml.org/lkml/2018/1/8/145
