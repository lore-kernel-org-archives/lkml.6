Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0992C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D09620811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cawo/LZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbeLTJvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:51:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36518 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbeLTJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:51:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so634807pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K9zzrRbAs14lLTCZYoWS/52u0ibfEdXn3/6zg6/SpNU=;
        b=cawo/LZyFHw0a9nn79FtBaUQ4o0n02ATimLl1BHixK3isAls4RqYinMz0vcvIlMupq
         US65dSQcksi+YlpEzqhBUDGpTcOWu99AOU6d4YCrQfaMFNNowj8LJNVcBjytOp55d2rC
         jA2NR2zDNO37sI78CvvxYGn/TVhdDq/O800R4jbUs3YNCfRiGhAYudWfvajTPt3PDqA4
         WBeM+MHNpYQo8UDXnV7tY4UAYHIubUHuSRKlVD/BYET0z5jUdBOHaVrXqDY7TPhNrQm9
         gQAsHC4H6DcXUUB7axSlNp8KYdJ996WGibUN/grzctgkeln2nxWQi6yP/mQF7LYklsOS
         UMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K9zzrRbAs14lLTCZYoWS/52u0ibfEdXn3/6zg6/SpNU=;
        b=OnhABXt7OJvxypG/eW+ztpgSZ07zUfizTNjM7+P5Jm6gw6VOZe3OdHfpa790YgjoEC
         wPnkjaqBoYFtRKsY8v6PpHb4/jhWFm3DA74riqaa7Pgpexh8KgQUC38S5UverdjWqt4R
         zGBN6i4XpMIkDSb2T6g0A1xMmM1ANA7DgD/2v6N8SVVMuhunk5wmrB2+lfN/FP8kq58Q
         7OXlOhNoedmNfdePcGymVnfzvO4qhGHXcJOkZzjFSE//cejFrqxO1u/O/SsoG7HSsj7p
         XicFZJU+9K5vkxvV+BMXqVLi2BWrk19wBQuIDeRxJFiFVCscGywmSQSAsY+nJbcDYKy0
         40oA==
X-Gm-Message-State: AA+aEWYm14B18mfrOMk3oM04A3X6PZh6t/SKIK7ZQvYJUePT0S5LbsLa
        NwFe5BX3vWgqXyDFzmteRw==
X-Google-Smtp-Source: AFSGD/XeJOApkGvdkxd48eaI/6391uyxOM9NiHU/74wjWx2he8cZDiD+k3ub8z+DYADUJDzUDyikXQ==
X-Received: by 2002:a63:5518:: with SMTP id j24mr22083194pgb.208.1545299463150;
        Thu, 20 Dec 2018 01:51:03 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 125sm33355206pfx.159.2018.12.20.01.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 01:51:02 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCHv2 0/3] mm: bugfix for NULL reference in mm on all archs
Date:   Thu, 20 Dec 2018 17:50:36 +0800
Message-Id: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is original reported at https://lore.kernel.org/patchwork/patch/1020838/
In a short word, this bug should affect all archs, where a machine with a
numa-node having no memory, if nr_cpus prevents the instance of nodeA, and the
device on nodeA tries to allocate memory with device->numa_node info.
And node_zonelist(preferred_nid, gfp_mask) will panic due to uninstanced nodeA.

And there are two alternative methods to fix it.
-1st. Fix it in mm system
-2nd. Fix it in all archs independently, by online all possible nodes.

Originaly, I tries to fix it by the 1st method, while Michal suggests the 2nd one.
This series [1-2/3] tries to resolve some defect in v1, pointed out by Michal.
For discussion purpose, I send [3/3] in this thread, which tries to show e.g of
the 2nd method on powerpc platform.
For x86, I still help Michal to verify his patch on my test machine, please see:
https://lore.kernel.org/patchwork/comment/1208479/
https://lore.kernel.org/patchwork/comment/1210452/

It has already cost a little long time to find a solution, cc x86 and ppc mailing list
and hope their maintainers to give some suggestion to speed up the final solution.

Pingfan Liu (3):
  mm/numa: change the topo of build_zonelist_xx()
  mm/numa: build zonelist when alloc for device on offline node
  powerpc/numa: make all possible node be instanced against NULL
    reference in node_zonelist()

 arch/powerpc/mm/numa.c | 13 ++++++--
 include/linux/gfp.h    | 10 +++++-
 mm/page_alloc.c        | 85 ++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 81 insertions(+), 27 deletions(-)

Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
-- 
2.7.4

