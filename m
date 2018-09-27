Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E202FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE9521571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE9521571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeI1DeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:34:08 -0400
Received: from www62.your-server.de ([213.133.104.62]:37313 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeI1DeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:34:08 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g5dbc-0004nQ-QB; Thu, 27 Sep 2018 23:13:52 +0200
Received: from [178.197.248.15] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g5dbc-000M4u-Kg; Thu, 27 Sep 2018 23:13:52 +0200
Subject: Re: [PATCH v3 bpf-next 00/10] bpf: per-cpu cgroup local storage
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20180926113326.29069-1-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <34e73535-8e95-c7b8-0f1a-acd4a7053c5f@iogearbox.net>
Date:   Thu, 27 Sep 2018 23:13:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180926113326.29069-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24987/Thu Sep 27 18:52:11 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 01:33 PM, Roman Gushchin wrote:
> This patchset implements per-cpu cgroup local storage and provides
> an example how per-cpu and shared cgroup local storage can be used
> for efficient accounting of network traffic.
> 
> v3->v2:
>   1) incorporated Song's feedback
>   2) rebased on top of current bpf-next
> 
> v2->v1:
>   1) added a selftest implementing network counters
>   2) added a missing free() in cgroup local storage selftest
> 
> Roman Gushchin (10):
>   bpf: extend cgroup bpf core to allow multiple cgroup storage types
>   bpf: rework cgroup storage pointer passing
>   bpf: introduce per-cpu cgroup local storage
>   bpf: don't allow create maps of per-cpu cgroup local storages
>   bpf: sync include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h
>   bpftool: add support for PERCPU_CGROUP_STORAGE maps
>   selftests/bpf: add verifier per-cpu cgroup storage tests
>   selftests/bpf: extend the storage test to test per-cpu cgroup storage
>   samples/bpf: extend test_cgrp2_attach2 test to use per-cpu cgroup
>     storage
>   selftests/bpf: cgroup local storage-based network counters
> 
>  include/linux/bpf-cgroup.h                    |  55 ++++--
>  include/linux/bpf.h                           |  12 +-
>  include/linux/bpf_types.h                     |   1 +
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/cgroup.c                           |  74 +++++---
>  kernel/bpf/helpers.c                          |  25 ++-
>  kernel/bpf/local_storage.c                    | 167 +++++++++++++++---
>  kernel/bpf/map_in_map.c                       |   3 +-
>  kernel/bpf/syscall.c                          |  20 ++-
>  kernel/bpf/verifier.c                         |  23 ++-
>  net/bpf/test_run.c                            |  20 ++-
>  samples/bpf/test_cgrp2_attach2.c              |  19 +-
>  tools/bpf/bpftool/map.c                       |   4 +-
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/testing/selftests/bpf/Makefile          |   6 +-
>  tools/testing/selftests/bpf/netcnt_common.h   |  23 +++
>  tools/testing/selftests/bpf/netcnt_prog.c     |  71 ++++++++
>  .../selftests/bpf/test_cgroup_storage.c       |  60 ++++++-
>  tools/testing/selftests/bpf/test_netcnt.c     | 153 ++++++++++++++++
>  tools/testing/selftests/bpf/test_verifier.c   | 139 ++++++++++++++-
>  20 files changed, 778 insertions(+), 99 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/netcnt_common.h
>  create mode 100644 tools/testing/selftests/bpf/netcnt_prog.c
>  create mode 100644 tools/testing/selftests/bpf/test_netcnt.c
> 

Applied to bpf-next, thanks Roman!
