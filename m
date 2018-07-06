Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA92C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683AC20871
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ55SZfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683AC20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeGFJBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:01:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44511 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeGFJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:01:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id j3-v6so7883600pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 02:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jM7muFrP8E5ufaHgiEgpopKk4Jw6+jnixG9hq52/7OA=;
        b=eQ55SZfT39Np4cVkC+pxeJFtNZTXVRinmgujempNzHfYyasQWjQdMa0rF8sYyvdpvP
         GHJnk9AV4e/0TZBeWI6s0xxVb/uSxmuIy9jvowp88u+j6ryMGVOZlFSUYFcFLHvWecqp
         Mfnj3e8jgA87Sa+2AcjyhU6+siVVACe42ySKQbIYxO/WZ3yyzv3F8ZK1J4j/dGx+/xic
         tvzM6W3zrQDJn02BmoOIlgsezAUNTxliWx7eAimj7r6YD1gIBX6/++DU4o+upYiUXH5o
         IEZWeFSmEbCbg9qSfDfNb+iXUsgaf+PB3WJMrZPvzGOBUnmihfI61Fwe0vCfYweBqI13
         Ncvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jM7muFrP8E5ufaHgiEgpopKk4Jw6+jnixG9hq52/7OA=;
        b=B09eokrAuzQUkS6qRDE4RQWdbIKmYCauEuBJAkV1lb9Dib2h/E16GWp+o75MFBFY14
         mSQJYBDhxFDR8AmQ23LGG9ET9u4e5yKb7xnXAmZppHo8KowCQPtLOeB161FKx5KLArqI
         3cKJ+tb9kijkSbA194Gi1qC3awdZPGEQAnfNf3u0tyUxx1q2SvYw7kccelGnc7PHeqZ0
         e5vU+zDyAr8zT5L5xVpYQZzmZeaF+DIE8gNI6j1Qth7XpwJzp7DUukwvDsm92vpIUyl/
         fn0AR/S3wVPbzCfBTKekXR960nPNvyXGj1X+fOtW6uHmPp0RnSGYnxVLx7PLVu2Zft2r
         ff/Q==
X-Gm-Message-State: APt69E12Dc8y2/dhVFNsb4JS8Jxy3fx2itAq/4+bEDSYfTh/l4MRNSRZ
        iZ8CPDJqw7imjRNf/pRDW3c=
X-Google-Smtp-Source: AAOMgpeHBKFBot4rhRz/3vhjmmV2WJj9H8y5gy/dQMN/YslmU4DNJVF0zBHz1fI1h40m2Ta4bFp8zg==
X-Received: by 2002:a65:620b:: with SMTP id d11-v6mr8780798pgv.429.1530867698152;
        Fri, 06 Jul 2018 02:01:38 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id e5-v6sm10837092pgs.59.2018.07.06.02.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 02:01:37 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <hejianet@gmail.com>
Subject: [RESEND PATCH v10 0/6] optimize memblock_next_valid_pfn and early_pfn_valid on arm and arm64
Date:   Fri,  6 Jul 2018 17:01:09 +0800
Message-Id: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But it causes
possible panic bug. So Daniel Vacek reverted it later.

But as suggested by Daniel Vacek, it is fine to using memblock to skip
gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.

More from what Daniel said:
"On arm and arm64, memblock is used by default. But generic version of
pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
not always return the next valid one but skips more resulting in some
valid frames to be skipped (as if they were invalid). And that's why
kernel was eventually crashing on some !arm machines."

About the performance consideration:
As said by James in b92df1de5,
"I have tested this patch on a virtual model of a Samurai CPU with a
sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.

Besides we can remain memblock_next_valid_pfn, there is still some room
for improvement. After this set, I can see the time overhead of memmap_init
is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
memory, pagesize 64k). I believe arm server will benefit more if memory is
larger than TBs

Patch 1 introduces new config to make codes more generic
Patch 2 remains the memblock_next_valid_pfn on arm and arm64,this patch is
        originated from b92df1de5
Patch 3 optimizes the memblock_next_valid_pfn()
Patch 4~6 optimizes the early_pfn_valid()

Changelog:
V10:- move codes to memblock.c, refine the performance consideration
V9: - rebase to mmotm master, refine the log description. No major changes
V8: - introduce new config and move generic code to early_pfn.h
    - optimize memblock_next_valid_pfn as suggested by Matthew Wilcox
V7: - fix i386 compilation error. refine the commit description
V6: - simplify the codes, move arm/arm64 common codes to one file.
    - refine patches as suggested by Danial Vacek and Ard Biesheuvel
V5: - further refining as suggested by Danial Vacek. Make codes
      arm/arm64 more arch specific
V4: - refine patches as suggested by Danial Vacek and Wei Yang
    - optimized on arm besides arm64
V3: - fix 2 issues reported by kbuild test robot
V2: - rebase to mmotm latest
    - remain memblock_next_valid_pfn on arm64
    - refine memblock_search_pfn_regions and pfn_valid_region

Jia He (6):
  arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
  mm: page_alloc: remain memblock_next_valid_pfn() on arm/arm64
  mm: page_alloc: reduce unnecessary binary search in
    memblock_next_valid_pfn()
  mm/memblock: introduce memblock_search_pfn_regions()
  mm/memblock: introduce pfn_valid_region()
  mm: page_alloc: reduce unnecessary binary search in early_pfn_valid()

 arch/arm/Kconfig         |  4 +++
 arch/arm64/Kconfig       |  4 +++
 include/linux/memblock.h |  2 ++
 include/linux/mmzone.h   | 16 +++++++++
 mm/Kconfig               |  3 ++
 mm/memblock.c            | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c          |  5 ++-
 7 files changed, 117 insertions(+), 1 deletion(-)

-- 
1.8.3.1

