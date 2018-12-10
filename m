Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531A620851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531A620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeLJRnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:43:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbeLJRnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:43:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2334BC057F9F;
        Mon, 10 Dec 2018 17:43:32 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C3D5D962;
        Mon, 10 Dec 2018 17:43:29 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Cc:     will.deacon@arm.com, catalin.marinas@armm.com,
        mark.rutland@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com
Subject: Re: [PATCH 1/4] arm64: hyperv: Add core Hyper-V include files
In-Reply-To: <20181122031059.16338-1-kys@linuxonhyperv.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com> <20181122031059.16338-1-kys@linuxonhyperv.com>
Date:   Mon, 10 Dec 2018 18:43:27 +0100
Message-ID: <87mupdcm68.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 10 Dec 2018 17:43:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kys@linuxonhyperv.com writes:

> +
> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
> +				       u64 *cur_tsc)
> +{
> +	u64	scale, offset;
> +	u32	sequence;
> +
> +	/*
> +	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> +	 * Top-Level Functional Specification.  To get the reference time we
> +	 * must do the following:
> +	 * - READ ReferenceTscSequence
> +	 *   A special '0' value indicates the time source is unreliable and we
> +	 *   need to use something else.
> +	 * - ReferenceTime =
> +	 *     ((HWclock val) * ReferenceTscScale) >> 64) + ReferenceTscOffset
> +	 * - READ ReferenceTscSequence again. In case its value has changed
> +	 *   since our first reading we need to discard ReferenceTime and repeat
> +	 *   the whole sequence as the hypervisor was updating the page in
> +	 *   between.
> +	 */
> +	do {
> +		sequence = READ_ONCE(tsc_pg->tsc_sequence);

(sorry if this was already discussed before)

Current x86 code doing this actually checks for '0' here (note the
comment about this special value above):

		sequence = READ_ONCE(tsc_pg->tsc_sequence);
		if (!sequence)
			return U64_MAX;

Was it removed intentionally (and we need to fix the comment then)? 

-- 
Vitaly
