Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F497C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD2A20842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498340;
	bh=+LN0SxZ2nsNjztTM4fp+LrjAK6ddPQnURu9ASxWKcog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CwOSGaflJ81LZBtkN3UV91Zz46zMQsZzMIlb8VbewWDyIeDZtSk/nvvo9RuifYwnv
	 e7mnfNVKqQwnVrShS76YpBHEeuowNNSrfJhvKwlf/2Gfia7IjAmdaZAKbJXKt2nYH7
	 JdHreAMpdnbL9wJwBN39c3EpRECB/YUGe6TPlxKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfBRN66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:58:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388444AbfBRN6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699E620842;
        Mon, 18 Feb 2019 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498328;
        bh=+LN0SxZ2nsNjztTM4fp+LrjAK6ddPQnURu9ASxWKcog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiJvrN19+cluB3ubwn+g1Lth1vB25uPEH8AQOu9NttRcW0yXnbT85URiAKuk64zMx
         KGkclojERtcp0cW1Ky8F+0If7FxJlL7Y/qT67qrkVSTfBvoe0oUhR9DFnPWAzir/0j
         e7asuHTD3yg41D3sU+kXnUubITend04OnU3kiNmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikson Kanti Paul <nikson@amazon.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Amit Shah <aams@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 34/58] perf report: Include partial stacks unwound with libdw
Date:   Mon, 18 Feb 2019 14:43:55 +0100
Message-Id: <20190218133511.298067634@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 5ea0416f51cc93436bbe497c62ab49fd9cb245b6 upstream.

So far the whole stack was thrown away when any error occurred before
the maximum stack depth was unwound. This is actually a very common
scenario though. The stacks that got unwound so far are still
interesting. This removes a large chunk of differences when comparing
perf script output for libunwind and libdw perf unwinding.

E.g. with libunwind:

~~~~~
heaptrack_gui  2228 135073.388524:     479408 cycles:
        ffffffff811749ed perf_iterate_ctx ([kernel.kallsyms])
        ffffffff81181662 perf_event_mmap ([kernel.kallsyms])
        ffffffff811cf5ed mmap_region ([kernel.kallsyms])
        ffffffff811cfe6b do_mmap ([kernel.kallsyms])
        ffffffff811b0dca vm_mmap_pgoff ([kernel.kallsyms])
        ffffffff811cdb0c sys_mmap_pgoff ([kernel.kallsyms])
        ffffffff81033acb sys_mmap ([kernel.kallsyms])
        ffffffff81631d37 entry_SYSCALL_64_fastpath ([kernel.kallsyms])
                   192ca mmap64 (/usr/lib/ld-2.25.so)
                    59a9 _dl_map_object_from_fd (/usr/lib/ld-2.25.so)
                    83d0 _dl_map_object (/usr/lib/ld-2.25.so)
                    cda1 openaux (/usr/lib/ld-2.25.so)
                   1834f _dl_catch_error (/usr/lib/ld-2.25.so)
                    cfe2 _dl_map_object_deps (/usr/lib/ld-2.25.so)
                    3481 dl_main (/usr/lib/ld-2.25.so)
                   17387 _dl_sysdep_start (/usr/lib/ld-2.25.so)
                    4d37 _dl_start (/usr/lib/ld-2.25.so)
                     d87 _start (/usr/lib/ld-2.25.so)

heaptrack_gui  2228 135073.388677:     611329 cycles:
                   1a3e0 strcmp (/usr/lib/ld-2.25.so)
                    82b2 _dl_map_object (/usr/lib/ld-2.25.so)
                    cda1 openaux (/usr/lib/ld-2.25.so)
                   1834f _dl_catch_error (/usr/lib/ld-2.25.so)
                    cfe2 _dl_map_object_deps (/usr/lib/ld-2.25.so)
                    3481 dl_main (/usr/lib/ld-2.25.so)
                   17387 _dl_sysdep_start (/usr/lib/ld-2.25.so)
                    4d37 _dl_start (/usr/lib/ld-2.25.so)
                     d87 _start (/usr/lib/ld-2.25.so)
~~~~~

With libdw without this patch:

~~~~~
heaptrack_gui  2228 135073.388524:     479408 cycles:
        ffffffff811749ed perf_iterate_ctx ([kernel.kallsyms])
        ffffffff81181662 perf_event_mmap ([kernel.kallsyms])
        ffffffff811cf5ed mmap_region ([kernel.kallsyms])
        ffffffff811cfe6b do_mmap ([kernel.kallsyms])
        ffffffff811b0dca vm_mmap_pgoff ([kernel.kallsyms])
        ffffffff811cdb0c sys_mmap_pgoff ([kernel.kallsyms])
        ffffffff81033acb sys_mmap ([kernel.kallsyms])
        ffffffff81631d37 entry_SYSCALL_64_fastpath ([kernel.kallsyms])

heaptrack_gui  2228 135073.388677:     611329 cycles:
~~~~~

With this patch applied, the libdw unwinder will produce the same
output as the libunwind unwinder.

Signed-off-by: Nikson Kanti Paul <nikson@amazon.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20170601210021.20046-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Amit Shah <aams@amazon.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org> # 4.9
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/unwind-libdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 046a4850e3df..ff32ca1d81ff 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -231,7 +231,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 
 	err = dwfl_getthread_frames(ui->dwfl, thread->tid, frame_callback, ui);
 
-	if (err && !ui->max_stack)
+	if (err && ui->max_stack != max_stack)
 		err = 0;
 
 	/*
-- 
2.19.1



