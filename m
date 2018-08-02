Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E04C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E92214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E92214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeHBKnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:43:16 -0400
Received: from www62.your-server.de ([213.133.104.62]:46847 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeHBKnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:43:16 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fl9Lz-0000K5-O6; Thu, 02 Aug 2018 10:53:03 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fl9Lz-0001cA-Fq; Thu, 02 Aug 2018 10:53:03 +0200
Subject: Re: [PATCH v6 bpf-next 00/14] bpf: cgroup local storage
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
References: <20180801223740.11252-1-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <682e9adf-5826-d590-1c26-d536814bb566@iogearbox.net>
Date:   Thu, 2 Aug 2018 10:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180801223740.11252-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24804/Thu Aug  2 02:43:46 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 12:37 AM, Roman Gushchin wrote:
> This patchset implements cgroup local storage for bpf programs.
> The main idea is to provide a fast accessible memory for storing
> various per-cgroup data, e.g. number of transmitted packets.
> 
> Cgroup local storage looks as a special type of map for userspace,
> and is accessible using generic bpf maps API for reading and
> updating of the data. The (cgroup inode id, attachment type) pair
> is used as a map key.
> 
> A user can't create new entries or destroy existing entries;
> it happens automatically when a user attaches/detaches a bpf program
> to a cgroup.
> 
> From a bpf program's point of view, cgroup storage is accessible
> without lookup using the special get_local_storage() helper function.
> It takes a map fd as an argument. It always returns a valid pointer
> to the corresponding memory area.
> To implement such a lookup-free access a pointer to the cgroup
> storage is saved for an attachment of a bpf program to a cgroup,
> if required by the program. Before running the program, it's saved
> in a special global per-cpu variable, which is accessible from the
> get_local_storage() helper.
> 
> This patchset implement only cgroup local storage, however the API
> is intentionally made extensible to support other local storage types
> further: e.g. thread local storage, socket local storage, etc.
> 
> Patch (1) adds an ability to charge bpf maps for consuming memory
> dynamically.
> Patch (2) introduces cgroup storage maps.
> Patch (3) implements a mechanism to pass cgroup storage pointer
> to a bpf program.
> Patch (4) implements allocation/releasing of cgroup local storage
> on attaching/detaching of a bpf program to/from a cgroup.
> Patch (5) extends bpf_prog_array to store cgroup storage pointers.
> Patch (6) introduces BPF_PTR_TO_MAP_VALUE, required to skip
> non-necessary NULL-check in bpf programs.
> Patch (7) disables creation of maps of cgroup storage maps.
> Patch (8) introduces the get_local_storage() helper.
> Patch (9) syncs bpf.h to tools/.
> Patch (10) adds cgroup storage maps support to bpftool.
> Patch (11) adds support for testing programs which are using
> cgroup storage without actually attaching them to cgroups.
> Patches (12), (13) and (14) are adding necessary tests.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <kafai@fb.com>
> 
> v6->v5:
>   - fixed an error with returning -EINVAL instead of a pointer
> 
> v5->v4:
>   - fixed an issue in verifier (test that flags == 0 properly)
>   - added a corresponding test
>   - added a note about synchronization, sync docs to tools/uapi/...
>   - switched the cgroup test to use XADD
>   - added a check for attr->max_entries to be 0, and atter->max_flags
>     to be sane
>   - use bpf_uncharge_memlock() in bpf_uncharge_memlock()
>   - rebased to bpf-next
> 
> v4->v3:
>   - fixed a leak in cgroup attachment code (discovered by Daniel)
>   - cgroup storage map will be released if the corresponding
>     bpf program failed to load by any reason
>   - introduced bpf_uncharge_memlock() helper
> 
> v3->v2:
>   - fixed more build and sparse issues
>   - rebased to bpf-next
> 
> v2->v1:
>   - fixed build issues
>   - removed explicit rlimit calls in patch 14
>   - rebased to bpf-next
> 
> Roman Gushchin (14):
>   bpf: add ability to charge bpf maps memory dynamically
>   bpf: introduce cgroup storage maps
>   bpf: pass a pointer to a cgroup storage using pcpu variable
>   bpf: allocate cgroup storage entries on attaching bpf programs
>   bpf: extend bpf_prog_array to store pointers to the cgroup storage
>   bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
>   bpf: don't allow create maps of cgroup local storages
>   bpf: introduce the bpf_get_local_storage() helper function
>   bpf: sync bpf.h to tools/
>   bpftool: add support for CGROUP_STORAGE maps
>   bpf/test_run: support cgroup local storage
>   selftests/bpf: add verifier cgroup storage tests
>   selftests/bpf: add a cgroup storage test
>   samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage

Applied to bpf-next, thanks Roman!
