Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB7BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684EE20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684EE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeGTIkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:40:24 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:55541 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbeGTIkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:40:23 -0400
Received: from [192.168.0.5] (ip5f5bd29d.dynamic.kabel-deutschland.de [95.91.210.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id DE98E2012BA076;
        Fri, 20 Jul 2018 09:53:21 +0200 (CEST)
To:     Matthew Wilcox <mawilcox@microsoft.com>
Cc:     linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>
Subject: UBSAN: Undefined behaviour in lib/radix-tree.c:123:14: member access
 within null pointer of type 'const struct radix_tree_node'
Message-ID: <19427cc3-3372-9b02-4b92-096fbe328622@molgen.mpg.de>
Date:   Fri, 20 Jul 2018 09:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Enabling the undefined behavior sanitizer and building GNU/Linux 
4.18-rc5+ (with some unrelated commits) with GCC 8.1.0 from Debian 
Sid/unstable, the warning below is shown.

> [    0.958688] ================================================================================
> [    0.959029] UBSAN: Undefined behaviour in lib/radix-tree.c:123:14
> [    0.959212] member access within null pointer of type 'const struct radix_tree_node'
> [    0.959472] CPU: 0 PID: 24 Comm: kworker/0:2 Not tainted 4.18.0-rc5-00316-g4864b68cedf2 #104
> [    0.959475] Hardware name: ASROCK E350M1/E350M1, BIOS TIMELESS 01/01/1970
> [    0.959488] Workqueue: events_power_efficient ioc_release_fn
> [    0.959492] Call Trace:
> [    0.959501]  dump_stack+0x55/0x89
> [    0.959507]  ubsan_epilogue+0xb/0x33
> [    0.959511]  handle_null_ptr_deref+0x7f/0x90
> [    0.959516]  __ubsan_handle_type_mismatch_v1+0x55/0x60
> [    0.959521]  __radix_tree_delete+0xc5/0xe0
> [    0.959525]  radix_tree_delete_item+0x5f/0xf0
> [    0.959529]  radix_tree_delete+0xa/0x10
> [    0.959532]  ioc_destroy_icq+0x58/0x1f0
> [    0.959538]  ? free_tty_struct+0x34/0x50
> [    0.959541]  ioc_release_fn+0x9c/0x1a0
> [    0.959548]  process_one_work+0x220/0x700
> [    0.959553]  worker_thread+0x5a/0x690
> [    0.959557]  kthread+0x14e/0x200
> [    0.959561]  ? drain_workqueue+0x290/0x290
> [    0.959565]  ? kthread_create_worker_on_cpu+0x30/0x30
> [    0.959568]  ret_from_fork+0x1c/0x38
> [    0.959572] ================================================================================


Kind regards,

Paul
