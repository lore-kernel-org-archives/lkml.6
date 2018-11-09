Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52965C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B27020855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B27020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeKIRvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:51:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeKIRvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:51:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45B129981B;
        Fri,  9 Nov 2018 08:11:45 +0000 (UTC)
Received: from krava (unknown [10.40.205.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5902319492;
        Fri,  9 Nov 2018 08:11:43 +0000 (UTC)
Date:   Fri, 9 Nov 2018 09:11:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     leo.yan@linaro.org
Cc:     acme@redhat.com, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Question: perf dso support for /proc/kallsyms
Message-ID: <20181109081142.GH29732@krava>
References: <20181102025516.GA25374@leoy-ThinkPad-X240s>
 <20181107141006.GD12870@krava>
 <20181108085152.GA1925@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108085152.GA1925@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 09 Nov 2018 08:11:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 04:51:52PM +0800, leo.yan@linaro.org wrote:
> Hi Jiri,
> 
> On Wed, Nov 07, 2018 at 03:10:06PM +0100, Jiri Olsa wrote:
> > On Fri, Nov 02, 2018 at 10:55:16AM +0800, leo.yan@linaro.org wrote:
> > > Hi all,
> > > 
> > > Now I found that if use the command 'perf script' for Arm CoreSight trace
> > > data, it fails to parse kernel symbols if we don't specify kernel vmlinux
> > > file.   So when we don't specify kernel symbol files then perf tool will
> > > roll back to use /proc/kallsyms for kernel symbols parsing, as result it will
> > > run into below flow:
> > 
> > yep, AFAIK if there's no vmlinux found we fallback to /proc/kallsyms
> > 
> > > 
> > >   thread__find_addr_map(thread, cpumode, MAP__FUNCTION, address, &al);
> > >   map__load(al.map);
> > >   dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
> > >     `-> data_read_offset()
> > 
> > so what is the actual error you see in the perf script?
> > unresolved samples? could you please describe your config
> > and workload?
> 
> So at my side the error is the CoreSight trace decoder fails to
> generate samples if the sample has kernel address, thus the decoder
> doesn't generate any kernel sample if use kallsyms as dso.
> 
> For more detailed info is: the CoreSight decoder needs firstly to get
> dso related info by calling dso__data_read_offset() [1], if we use
> kallsyms then this function always returns failure then this leads the
> docoder to discard all kernel samples.

I haven't checked on this code for some time but AFAICS
before you call dso__data_read_offset you need to check
  dso->data.status != DSO_DATA_STATUS_ERROR

map__load call ahead should take care on setting this and
find the source of the data

check the intel_pt code (intel_pt_walk_next_insn)
or for example grab_bb in perf script

I guess you need to have either vmlinux or kcore in place
to get some data out of it

jirka
