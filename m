Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeEDW3D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 18:29:03 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33918 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeEDW3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 18:29:01 -0400
X-Google-Smtp-Source: AB8JxZqrDJ0VA2knGXBQQnvkZvCF+97qcmepDYCBr7VgKr4Zq7yTjsns6hgUv3pI3sd0xtgc728xxQ==
Date: Fri, 4 May 2018 15:28:57 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH bpf-next 09/10] tools: bpftool: add simple perf event
 output reader
Message-ID: <20180504152857.071870b2@cakuba.netronome.com>
In-Reply-To: <20180504212501.hn2rnv7t3ik563mg@ast-mbp>
References: <20180504013717.29317-1-jakub.kicinski@netronome.com>
        <20180504013717.29317-10-jakub.kicinski@netronome.com>
        <20180504212501.hn2rnv7t3ik563mg@ast-mbp>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC perf folks

On Fri, 4 May 2018 14:25:03 -0700, Alexei Starovoitov wrote:
> > +static void
> > +perf_event_read(struct event_ring_info *ring, void **buf, size_t *buf_len)
> > +{
> > +	volatile struct perf_event_mmap_page *header = ring->mem;
> > +	__u64 buffer_size = MMAP_PAGE_CNT * get_page_size();
> > +	__u64 data_tail = header->data_tail;
> > +	__u64 data_head = header->data_head;
> > +	void *base, *begin, *end;
> > +
> > +	asm volatile("" ::: "memory"); /* in real code it should be smp_rmb() */
> > +	if (data_head == data_tail)
> > +		return;  
> 
> this function was copied several times into different places.
> I think it's time to put into common lib. Like libbpf.

Agreed, I think libbpf would work, although there is nothing BPF
specific in this loop AFAICT now.

> Would be great if you can do it in the follow up.

Looking into it now, I found these:

$ git grep 'data_head == data_tail'
tools/bpf/bpftool/map_perf_ring.c:      if (data_head == data_tail)
tools/testing/selftests/bpf/trace_helpers.c:    if (data_head == data_tail)

Are there any other copies I should try to cater to?  I have change a few
things compared to the selftest, I guess others may have modified their
copy too.  Just trying to make sure what we put in libbpf would cater
to most possible use cases.

Should I also move bpf_perf_event_open()/test_bpf_perf_event() to libbpf?

> for the set:
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Thanks!
