Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92375C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32CB2151B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32CB2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeKUGuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:50:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeKUGuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:50:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0D583082E10;
        Tue, 20 Nov 2018 20:19:26 +0000 (UTC)
Received: from jlaw-desktop.bos.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E27D268D4A;
        Tue, 20 Nov 2018 20:19:21 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RFC PATCH 0/1] support ftrace and -ffunction-sections
Date:   Tue, 20 Nov 2018 15:19:17 -0500
Message-Id: <1542745158-25392-1-git-send-email-joe.lawrence@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 20 Nov 2018 20:19:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I noticed that ftrace does not currently support functions built with
the -ffunction-sections option as they end up in .text.<function_name>
ELF sections, never making into the __mcount_loc section.

I modified the recordmcount scripts to handle such .text. section
prefixes and this appears to work on x86_64, ppc64le, and s390x -- at
least for simple modules, including the "Test trace_printk from module"
ftrace self-test. 

That said, I did notice 90ad4052e85c ("kbuild: avoid conflict between
-ffunction-sections and -pg on gcc-4.7") which indicates that the kernel
still supports versions of gcc which may not play well with ftrace and
-ffunction-sections.

With that limitation in mind, can we support ftracing of functions in
such sections for compiler versions that do support it? (fwiw, gcc
v4.8.5 seems happy)  And then if so, what additional testing or coding
would need to be done to be confident that it is safe?  Is matching on
".text.*" too inclusive?

Thanks,

-- Joe


Joe Lawrence (1):
  scripts/recordmcount.{c,pl}: support -ffunction-sections .text.*
    section names

 scripts/recordmcount.c  |  2 +-
 scripts/recordmcount.pl | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.8.3.1

