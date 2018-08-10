Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75002C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C202223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C202223FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeHJQwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:52:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:39310 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeHJQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:52:21 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fo8Iu-00052G-Eh; Fri, 10 Aug 2018 16:22:12 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fo8Iu-0007yH-9k; Fri, 10 Aug 2018 16:22:12 +0200
Subject: Re: [BUG] bpf: syscall: a possible sleep-in-atomic-context bug in
 map_update_elem()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, ast@kernel.org
Cc:     netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        brouer@redhat.com
References: <65830741-bf35-4d32-e365-c32fc17c25cb@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <97aa2e6b-1863-f123-af2c-24a2e6333ba5@iogearbox.net>
Date:   Fri, 10 Aug 2018 16:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <65830741-bf35-4d32-e365-c32fc17c25cb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24829/Fri Aug 10 10:43:38 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2018 04:07 PM, Jia-Ju Bai wrote:
> The kernel may sleep with holding a rcu read lock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] kmalloc(GFP_KERNEL)
> kernel/kthread.c, 283: kmalloc in __kthread_create_on_node
> kernel/kthread.c, 365: __kthread_create_on_node in kthread_create_on_node
> kernel/bpf/cpumap.c, 368: kthread_create_on_node in __cpu_map_entry_alloc
> kernel/bpf/cpumap.c, 490: __cpu_map_entry_alloc in cpu_map_update_elem
> kernel/bpf/syscall.c, 724: [FUNC_PTR]cpu_map_update_elem in map_update_elem
> kernel/bpf/syscall.c, 723: rcu_read_lock in map_update_elem
> 
> Note that [FUNC_PTR] means a function pointer call is used.
> 
> I do not find a good way to fix it, so I only report.
> This is found by my static analysis tool (DSAC).

Thanks for the report Jia-Ju! In the map_update_elem() from syscall
path there's a check map->map_type == BPF_MAP_TYPE_CPUMAP, where we
call the cpumap's map->ops->map_update_elem() while /not/ being under
rcu_read_lock() as in other cases, so looks okay to me. Could you point
out the case for being under rcu_read_lock() more specifically which
the tool found?

Thanks,
Daniel
