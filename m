Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA25C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C086320811
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm/udZKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfAXL5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:57:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36979 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfAXL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:57:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so4977994ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bmx4BpgKe71+rZZ26lOw3fLZEJYFgz55uetEcgrI96E=;
        b=Gm/udZKdWmDsapkf31oi+rV/xrSnCemE9Em+1d3nPz1T325PqUA8UYAq4tZbBsrndL
         QauifVztJj6FXXJ+kqfoCiP+BOIGeFgkA2ClQgXEYVjM+51aCj26rt6kI+qjmgEMj8mH
         7kNRJu+XgTdpEjgsi8TquvDhssPTtjqI+6mkp0ryHr33B+38Ph7eiiuB0VoO7ilDBW6A
         dPxXAOlSwtMniFo02J4cswekKCffWYNCkEaE0j3gmJhRvfqBtZRVCZykn9U+oQXTT0d2
         qwMJxoMY+UUyCDxldf+FQkFYc+nEGeUnLjSvGgfLbrl1nF9whzNr64O+Vo18f2Xz9MwS
         fH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bmx4BpgKe71+rZZ26lOw3fLZEJYFgz55uetEcgrI96E=;
        b=iEXJRz4DyzaP4ShWVI/MCaufCc3jQ/K8gyr9iAxXaYX/x4zFMyV4Cz7lfWFKZHsJCm
         LptuhM9BYKhTiBUPxXauaCSaicH9PZ/HjuIPKxR/jbRXgbDwtbP4cNoZ0Dnj1lKho5BY
         sYcy8EOTsAVUNCmfWS1VWBMBj/H9twxfiDb8jJJrKDNuNAv8zPQDOnMWkLaExteeoVtg
         6IsYdbvyIcUsF5dEG86a2B7PvKaoIvgfUa2CBvUGWStF4y6ZPTIjSQ8eKUzeLjXe2jmq
         70KYvM3C4kfKUIaHRledcyTHzZ30njrgB8lG6KHEj5V3iljc4BuGauH94Dtc/skRmN0Z
         GRig==
X-Gm-Message-State: AJcUukeGtj6ZZ4lp2cjPgQ5GGXovOOzfcQphxfCOqiyS8eJ+Yh16TH1b
        XygJk3Yd0d2gyKh7B/aMbxo=
X-Google-Smtp-Source: ALg8bN6UtOSdiZ6kpnXzV6MiFQ4RAnSAEkzBdbiMYt5qilFhIXuba1TyBeLy6M1MsF0orf+FsOvosA==
X-Received: by 2002:a2e:b04f:: with SMTP id d15-v6mr5355706ljl.3.1548331023688;
        Thu, 24 Jan 2019 03:57:03 -0800 (PST)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id w202sm920226lff.31.2019.01.24.03.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 03:57:03 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH v1 1/2] mm/vmalloc: fix kernel BUG at mm/vmalloc.c:512!
Date:   Thu, 24 Jan 2019 12:56:47 +0100
Message-Id: <20190124115648.9433-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190124115648.9433-1-urezki@gmail.com>
References: <20190124115648.9433-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the vmalloc stress test case triggers the kernel BUG():

<snip>
[60.562151] ------------[ cut here ]------------
[60.562154] kernel BUG at mm/vmalloc.c:512!
[60.562206] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[60.562247] CPU: 0 PID: 430 Comm: vmalloc_test/0 Not tainted 4.20.0+ #161
[60.562293] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[60.562351] RIP: 0010:alloc_vmap_area+0x36f/0x390
<snip>

it can happen due to big align request resulting in overflowing
of calculated address, i.e. it becomes 0 after ALIGN()'s fixup.

Fix it by checking if calculated address is within vstart/vend
range.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1c512fff8a56..fb4fb5fcee74 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -498,7 +498,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	}
 
 found:
-	if (addr + size > vend)
+	/*
+	 * Check also calculated address against the vstart,
+	 * because it can be 0 because of big align request.
+	 */
+	if (addr + size > vend || addr < vstart)
 		goto overflow;
 
 	va->va_start = addr;
-- 
2.11.0

