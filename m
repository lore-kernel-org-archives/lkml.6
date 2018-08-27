Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA182C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9183521531
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9183521531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeH0Gw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:52:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbeH0Gw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9ACD4021CC3;
        Mon, 27 Aug 2018 03:07:46 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 035652166B41;
        Mon, 27 Aug 2018 03:07:45 +0000 (UTC)
Date:   Mon, 27 Aug 2018 11:07:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, n-horiguchi@ah.jp.nec.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH v5 3/4] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20180827030742.GA11545@192.168.1.2>
References: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
 <20180807065000.30958-4-fanc.fnst@cn.fujitsu.com>
 <20180827021349.GR29313@MiWiFi-R3L-srv>
 <20180827025611.GC6769@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827025611.GC6769@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 03:07:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 03:07:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/18 at 10:56am, Chao Fan wrote:

> >> +#ifdef CONFIG_MEMORY_HOTREMOVE
> >> +/*
> >> + * According to ACPI table, filter the immvoable memory regions
> >> + * and store them in immovable_mem[].
> >> + */
> >> +static void handle_immovable_mem(void)
> >
> >Can we change this function like below, passed in the immovable_mem and
> >the array lengty, the value of num_immovable_mem will be passed back?
> >
> >static void handle_immovable_mem(char* region, int max, int *num)
> >{
> >}
> >
> >Like this, you don't need patch 1/4 to make a header file, just put this
> >function handle_immovable_mem() into acpitb.c since it's handling acpi
> >tables. And its name can be get_immovable_mem().
> 
> That makes sense.
> But if we change like this, we can put the whole function to acpitb.c.
> It will be like:
> static void handle_immovable_mem(int *num)
> {
> }
> Because the value of immovable_mem is filled in handle_immovable_mem,
> it's better to put immovable_mem in acpitb.c also, then extern in
> kaslr.c.

Yes, it's fine to me. Thanks.

> 
> 
