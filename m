Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB723C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AF827AF2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLD1uaCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AF827AF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936544AbeF2Cav (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:30:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35485 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933679AbeF2Cat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:30:49 -0400
Received: by mail-qt0-f193.google.com with SMTP id z6-v6so6654041qti.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KLZcLD+HkQuv1Dms0jlXw2m73ukkpfbtFF2qHvkCt0w=;
        b=jLD1uaCnW2yi/0nTUGve3btvmgoEsJvpgd7cocgIDa7q7nc5b3sM2LWRfSkvSt8ZQN
         n/tnQLeh1oTUjUstwaoexrZNdwkgUQmpGHtt1UkE+kYx7crIGg+4u8/ZJLEwGRt+fism
         m5Ke20TwBgxd82Bi65dFeY9U8226mlTWQ5Gwlfxxz8cTizdo5IaEwtuGn5DNXIbZMFxB
         B5V+S76Jm80tYrGbxsgMxtQVSC451dIJwQRjzVr6liEzvqycI/YPf+WjZxQ07c4iHAUb
         OkfLrZqCjD5JeWsmN/EpRN+sCYBpDJ9tvhimHGpDms8phHW4YYmgaerkA2Uo2b1hcIHX
         mVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KLZcLD+HkQuv1Dms0jlXw2m73ukkpfbtFF2qHvkCt0w=;
        b=I1Lfs18Urw5Fgk6nSzu64MhbitvZH0P8QY5GeQXI3BK0pnpX39Mf6hV2wI5owLmq7O
         bv8Seuap4dMOS1EZKvUsUqdxUb4BMOAodjzyXQO8HfeXyCHMdbXWjmPX/Z4PD5xdOaKU
         o+9WbPDMq/OWSOE652GptSTSo4VxPyEKrQEDXEn5GMZJnL8YjFE9kFS+cCbGUwPsYgrI
         AW2tM0AntlTDFvTql/+ajNRWI0upwCJjTBG4J9plI6xLwCuQoOVd5sjcLtTMPig11Ivh
         d0Y5DtR+4MmcuGf0s/1fG7yePWbJ9gpUi0OHjiczBjG2iIeEnQfSfpx9lb+7VHoa3mYs
         GDQg==
X-Gm-Message-State: APt69E0JD/fMzQIcOAvOucpVCI6J1a3d+RWF0be/kVgKNlbeOncrv2FO
        /Pf2yLRLibJgboWrs41iQv4=
X-Google-Smtp-Source: AAOMgpeQz4N+gOPnSzkC/neKDGvGOoE2lHAAjhcPRr1fNU2STUx8yTthJS9cFX3y5WYhcegenwaRMQ==
X-Received: by 2002:a0c:be88:: with SMTP id n8-v6mr11429432qvi.78.1530239448543;
        Thu, 28 Jun 2018 19:30:48 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id y25-v6sm6390186qtc.48.2018.06.28.19.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 19:30:47 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>, richard.weiyang@gmail.com,
        Jia He <hejianet@gmail.com>, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v9 4/6] mm/memblock: introduce memblock_search_pfn_regions()
Date:   Fri, 29 Jun 2018 10:29:21 +0800
Message-Id: <1530239363-2356-5-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is to find the memory region index of input pfn.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/memblock.h | 2 ++
 mm/memblock.c            | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ca59883..b0f0307 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -203,6 +203,8 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+int memblock_search_pfn_regions(unsigned long pfn);
+
 /**
  * for_each_free_mem_range - iterate through free memblock areas
  * @i: u64 used as loop variable
diff --git a/mm/memblock.c b/mm/memblock.c
index 611a970..3a4d251 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1625,6 +1625,15 @@ static int __init_memblock memblock_search(struct memblock_type *type, phys_addr
 	return -1;
 }
 
+/* search memblock with the input pfn, return the region idx */
+int __init_memblock memblock_search_pfn_regions(unsigned long pfn)
+{
+	struct memblock_type *type = &memblock.memory;
+	int mid = memblock_search(type, PFN_PHYS(pfn));
+
+	return mid;
+}
+
 bool __init memblock_is_reserved(phys_addr_t addr)
 {
 	return memblock_search(&memblock.reserved, addr) != -1;
-- 
1.8.3.1

