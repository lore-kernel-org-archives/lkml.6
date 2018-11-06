Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15706C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB41206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB41206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeKGGKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:10:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbeKGGKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:10:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C97DF31256A4;
        Tue,  6 Nov 2018 20:42:58 +0000 (UTC)
Received: from krava (unknown [10.40.205.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id CE930600C0;
        Tue,  6 Nov 2018 20:42:56 +0000 (UTC)
Date:   Tue, 6 Nov 2018 21:42:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181106204255.GB25020@krava>
References: <20181105203447.GA25674@krava>
 <20181105.194542.476367332910923203.davem@davemloft.net>
 <20181105.200321.1569039579935458312.davem@davemloft.net>
 <20181105.205342.1568518551892125916.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105.205342.1568518551892125916.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 06 Nov 2018 20:42:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 08:53:42PM -0800, David Miller wrote:
> 
> Jiri,
> 
> Because you now run queued_events__queue() lockless with that condvar
> trick, it is possible for top->qe.in to be seen as one past the data[]
> array, this is because the rotate_queues() code goes:
> 
> 	if (++top->qe.in > &top->qe.data[1])
> 		top->qe.in = &top->qe.data[0];
> 
> So for a brief moment top->qe.in is out of range and thus
> perf_top__mmap_read_idx() can try to enqueue to top->qe.data[2]
> 
> We can just do:
> 
> 	if (top->qe.in == &top->qe.data[1])
> 		top->qe.in = &top->qe.data[0];
> 	else
> 		top->qe.in = &top->qe.data[1];
> 
> Or, make top->qe.in an index, and simply go:
> 
> 	top->qe.in ^= 1;
> 
> Either way will fix the bug.

I pushed that fix in perf/fixes branch, but I'm still occasionaly
hitting the namespace crash.. working on it ;-)

[root@krava perf]# ./perf top -d 1 -g
perf: Segmentation fault
-------- backtrace --------
./perf[0x5956aa]
/lib64/libc.so.6(+0x36f2f)[0x7f99d05d3f2f]
/lib64/libc.so.6(+0x15ce60)[0x7f99d06f9e60]
./perf(namespaces__new+0x5a)[0x4fdeaa]
./perf(thread__set_namespaces+0x55)[0x4ff335]
./perf(machine__process_namespaces_event+0xa5)[0x4f1c95]
./perf[0x44c78b]
./perf(queued_events__flush+0xcd)[0x4fd46d]
./perf[0x44c25b]
/lib64/libpthread.so.0(+0x7593)[0x7f99d2928593]
/lib64/libc.so.6(clone+0x3e)[0x7f99d0696e6e]

jirka
