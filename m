Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CD1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A263821722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A263821722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeH0Kqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:46:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbeH0Kqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:46:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29B6240216EB;
        Mon, 27 Aug 2018 07:01:14 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB182A9E60;
        Mon, 27 Aug 2018 07:01:12 +0000 (UTC)
Date:   Mon, 27 Aug 2018 15:01:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, n-horiguchi@ah.jp.nec.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH v5 4/4] x86/boot/KASLR: Limit kaslr to choosing the
 immovable memory
Message-ID: <20180827070109.GD1748@MiWiFi-R3L-srv>
References: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
 <20180807065000.30958-5-fanc.fnst@cn.fujitsu.com>
 <20180827055607.GB1748@MiWiFi-R3L-srv>
 <20180827062854.GD6769@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827062854.GD6769@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 27 Aug 2018 07:01:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 27 Aug 2018 07:01:14 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/18 at 02:28pm, Chao Fan wrote:
> >Is it possible to take num_immovable_mem definition out from #ifdef
> >CONFIG_MEMORY_HOTREMOVE block and check it here like below? This way,
> >one level of indentation can be reduced in the for loop, and code is
> >more readable.
> >
> 
> I think there is a mistake.
> 
> The logical is:
> if (#ifdef CONFIG_MEMORY_HOTREMOVE) && (num_immovable_mem > 0)
> 	then A;
> else
> 	then B;
> 
> But below is:
> if (num_immovable_mem > 0)
> 	then B;
> else if (#ifdef CONFIG_MEMORY_HOTREMOVE)
> 	then A;
> else
> 	nothing;
> 
> The precondition of the loop is (num_immovable_mem > 0), because
> there is only one condition that we need go the A code:
> CONFIG_MEMORY_HOTREMOVE is defined, and memory information in srat
> found.


Yes, we are saying the same thing. if num_immovable_mem == 0, it covers
all the cases you listed at below. Here I assume you have taken
num_immovable_mem definition out.

#ifdef CONFIG_MEMORY_HOTREMOVE
/* Store the immovable memory regions */
static struct mem_vector immovable_mem[MAX_NUMNODES*2];
#endif

/* Store the amount of immovable memory regions */
static int num_immovable_mem;

> 
> But there is many conditions we go the B code:
> 1. CONFIG_MEMORY_HOTREMOVE is not defined.
> 2. CONFIG_MEMORY_HOTREMOVE defined, but we didn't get the right acpi tables
> 3. CONFIG_MEMORY_HOTREMOVE defined, or there is only one node in this machine.
> 
> Yes, the code is hard to read, but you have changed the logical, there
> is a compromise method, I don't know whether is better:
> 
> #ifdef CONFIG_MEMORY_HOTREMOVE
> 	if (num_immovable_mem == 0)
> 		goto B;
> 
> 	for (i = 0; i < num_immovable_mem; i++) {
> 		...
> 	}
> #endif
> 
> B:
> 	slots_count(region, minimum, image_size);
> 	
> 	if (slot_area_index == MAX_SLOT_AREA) {
> 		debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> 		return 1;
> 	}
> 	return 0;
> 	
> 
> >
> >static bool process_mem_region(struct mem_vector *region,
> >			       unsigned long long minimum,
> >			       unsigned long long image_size)
> >{
> >
> >	/*
> >	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
> >	 * walk all the regions, so use region directely.
> >	 */
> >	if (num_immovable_mem > 0) {
> >		slots_count(region, minimum, image_size);
> >		
> >		if (slot_area_index == MAX_SLOT_AREA) {
> >			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> >			return 1;
> >		}
> >		return 0;
> >	}
> >
> >#ifdef CONFIG_MEMORY_HOTREMOVE
> >	for (i = 0; i < num_immovable_mem; i++) {
> >		...
> >	}
> >#endif
> >}
> >
> 
> 
