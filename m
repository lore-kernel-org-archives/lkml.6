Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069A6C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71832089C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71832089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeJVSm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbeJVSm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:42:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BAC83001DB1;
        Mon, 22 Oct 2018 10:25:00 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BC1A5DA2A;
        Mon, 22 Oct 2018 10:24:59 +0000 (UTC)
Date:   Mon, 22 Oct 2018 18:24:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v9 8/8] x86/boot/KASLR: Limit kaslr to choosing the
 immovable memory
Message-ID: <20181022102455.GN1885@192.168.1.4>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-9-fanc.fnst@cn.fujitsu.com>
 <20181018042123.GD1885@192.168.1.4>
 <20181022101329.GC7641@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022101329.GC7641@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 22 Oct 2018 10:25:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 at 06:13pm, Chao Fan wrote:
> >> +static bool process_mem_region(struct mem_vector *region,
> >> +			       unsigned long long minimum,
> >> +			       unsigned long long image_size)
> >> +{
> >> +	int i;
> >> +	/*
> >> +	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
> >> +	 * walk all the regions, so use region directely.
> >> +	 */
> >> +	if (num_immovable_mem == 0) {
> >> +		slots_count(region, minimum, image_size);
> >> +
> >> +		if (slot_area_index == MAX_SLOT_AREA) {
> >> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> >> +			return 1;
> >> +		}
> >> +		return 0;
> >> +	}
> >> +
> >> +#ifdef CONFIG_MEMORY_HOTREMOVE
> >> +	/*
> >> +	 * If immovable memory found, filter the intersection between
> >> +	 * immovable memory and region to slots_count.
> >> +	 * Otherwise, go on old code.
> >
> >Could you explain more about what is the old code in otherwise case you
> >want to go on?
> 
> Sure,
> 1. 'movable_node' not specified in cmdline.
> 2. CONFIG_HOT_REMOVE not difned.
> 3. Just one node in this machine.

So these cases are not covered by 'if (num_immovable_mem == 0)' code?
In thise ifdef code block, where do you handle above three cases?

Thanks
Baoquan
