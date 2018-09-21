Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDA521532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDA521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbeIUSxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:53:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbeIUSxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:53:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B118730001D7;
        Fri, 21 Sep 2018 13:04:25 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EF60106A7BB;
        Fri, 21 Sep 2018 13:04:20 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list\:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
        <20180920063129.GB12913@lst.de>
Date:   Fri, 21 Sep 2018 15:04:18 +0200
In-Reply-To: <20180920063129.GB12913@lst.de> (Christoph Hellwig's message of
        "Thu, 20 Sep 2018 08:31:29 +0200")
Message-ID: <87h8ij0zot.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 21 Sep 2018 13:04:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
>> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
>> yes, is it a stable rule?
>
> This is the assumption in a lot of the kernel, so I think if somethings
> breaks this we are in a lot of pain.

It seems that SLUB debug breaks this assumption. Kernel built with

CONFIG_SLUB_DEBUG=y
CONFIG_SLUB=y
CONFIG_SLUB_DEBUG_ON=y

And the following patch:
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b20607d581b..56713b201921 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1771,3 +1771,28 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
        e820__range_add(addr, size, E820_TYPE_ACPI);
        e820__update_table_print();
 }
+
+#define KMALLOCS 16
+
+static __init int kmalloc_check_512(void)
+{
+       void *buf[KMALLOCS];
+       int i;
+
+       pr_info("kmalloc_check_512: start\n");
+
+       for (i = 0; i < KMALLOCS; i++) {
+               buf[i] = kmalloc(512, GFP_KERNEL);
+       }
+
+       for (i = 0; i < KMALLOCS; i++) {
+               pr_info("%lx %x\n", (unsigned long)buf[i], ((unsigned long)buf[i]) % 512);
+               kfree(buf[i]);
+       }
+
+       pr_info("kmalloc_check_512: done\n");
+
+       return 0;
+}
+
+late_initcall(kmalloc_check_512);

gives me the following output:

[    8.417468] kmalloc_check_512: start
[    8.429572] ffff9a3258bb09f8 1f8
[    8.435513] ffff9a3258bb70a8 a8
[    8.441352] ffff9a3258bb0d48 148
[    8.447139] ffff9a3258bb6d58 158
[    8.452864] ffff9a3258bb1098 98
[    8.458536] ffff9a3258bb6a08 8
[    8.464103] ffff9a3258bb13e8 1e8
[    8.469534] ffff9a3258bb66b8 b8
[    8.474907] ffff9a3258bb1738 138
[    8.480214] ffff9a3258bb6368 168
[    8.480217] ffff9a3258bb1a88 88
[    8.496178] ffff9a3258bb6018 18
[    8.501218] ffff9a3258bb1dd8 1d8
[    8.506138] ffff9a3258bb5cc8 c8
[    8.511010] ffff9a3258bb2128 128
[    8.515795] ffff9a3258bb5978 178
[    8.520517] kmalloc_check_512: done

(without SLUB_DEBUG_ON all addresses are 512b aligned).

-- 
  Vitaly
