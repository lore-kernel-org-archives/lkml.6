Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6896C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624EB20858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624EB20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeIYXxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:53:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:47545 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeIYXxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:53:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 10:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="89261248"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga002.fm.intel.com with ESMTP; 25 Sep 2018 10:44:32 -0700
Message-ID: <49b082c828e3f6772094f44a93d07040d4970c64.camel@intel.com>
Subject: Re: [PATCH] binfmt_elf: Fix core dump memory corruption
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Oleg Nesterov <oleg@redhat.com>
Date:   Tue, 25 Sep 2018 10:39:58 -0700
In-Reply-To: <20180717162502.32274-1-yu-cheng.yu@intel.com>
References: <20180717162502.32274-1-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 09:25 -0700, Yu, Yu-cheng wrote:
> In fill_note_info(), we kzalloc elf_thread_core_info.notes[] only
> for (core_note_type != 0) regsets.  However, in
> fill_thread_core_info(), we still leave empty notes and go beyond
> the allocated size.  Fix it.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  fs/binfmt_elf.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 816cc921cf36..6f42e05d2833 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1723,7 +1723,8 @@ static int fill_thread_core_info(struct
> elf_thread_core_info *t,
>                                  const struct user_regset_view *view,
>                                  long signr, size_t *total)
>  {
> -       unsigned int i;
> +       unsigned int i; /* index to regsets */
> +       unsigned int j; /* index to notes */
>         unsigned int regset0_size = regset_size(t->task, &view->regsets[0]);
> 
>         /*
> @@ -1744,9 +1745,9 @@ static int fill_thread_core_info(struct
> elf_thread_core_info *t,
> 
>         /*
>          * Each other regset might generate a note too.  For each regset
> -        * that has no core_note_type or is inactive, we leave t->notes[i]
> -        * all zero and we'll know to skip writing it later.
> +        * that has no core_note_type or is inactive, we skip it.
>          */
> +       j = 1;
>         for (i = 1; i < view->n; ++i) {
>                 const struct user_regset *regset = &view->regsets[i];
>                 do_thread_regset_writeback(t->task, regset);
> @@ -1763,17 +1764,18 @@ static int fill_thread_core_info(struct
> elf_thread_core_info *t,
>                                 kfree(data);
>                         else {
>                                 if (regset->core_note_type != NT_PRFPREG)
> -                                       fill_note(&t->notes[i], "LINUX",
> +                                       fill_note(&t->notes[j], "LINUX",
>                                                   regset->core_note_type,
>                                                   size, data);
>                                 else {
>                                         SET_PR_FPVALID(&t->prstatus,
>                                                         1, regset0_size);
> -                                       fill_note(&t->notes[i], "CORE",
> +                                       fill_note(&t->notes[j], "CORE",
>                                                   NT_PRFPREG, size, data);
>                                 }
> -                               *total += notesize(&t->notes[i]);
> +                               *total += notesize(&t->notes[j]);
>                         }
> +                       j++;
>                 }
>         }
> 
> --
> 2.17.1
> 

Hi All,

Any comments on this?

Thanks,
Yu-cheng

