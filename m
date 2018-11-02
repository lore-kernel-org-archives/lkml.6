Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BBBC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1838C20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAd4rzD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1838C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeKBXui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:50:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33284 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbeKBXuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:50:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id u1-v6so2263181wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EATOK+D1E4pT4vtpuefWXxG2d47bm74t8G59fXHqXA8=;
        b=jAd4rzD4kWkSXOeJwr2tjkefOxiYZl07tWonndWkiVox8z6dtsAxhVxp6ieNU/D8Yz
         Ez4B8xEzxDIYM7m79vo4Ko0VPiwJqoDODAbDTdQbTCQ1hwhV2B0SFU/YPn1W5gwjZQo6
         UulqmZ3OmAO+NeQlLXABW/EktV9nb7oJQ0q44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EATOK+D1E4pT4vtpuefWXxG2d47bm74t8G59fXHqXA8=;
        b=dn5qtBHn5fxXyMFWw+cZHd1Qrdd9aSkvRRE7DqPaucmDIUhEFApU9GXszaeesRRkIF
         qVLhh5yakDOoT8Q192QYVw958I92J75h94BzRwRL3I544q5kmln7JIk+ZyzQII5PQL3B
         egpnJ1M47RDvkCIzG8mW1eqbb9DtkFo+l9p+YhAw0b7BQQpNMm58MquVFpliEEnquyBK
         gL6CSvlteIYsz25kZ1qqtzpJ7gByauZOPSg3CQMvQLPXmpXQyWvR4ZZqCdFfT9Diy7Re
         DAtPpy3EFN0yoUzK6vG6MG93vKlP9lsqBQRgdDdSGBXt2rqotIPho48X4o905yim6Ha8
         D54Q==
X-Gm-Message-State: AGRZ1gLzX/5ZWOUkRc+fl4IQzKX6sFXMP8nYMLBxOFYaJelGgNYvuA3H
        Uu4W/V5TEXsbJ0F3JtrgeklQgF+RLenxKg==
X-Google-Smtp-Source: AJdET5crCE3YmRUd6/PjCxli5ITdnA+bWnUNln5JBGfbVeoAsU/UYtgHXdOb8jdbrYdebFCPaJ2xUQ==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18-v6mr10844553wrt.168.1541169795833;
        Fri, 02 Nov 2018 07:43:15 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id s195-v6sm3000920wmd.39.2018.11.02.07.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 07:43:14 -0700 (PDT)
Date:   Fri, 2 Nov 2018 22:43:09 +0800
From:   leo.yan@linaro.org
To:     Al Grant <Al.Grant@arm.com>
Cc:     "acme@redhat.com" <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: perf dso support for /proc/kallsyms
Message-ID: <20181102144309.GD3983@leoy-ThinkPad-X240s>
References: <20181102025516.GA25374@leoy-ThinkPad-X240s>
 <AM6PR08MB3686A4DD9B75B551885C790386CF0@AM6PR08MB3686.eurprd08.prod.outlook.com>
 <20181102134649.GB3983@leoy-ThinkPad-X240s>
 <AM6PR08MB3686181290347EC355AEDCF986CF0@AM6PR08MB3686.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB3686181290347EC355AEDCF986CF0@AM6PR08MB3686.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 02:12:28PM +0000, Al Grant wrote:
> > root@debian:~/coresight_test# perf buildid-list
> > 0242d9154c78df1d8fe1d0512c36a236d0861a18 [kernel.kallsyms]
> > b8c89e8ba41a2ea486c66a50c29c60d38c34a759 /root/coresight_test/main
> > 26b12a9d1a54ed2b0478cb0203435b76aabab3fb /usr/lib/aarch64-linux-gnu/ld-
> > 2.27.so
> > 8fca7ed524c9469b065af83bc8a529fe72858f53 [vdso]
> > 25829a59e21012cfde7850b30a310cd3a58f531c
> > /root/coresight_test/libcstest.so
> > 70512527439ef76c8802a7a2a546bde6a5a6e967 /usr/lib/aarch64-linux-
> > gnu/libc-2.27.so
> > root@debian:~/coresight_test# ls
> > ~/.debug/\[kernel.kallsyms\]/0242d9154c78df1d8fe1d0512c36a236d0861a18/
> > kallsyms
> 
> What's in that last file?

I can see the correct symbol infos in this file:

root@debian:~/coresight_test# cat ~/.debug/\[kernel.kallsyms\]/0242d9154c78df1d8fe1d0512c36a236d0861a18/kallsyms | head -20
ffff000008080000 t _head
ffff000008080000 T _text
ffff000008080040 t pe_header
ffff000008080044 t coff_header
ffff000008080058 t optional_header
ffff000008080070 t extra_header_fields
ffff0000080800f8 t section_table
ffff000008081000 T do_undefinstr
ffff000008081000 t efi_header_end
ffff000008081000 T _stext
ffff000008081000 T __exception_text_start
ffff000008081268 T do_cp15instr
ffff000008081380 T do_sysinstr
ffff000008081410 T do_debug_exception
ffff000008081550 T do_mem_abort
ffff000008081600 T do_el0_irq_bp_hardening
ffff000008081650 T do_el0_ia_bp_hardening
ffff0000080816f8 T do_sp_pc_abort
ffff0000080817c4 T __exception_text_end
ffff0000080817c8 t bcm2835_handle_irq

> I've seen it happen that the copy of kallsyms
> in ~/.debug has the symbol addresses as zeroes - possibly because it
> was created when you didn't have permissions. That's really a bug
> in perf, as cacheing a copy of this file with the addresses zeroed out
> is kind of pointless. Again, this happens on Intel too.
> 
> Then, you can give yourself permissions - but perf's already cached
> the file and won't update it!
> 
> If you delete it, and then rerun perf record (either as sudo or now
> that you've got kptr_restrict=0) you should see it reappear, with
> correct kernel addresses.
> 
> Perhaps nobody spotted this on Intel because perf report goes directly
> to /proc/kallsyms. But it would be an issue if you ran a perf report
> on a perf.data from an older kernel and it had to go to ~/.debug.
> At that point the fact that ~/.debug/[kernel.kallsyms] had zeroes would
> mean you couldn't symbolicate any addresses.

This is another issue related with permission for accessing kernel
pointer values and this will bother much for cross platforms usage
(e.g. 'perf record' on Arm platform and 'perf script' on x86
platform).

At my side, I executed all commands on Arm Juno board and simply to
say the kallsyms support is broken in perf.

Thanks,
Leo Yan
