Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80C4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870CF2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfBESiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:38:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfBESiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:38:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447A42083B;
        Tue,  5 Feb 2019 18:38:23 +0000 (UTC)
Date:   Tue, 5 Feb 2019 13:38:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: libelf-0.175 breaks objtool
Message-ID: <20190205133821.1a243836@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a FYI.

After a recent upgrade in debian testing, I was not able to build the
kernel. I have a custom build of gcc, so I thought it was strange that
I was getting something like this (took this from the web, as I don't
have the error anymore with the work around, and currently doing a full
build):

objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info                       
objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info                       
objdump: kernel/.tmp_signal.o: file format not recognized                                                           
  CC      arch/x86/kernel/platform-quirks.o                                                                         
objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info                
objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info                
objdump: arch/x86/kernel/.tmp_ebda.o: file format not recognized                                                    
objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info                       
objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info                       
objdump: mm/.tmp_swap_slots.o: file format not recognized                                   

The web showed this was an error in Arch Linux, with the latest
libelf-0.175. I was confused to why an upgrade broke my build since I
don't even use the distro gcc to build my kernel. But then realized it
was objtool (after doing a make V=1).

To make sure that this was the case, I used the gcc command (leaving it
out here as it was very long) from a make V=1 to get an object file to
play with. Then tried out:

$ objdump -dr arch/x86/events/intel/.tmp_rapl.o

Which dumped the contents of .tmp_rapl.o nicely.

Then performed:

$ ./tools/objtool/objtool orc generate  --module --no-fp --retpoline "arch/x86/events/intel/.tmp_rapl.o";

And then tried again the objdump, but this time I got:

$ objdump -dr arch/x86/events/intel/.tmp_rapl.o
objdump: arch/x86/events/intel/.tmp_rapl.o: unable to initialize decompress status for section .debug_info
objdump: arch/x86/events/intel/.tmp_rapl.o: unable to initialize decompress status for section .debug_info
objdump: arch/x86/events/intel/.tmp_rapl.o: file format not recognized


The work around I did was that I found an older libelf on another box,
copied it to this box and made the symlink point to it. Low and behold,
objtool worked again.

Anyone else stumble across this?

-- Steve
