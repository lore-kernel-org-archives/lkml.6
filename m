Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE08C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2F72081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYk3lsO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2F72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLHQyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:54:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39834 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeLHQyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:54:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so3057811pgl.6;
        Sat, 08 Dec 2018 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2hct+ZRR8rRYEFyDei6ndHl0ehIYvmcohzDWZ+SpS7M=;
        b=IYk3lsO+jcq0Ng7UyT2HllDNgaHPmrsXuWGgMWm4JZIq1Opr0fYMcGEPZkIa4k5wMw
         pijQO1wRdeMuEaF08L09VWOCdwpHEn6d6zaKMF/23pWjHKl9q78vzpXntyy5btGG04R4
         fF4Y9jsZoQkkOsxzC+zGMY6sV4wbFhUH0JNU0kLEweH5OsmgQ2u32TXkFApuJXoH65TK
         RVU0N24hBmLvx94Ea73P1/c8IuJEkRev2+XlB4phoqrI4FcQ/KwLB8/QA6xE9I7U4tjh
         EJEINuISx209QLsyXLMoeR8U7MTlYL7NV32WhpQj3+TmobbVm84z9lW+0MkjljuxFSSs
         cwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2hct+ZRR8rRYEFyDei6ndHl0ehIYvmcohzDWZ+SpS7M=;
        b=C6fB7wPlzhUTeGhhbr2gU4kydfuX62PQlwPmRCzvFKOHNFqEDJj8OuFdnbRpKDTPXF
         kxATLPYCpWhHnotLODVtKEO8kCEHnzfphCe72mHt2S41vQM47uNiW6fF7UPyCdVUPeKH
         Orrmjv8vQ/WB+WrrlykoN1xaNuEfLBOssFuAMqPI1XJp8AFdXhPVxT1FFmLnMPoueswI
         myjFbOdchlKOXQBR+L7JPyJAvGm+zmeITcyr4ia0ywtY/zcchLt8w1jRWSN01t0pI0EP
         FIuayK59GI3+j09VMCBtCbn58fP/wJvnrCVxejcW+qMXhjU3J8hJTh4+o1d2P3LWYyQj
         GqvA==
X-Gm-Message-State: AA+aEWYv4hTNXHotgmeUBaew50wjbxG0GT+OqSTRpnW3f/hZ/8wt45Hb
        7U4c8QnblTC9pIH2BMuK/uk=
X-Google-Smtp-Source: AFSGD/UpIc0S291b2DJxtbwVNHJuqlhYFxtP7QAFJs7eGjjs9teMKRxCwy4rWWCv6IkFAXHxTN/4eQ==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr5638920pgn.112.1544288059718;
        Sat, 08 Dec 2018 08:54:19 -0800 (PST)
Received: from magata (i219-164-165-113.s42.a013.ap.plala.or.jp. [219.164.165.113])
        by smtp.gmail.com with ESMTPSA id z186sm9193244pfz.119.2018.12.08.08.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:54:18 -0800 (PST)
Date:   Sun, 9 Dec 2018 01:54:10 +0900
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 11/11] selftests/livepatch: introduce tests
Message-ID: <20181208165410.GA19464@magata>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-12-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-12-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-2018 10:44, Petr Mladek wrote:
> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Add a few livepatch modules and simple target modules that the included
> regression suite can run tests against:
> 
>   - basic livepatching (multiple patches, atomic replace)
>   - pre/post (un)patch callbacks
>   - shadow variable API
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  Documentation/livepatch/callbacks.txt              | 489 +----------------
>  MAINTAINERS                                        |   1 +
>  lib/Kconfig.debug                                  |  21 +
>  lib/Makefile                                       |   2 +
>  lib/livepatch/Makefile                             |  15 +
>  lib/livepatch/test_klp_atomic_replace.c            |  57 ++
>  lib/livepatch/test_klp_callbacks_busy.c            |  43 ++
>  lib/livepatch/test_klp_callbacks_demo.c            | 121 +++++
>  lib/livepatch/test_klp_callbacks_demo2.c           |  93 ++++
>  lib/livepatch/test_klp_callbacks_mod.c             |  24 +
>  lib/livepatch/test_klp_livepatch.c                 |  51 ++
>  lib/livepatch/test_klp_shadow_vars.c               | 236 +++++++++
>  tools/testing/selftests/Makefile                   |   1 +
>  tools/testing/selftests/livepatch/Makefile         |   8 +
>  tools/testing/selftests/livepatch/README           |  43 ++
>  tools/testing/selftests/livepatch/config           |   1 +
>  tools/testing/selftests/livepatch/functions.sh     | 203 +++++++
>  .../testing/selftests/livepatch/test-callbacks.sh  | 587 +++++++++++++++++++++
>  .../testing/selftests/livepatch/test-livepatch.sh  | 168 ++++++
>  .../selftests/livepatch/test-shadow-vars.sh        |  60 +++
>  20 files changed, 1740 insertions(+), 484 deletions(-)
>  create mode 100644 lib/livepatch/Makefile
>  create mode 100644 lib/livepatch/test_klp_atomic_replace.c
>  create mode 100644 lib/livepatch/test_klp_callbacks_busy.c
>  create mode 100644 lib/livepatch/test_klp_callbacks_demo.c
>  create mode 100644 lib/livepatch/test_klp_callbacks_demo2.c
>  create mode 100644 lib/livepatch/test_klp_callbacks_mod.c
>  create mode 100644 lib/livepatch/test_klp_livepatch.c
>  create mode 100644 lib/livepatch/test_klp_shadow_vars.c
>  create mode 100644 tools/testing/selftests/livepatch/Makefile
>  create mode 100644 tools/testing/selftests/livepatch/README
>  create mode 100644 tools/testing/selftests/livepatch/config
>  create mode 100644 tools/testing/selftests/livepatch/functions.sh
>  create mode 100755 tools/testing/selftests/livepatch/test-callbacks.sh
>  create mode 100755 tools/testing/selftests/livepatch/test-livepatch.sh
>  create mode 100755 tools/testing/selftests/livepatch/test-shadow-vars.sh

I tested the livepatch selftest and it works for me:

```
gentoo_07 linux-dev (alice/livepatch) # make -C tools/testing/selftests
TARGETS=livepatch run_tests
make: Entering directory '/root/linux-dev/tools/testing/selftests'
make[1]: Entering directory
'/root/linux-dev/tools/testing/selftests/livepatch'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory
'/root/linux-dev/tools/testing/selftests/livepatch'
make[1]: Entering directory
'/root/linux-dev/tools/testing/selftests/livepatch'
TAP version 13
selftests: livepatch: test-livepatch.sh
========================================
TEST: basic function patching ... ok
TEST: multiple livepatches ... ok
TEST: atomic replace livepatch ... ok
ok 1..1 selftests: livepatch: test-livepatch.sh [PASS]
selftests: livepatch: test-callbacks.sh
========================================
TEST: target module before livepatch ... ok
TEST: module_coming notifier ... ok
TEST: module_going notifier ... ok
TEST: module_coming and module_going notifiers ... ok
TEST: target module not present ... ok
TEST: pre-patch callback -ENODEV ... ok
TEST: module_coming + pre-patch callback -ENODEV ... ok
TEST: multiple target modules ... ok
TEST: busy target module ... ok
TEST: multiple livepatches ... ok
TEST: atomic replace ... ok
ok 1..2 selftests: livepatch: test-callbacks.sh [PASS]
selftests: livepatch: test-shadow-vars.sh
========================================
TEST: basic shadow variable API ... ok
ok 1..3 selftests: livepatch: test-shadow-vars.sh [PASS]
make[1]: Leaving directory
'/root/linux-dev/tools/testing/selftests/livepatch'
make: Leaving directory '/root/linux-dev/tools/testing/selftests'
```

Tested-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>

