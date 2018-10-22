Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D33C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3AA20779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3AA20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJVOZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeJVOZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:25:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F255E85546;
        Mon, 22 Oct 2018 06:08:18 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35B12764D4;
        Mon, 22 Oct 2018 06:08:17 +0000 (UTC)
Date:   Mon, 22 Oct 2018 14:08:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Fan, Chao" <fanc.fnst@cn.fujitsu.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "Indoh, Takao" <indou.takao@fujitsu.com>,
        "Cao, Jin" <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 6/8] x86/boot: Dig out SRAT table from RSDP and find
 immovable memory
Message-ID: <20181022060814.GL1885@192.168.1.4>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-7-fanc.fnst@cn.fujitsu.com>
 <20181021023458.GJ1885@192.168.1.4>
 <B74D54765E346E448CD6C7B7B0334C258D95543F@G08CNEXMBSHAD01.g08.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B74D54765E346E448CD6C7B7B0334C258D95543F@G08CNEXMBSHAD01.g08.fujitsu.local>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 22 Oct 2018 06:08:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 at 05:29am, Fan, Chao wrote:
> On Sun, Oct 21, 2018 at 10:34:58AM +0800, Baoquan He wrote:
> >On 10/17/18 at 06:20pm, Chao Fan wrote:
> >> +	if (!cmdline_find_option_bool("movable_node") ||
> >> +	    cmdline_find_option_arg("acpi", "off", 3))
> >> +		return;
> >> +
> >> +	table_header = get_acpi_srat_table();
> >> +	if (!table_header)
> >> +		return;
> >> +
> >> +	table_end = (unsigned long)table_header + table_header->length;
> >> +
> >> +	table = (struct acpi_subtable_header *)
> >> +		((unsigned long)table_header + sizeof(struct acpi_table_srat));
> >> +
> >> +	while (((unsigned long)table) +
> >> +		       sizeof(struct acpi_subtable_header) < table_end) {
> >> +		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> >> +			ma = (struct acpi_srat_mem_affinity *)table;
> >> +			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
> >> +				immovable_mem[i].start = ma->base_address;
> >> +				immovable_mem[i].size = ma->length;
> >> +				i++;
> >> +			}
> >> +
> >> +			if (i >= MAX_NUMNODES*2)
> >		No warning message printed in this case?
> 
> I will add. BTW, what message is appropriate?
> I can't figure out in what condition, i >= MAX_NUMNODES*2.

Do you mean it's impossible to happen? 
