Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90659C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23BC208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="KFGfJ8k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23BC208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeG0N3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:29:00 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:10383 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbeG0N3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:29:00 -0400
Date:   Fri, 27 Jul 2018 08:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1532693239;
        bh=VQH4m+DW2llIfsMVZnRfYq1RTnOejHZUtahsoAIeZzA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=KFGfJ8k3yE2AC0HiRLMG/lald5zJpWRwZ1AXoBC7MfPhIEedvgJe1Viat1hqo8eMd
         +NfB39fAK7dkNl53B1GTW+FFAHExhEMPl/znC+HgjjlwwN9U+N/MU6TQtA2QAYJA0+
         G+7pCir8ZQQ36d7OWdw2+ryw88ti8tIs6SvtoWkU=
To:     Steven Rostedt <rostedt@goodmis.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "greg@kroah.com" <greg@kroah.com>, Kees Cook <keescook@google.com>,
        "salyzyn@android.com" <salyzyn@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <753E9YR1QhdsPhsFoYuXCwfUzfyntDrc_A93hMUkktMi7lbh3KUZMcbfqKVWUfi15zYhuiDFant-ROa4QNV5shx74ff4hGngq2BOJDv-hq4=@protonmail.ch>
In-Reply-To: <20180726181558.25a5c3b8@gandalf.local.home>
References: <20180725202238.165314-1-salyzyn@android.com>
 <20180725210717.3b807191@vmware.local.home>
 <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
 <20180726153153.GA8327@kroah.com>
 <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
 <20180726181558.25a5c3b8@gandalf.local.home>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 27, 2018 12:15 AM, Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Jul 2018 09:52:11 -0700
> Nick Desaulniers ndesaulniers@google.com wrote:
>
> > See the section "Kernel addresses" in
> > Documentation/security/self-protection. IIRC, the issue is that a
> > process may have CAP_SYSLOG but not necessarily CAP_SYS_ADMIN (so it
> > can read dmesg, but not necessarily issue a sysctl to change
> > kptr_restrict), get compromised and used to leak kernel addresses,
> > which can then be used to defeat KASLR.
>
> But the code doesn't go to dmesg. It's only available
> via /sys/kernel/debug/tracing/printk_formats which is only available
> via root. Nobody else has access to that directory.
>
> -- Steve

I think the point was that when we take capabilities into account the root
privileges aren't unequivocal anymore. The 'root' owned process with only
'CAP_SYSLOG' shouldn't have access to /sys/kernel/debug/tracing/printk_form=
ats

Jordan
