Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7FEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B230F2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MMztVRRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B230F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeJBCm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:42:27 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45190 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBCm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:42:27 -0400
Received: by mail-yb1-f195.google.com with SMTP id d9-v6so6142463ybr.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GNlIUAwuN1sQQ+qJNf7a6orBI5uhXKmIz9IhShdF95M=;
        b=MMztVRRofm+KI9WR1xYJ7sb0nzYrDOnrVnigSK+U3j/A/d1/OyfHH9PATv5QF9AFQM
         VbIl6eEhRRnJPJsk+JS9oQcBxFh4F1f9FxUsR7ZiNQAP3xWAKl2x+QKC/VL7hzp3fABJ
         vtSGGKMIVf2fLclvlaQAGXXFh4zm5VLRg/5mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GNlIUAwuN1sQQ+qJNf7a6orBI5uhXKmIz9IhShdF95M=;
        b=S//2JJ5ITKRBHX8aBqliO5Fz1EeJco+rK5UlzqZZ5gyp5zGRptqDF9pAEfd8HL60cT
         y0/R4gH3/SrDf5NchZIPnszqPS5b/ZslBWvBSpMJ3KQyHqngpWLun7kNuetTHpKQsyTc
         +1qvdEcRlbT4eO5tDtiJHxUL6YQfieUmkXuzqQ9j8GAovxzQvLk3a9UdJs/Z80BqVD07
         Kq9s5lRZr/Jefy8rExDc3IxM48WM3ttWFHdiCJKZMnnVGjQfvIypGN39q1a2hEjXJtNY
         fo+CNy/CAXiy719vyMmDK0gvu3fFfyWCj2I+UpsRUIPEWw7P8MyEDOx6sDoFW6pCT1JT
         KHVg==
X-Gm-Message-State: ABuFfoiurKjGGd96UHvqhx974DKgkJUaWA7eHkBpJRZMF3S2tsUdN+zy
        boEpctUDlNw9cuwQP34Gm01fvyx/qck=
X-Google-Smtp-Source: ACcGV628q5p3sVW1J9de+WG8UZ/bDkCFytXtDlUdt9874EVYGY1Xn0T3uLEQOoKVnbnlNxocBQE5Xg==
X-Received: by 2002:a25:5507:: with SMTP id j7-v6mr6966261ybb.133.1538424179522;
        Mon, 01 Oct 2018 13:02:59 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id t81-v6sm7428290ywb.90.2018.10.01.13.02.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 13:02:57 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id y14-v6so6053771ywa.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:02:57 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr6689309ywg.47.1538424176795;
 Mon, 01 Oct 2018 13:02:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 13:02:56 -0700 (PDT)
In-Reply-To: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 13:02:56 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL2xgiXZ_9bdY9fWJB7dKvzKO7L9Xb83M0mmmhQrZSZcQ@mail.gmail.com>
Message-ID: <CAGXu5jL2xgiXZ_9bdY9fWJB7dKvzKO7L9Xb83M0mmmhQrZSZcQ@mail.gmail.com>
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
To:     Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Juliet Kim <minkim@us.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 11:56 AM, Michael Bringmann
<mwb@linux.vnet.ibm.com> wrote:
> In some LPAR migration scenarios, device-tree modifications are
> made to the affinity of the memory in the system.  For instance,
> it may occur that memory is installed to nodes 0,3 on a source
> system, and to nodes 0,2 on a target system.  Node 2 may not
> have been initialized/allocated on the target system.
>
> After migration, if a RTAS PRRN memory remove is made to a
> memory block that was in node 3 on the source system, then
> try_offline_node tries to remove it from node 2 on the target.
> The NODE_DATA(2) block would not be initialized on the target,
> and there is no validation check in the current code to prevent
> the use of a NULL pointer.  Call traces such as the following
> may be observed:
>
> A similar problem of moving memory to an unitialized node has
> also been observed on systems where multiple PRRN events occur
> prior to a complete update of the device-tree.
>
> pseries-hotplug-mem: Attempting to update LMB, drc index 80000002
> Offlined Pages 4096
> ...
> Oops: Kernel access of bad area, sig: 11 [#1]
> ...
> Workqueue: pseries hotplug workque pseries_hp_work_fn
> ...
> NIP [c0000000002bc088] try_offline_node+0x48/0x1e0
> LR [c0000000002e0b84] remove_memory+0xb4/0xf0
> Call Trace:
> [c0000002bbee7a30] [c0000002bbee7a70] 0xc0000002bbee7a70 (unreliable)
> [c0000002bbee7a70] [c0000000002e0b84] remove_memory+0xb4/0xf0
> [c0000002bbee7ab0] [c000000000097784] dlpar_remove_lmb+0xb4/0x160
> [c0000002bbee7af0] [c000000000097f38] dlpar_memory+0x328/0xcb0
> [c0000002bbee7ba0] [c0000000000906d0] handle_dlpar_errorlog+0xc0/0x130
> [c0000002bbee7c10] [c0000000000907d4] pseries_hp_work_fn+0x94/0xa0
> [c0000002bbee7c40] [c0000000000e1cd0] process_one_work+0x1a0/0x4e0
> [c0000002bbee7cd0] [c0000000000e21b0] worker_thread+0x1a0/0x610
> [c0000002bbee7d80] [c0000000000ea458] kthread+0x128/0x150
> [c0000002bbee7e30] [c00000000000982c] ret_from_kernel_thread+0x5c/0xb0
>
> This patch adds a check for an incorrectly initialized to the
> beginning of try_offline_node, and exits the routine.
>
> Another patch is being developed for powerpc to track the
> node Id to which an LMB belongs, so that we can remove the
> LMB from there instead of the nid as currently interpreted
> from the device tree.
>
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  mm/memory_hotplug.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 38d94b7..e48a4d0 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1831,10 +1831,16 @@ static int check_and_unmap_cpu_on_node(pg_data_t *pgdat)
>  void try_offline_node(int nid)
>  {
>         pg_data_t *pgdat = NODE_DATA(nid);
> -       unsigned long start_pfn = pgdat->node_start_pfn;
> -       unsigned long end_pfn = start_pfn + pgdat->node_spanned_pages;
> +       unsigned long start_pfn;
> +       unsigned long end_pfn;
>         unsigned long pfn;
>
> +       if (WARN_ON(pgdat == NULL))
> +               return;
> +
> +       start_pfn = pgdat->node_start_pfn;
> +       end_pfn = start_pfn + pgdat->node_spanned_pages;
> +
>         for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>                 unsigned long section_nr = pfn_to_section_nr(pfn);
>
>



-- 
Kees Cook
Pixel Security
