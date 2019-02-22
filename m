Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B492C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124152086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfBVPW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:22:58 -0500
Received: from www62.your-server.de ([213.133.104.62]:55458 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:22:58 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gxCf7-00060o-9Z; Fri, 22 Feb 2019 16:22:53 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gxCf7-0005kY-1O; Fri, 22 Feb 2019 16:22:53 +0100
Subject: Re: [PATCH bpf v2] bpf, lpm: fix lookup bug in map_delete_elem
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org
Cc:     kafai@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
References: <20190222131908.6207-1-alban@kinvolk.io>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3ee7ff6a-116b-efea-bf81-045b882f28d1@iogearbox.net>
Date:   Fri, 22 Feb 2019 16:22:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190222131908.6207-1-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25368/Fri Feb 22 11:32:58 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2019 02:19 PM, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> trie_delete_elem() was deleting an entry even though it was not matching
> if the prefixlen was correct. This patch adds a check on matchlen.
> 
> Reproducer:
> 
> $ sudo bpftool map create /sys/fs/bpf/mylpm type lpm_trie key 8 value 1 entries 128 name mylpm flags 1
> $ sudo bpftool map update pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 aa bb cc dd value hex 01
> $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> key: 10 00 00 00 aa bb cc dd  value: 01
> Found 1 element
> $ sudo bpftool map delete pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 ff ff ff ff
> $ echo $?
> 0
> $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> Found 0 elements
> 
> A similar reproducer is added in the selftests.
> 
> Without the patch:
> 
> $ sudo ./tools/testing/selftests/bpf/test_lpm_map
> test_lpm_map: test_lpm_map.c:485: test_lpm_delete: Assertion `bpf_map_delete_elem(map_fd, key) == -1 && errno == ENOENT' failed.
> Aborted
> 
> With the patch: test_lpm_map runs without errors.
> 
> Fixes: e454cf595853 ("bpf: Implement map_delete_elem for BPF_MAP_TYPE_LPM_TRIE")
> Cc: Craig Gallek <kraig@google.com>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>

Applied, thanks!
