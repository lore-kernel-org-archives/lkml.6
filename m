Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767F52085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767F52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeKGXkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:40:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbeKGXkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:40:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F5FD31256B1;
        Wed,  7 Nov 2018 14:10:11 +0000 (UTC)
Received: from krava (unknown [10.40.205.37])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32451662F3;
        Wed,  7 Nov 2018 14:10:07 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:10:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     leo.yan@linaro.org
Cc:     acme@redhat.com, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Question: perf dso support for /proc/kallsyms
Message-ID: <20181107141006.GD12870@krava>
References: <20181102025516.GA25374@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102025516.GA25374@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 07 Nov 2018 14:10:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:55:16AM +0800, leo.yan@linaro.org wrote:
> Hi all,
> 
> Now I found that if use the command 'perf script' for Arm CoreSight trace
> data, it fails to parse kernel symbols if we don't specify kernel vmlinux
> file.   So when we don't specify kernel symbol files then perf tool will
> roll back to use /proc/kallsyms for kernel symbols parsing, as result it will
> run into below flow:

yep, AFAIK if there's no vmlinux found we fallback to /proc/kallsyms

> 
>   thread__find_addr_map(thread, cpumode, MAP__FUNCTION, address, &al);
>   map__load(al.map);
>   dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
>     `-> data_read_offset()

so what is the actual error you see in the perf script?
unresolved samples? could you please describe your config
and workload?

thanks,
jirka

> 
> I can observe the function data_read_offset() returns failure, this is caused
> by checking the offset sanity "if (offset > dso->data.file_size)"  (I pasted
> the whole function code at below in case you want to get more context for it),
> but if perf use "/proc/kallsyms" to load kernel symbols, the variable
> 'dso->data.file_size' will be set to zero thus the sanity checking always
> thinks the offset is out of the file size bound.
> 
> Now I still don't understand how the dso/map support "/proc/kallsyms" and
> have no idea to fix this issue, though I spent some time to look into it.
> 
> Could you give some suggestion for this?  Or even better if you have fixing
> for this, I am glad to test at my side.
> 
> static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
>                                 u64 offset, u8 *data, ssize_t size)
> {
>         if (data_file_size(dso, machine))
>                 return -1;
> 
>         /* Check the offset sanity. */
>         if (offset > dso->data.file_size)
>                 return -1;
> 
>         if (offset + size < offset)
>                 return -1;
> 
>         return cached_read(dso, machine, offset, data, size);
> }
> 
> Thanks,
> Leo Yan
