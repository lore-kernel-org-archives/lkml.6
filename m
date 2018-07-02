Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469E6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057DB24BAA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057DB24BAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeGBMTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:19:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752063AbeGBMTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:19:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B59C77C6A9;
        Mon,  2 Jul 2018 12:18:59 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1AA32026D5B;
        Mon,  2 Jul 2018 12:18:58 +0000 (UTC)
Date:   Mon, 2 Jul 2018 20:18:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        lcapitulino@redhat.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com
Subject: Re: [RFC PATCH 0/4] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory.
Message-ID: <20180702121855.GA2195@MiWiFi-R3L-srv>
References: <20180612081051.21811-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612081051.21811-1-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 12:18:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 12:18:59 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 06/12/18 at 04:10pm, Chao Fan wrote:
> *** Issues need be discussed
> There are several issues I am not quite sure, please help review and
> give suggestions:
> 
> 1) In PATCH 1, I copy the structures and functions from ACPI head file,
>    so that ACPI head file will never been used here. I am not sure
>    whether it's good to include ACPI head file or use the method in
>    PATCH 1. If people think we can use ACPI head files directely, I
>    will remove the PATCH 1.

Usaully we try to reuse code even though they are located in different
life space. I think it applies to this SRAT handling. Copying ACPI codes
to kernel decompressing looks messy. Is there better way to reuse ACPI
code and read SRAT table, then get what we need in a simple way?

Thanks
Baoquan
> 
> ***Test results:
>  - I did a very simple test, and it can get the memory information in
>    bios and efi KVM guest machine, and put it by early printk. But no
>    more tests, so it's with RFC tag.
> 
> Any comments will be welcome.
> 
> 
> Chao Fan (4):
>   x86/boot: Add acpitb.h to help parse acpi tables
>   x86/boot: Add acpitb.c to parse acpi tables
>   x86/boot/KASLR: Walk srat tables to filter immovable memory
>   x86/boot/KASLR: Limit kaslr to choosing the immovable memory
> 
>  arch/x86/boot/compressed/Makefile |   1 +
>  arch/x86/boot/compressed/acpitb.c | 245 ++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/acpitb.h | 175 +++++++++++++++++++++
>  arch/x86/boot/compressed/kaslr.c  | 120 +++++++++++++--
>  4 files changed, 530 insertions(+), 11 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/acpitb.c
>  create mode 100644 arch/x86/boot/compressed/acpitb.h
> 
> -- 
> 2.17.0
> 
> 
> 
