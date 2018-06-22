Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C2DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C991D241A9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C991D241A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeFVMOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:14:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751548AbeFVMOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:14:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A5B0400786A;
        Fri, 22 Jun 2018 12:14:51 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4C1C2026D6B;
        Fri, 22 Jun 2018 12:14:49 +0000 (UTC)
Date:   Fri, 22 Jun 2018 20:14:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 1/2] x86/boot/KASLR: Add two functions for 1GB huge pages
 handling
Message-ID: <20180622121445.GP29979@MiWiFi-R3L-srv>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180516100532.14083-2-bhe@redhat.com>
 <20180621150111.GA23607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621150111.GA23607@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 22 Jun 2018 12:14:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 22 Jun 2018 12:14:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/18 at 05:01pm, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > +/* Store the number of 1GB huge pages which user specified.*/
> > +static unsigned long max_gb_huge_pages;
> > +
> > +static int parse_gb_huge_pages(char *param, char* val)
> > +{
> > +	char *p;
> > +	u64 mem_size;
> > +	static bool gbpage_sz = false;
> > +
> > +	if (!strcmp(param, "hugepagesz")) {
> > +		p = val;
> > +		mem_size = memparse(p, &p);
> > +		if (mem_size == PUD_SIZE) {
> > +			if (gbpage_sz)
> > +				warn("Repeadly set hugeTLB page size of 1G!\n");
> > +			gbpage_sz = true;
> > +		} else
> > +			gbpage_sz = false;
> > +	} else if (!strcmp(param, "hugepages") && gbpage_sz) {
> > +		p = val;
> > +		max_gb_huge_pages = simple_strtoull(p, &p, 0);
> > +		debug_putaddr(max_gb_huge_pages);
> > +	}
> > +}
> 
> This function has at least one style problem and one typo.
> 
> Also, we don't put statics in the middle of function variable blocks.
> 

Sorry, I will check all of them carefully and repost according to your
comments.

> > +/* Skip as many 1GB huge pages as possible in the passed region. */
> > +static void process_gb_huge_page(struct mem_vector *region, unsigned long image_size)
> > +{
> > +	int i = 0;
> > +	unsigned long addr, size;
> > +	struct mem_vector tmp;
> > +
> > +	if (!max_gb_huge_pages) {
> > +		store_slot_info(region, image_size);
> > +		return;
> > +	}
> > +
> > +	addr = ALIGN(region->start, PUD_SIZE);
> > +	/* If Did we raise the address above the passed in memory entry? */
> > +	if (addr < region->start + region->size)
> > +		size = region->size - (addr - region->start);
> > +
> > +	/* Check how many 1GB huge pages can be filtered out*/
> > +	while (size > PUD_SIZE && max_gb_huge_pages) {
> > +		size -= PUD_SIZE;
> > +		max_gb_huge_pages--;
> > +		i++;
> > +	}
> > +
> > +	if (!i) {
> > +		store_slot_info(region, image_size);
> > +		return;
> > +	}
> > +
> > +	/* Process the remaining regions after filtering out. */
> > +
> > +	if (addr >= region->start + image_size) {
> > +		tmp.start = region->start;
> > +		tmp.size = addr - region->start;
> > +		store_slot_info(&tmp, image_size);
> > +	}
> > +
> > +	size  = region->size - (addr - region->start) - i * PUD_SIZE;
> > +        if (size >= image_size) {
> > +		tmp.start = addr + i*PUD_SIZE;
> > +		tmp.size = size;
> > +		store_slot_info(&tmp, image_size);
> > +        }
> > +}
> 
> I counted about 5 style problems and at least one typo in this function ...
> 
> Please review the code you are submitting more carefully for small details as 
> well.
> 
> Thanks,
> 
> 	Ingo
