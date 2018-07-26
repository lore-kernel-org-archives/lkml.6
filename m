Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F54C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5532088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5532088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbeGZXev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbeGZXev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:34:51 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76006206B7;
        Thu, 26 Jul 2018 22:16:01 +0000 (UTC)
Date:   Thu, 26 Jul 2018 18:15:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     greg@kroah.com, Kees Cook <keescook@google.com>,
        salyzyn@android.com, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, kernel-team@android.com, stable@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180726181558.25a5c3b8@gandalf.local.home>
In-Reply-To: <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
References: <20180725202238.165314-1-salyzyn@android.com>
        <20180725210717.3b807191@vmware.local.home>
        <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
        <20180726153153.GA8327@kroah.com>
        <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 09:52:11 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> See the section "Kernel addresses" in
> Documentation/security/self-protection.  IIRC, the issue is that a
> process may have CAP_SYSLOG but not necessarily CAP_SYS_ADMIN (so it
> can read dmesg, but not necessarily issue a sysctl to change
> kptr_restrict), get compromised and used to leak kernel addresses,
> which can then be used to defeat KASLR.

But the code doesn't go to dmesg. It's only available
via /sys/kernel/debug/tracing/printk_formats which is only available
via root. Nobody else has access to that directory.

-- Steve
