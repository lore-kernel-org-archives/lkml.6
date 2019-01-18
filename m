Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95EAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DB220883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547799822;
	bh=K7VO4sQhq9Lz/cT7sxYUU6aQfIt/J4uyoa54bfE9ZNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tZc18TJxSVMEFg+ldxWWHpL0DHAQ8gehVH8V/Bi0LcOX0tvj/+DV72fP+RzTIWthl
	 uzTKgqakCVF9rvZH6134sQK84UNOg+S0zEHv0iF+6bBYhqlf2nXlaOy76Mmckvxsip
	 ZOqyAU3V4rN69NPjUD/LjozD6t/BlCJp8B5gaCeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfARIXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfARIXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:23:40 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D632086D;
        Fri, 18 Jan 2019 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547799819;
        bh=K7VO4sQhq9Lz/cT7sxYUU6aQfIt/J4uyoa54bfE9ZNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TJTLspX2ht0ZK6L4AV1a55UC44H7nGO+55iUj+hroq9SXpq+KKgNnz9yzNUe0BLLl
         sO5cYfS9zSBgWne1iP4RxDZhh7p4eFTobSDc8Sa1gj0DGfS9zF0DdXtxXMB+Nh9kNa
         5MoBJkbtOdUvpB3x7kOZTYjEB+K1UWoFMvvXXMgQ=
Date:   Fri, 18 Jan 2019 17:23:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "deneen.t.dock@intel.com" <deneen.t.dock@intel.com>
Subject: Re: [PATCH 17/17] module: Prevent module removal racing with
 text_poke()
Message-Id: <20190118172334.d7b1bcd580c3f6c4ed388160@kernel.org>
In-Reply-To: <B48C6E93-AD57-4FF8-BBE8-887A5E965793@vmware.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
        <20190117003259.23141-18-rick.p.edgecombe@intel.com>
        <20190117165422.d33d1af83db8716e24960a3c@kernel.org>
        <B48C6E93-AD57-4FF8-BBE8-887A5E965793@vmware.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 18:07:03 +0000
Nadav Amit <namit@vmware.com> wrote:

> > On Jan 16, 2019, at 11:54 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > On Wed, 16 Jan 2019 16:32:59 -0800
> > Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
> > 
> >> From: Nadav Amit <namit@vmware.com>
> >> 
> >> It seems dangerous to allow code modifications to take place
> >> concurrently with module unloading. So take the text_mutex while the
> >> memory of the module is freed.
> > 
> > At that point, since the module itself is removed from module list,
> > it seems no actual harm. Or would you have any concern?
> 
> So it appears that you are right and all the users of text_poke() and
> text_poke_bp() do install module notifiers, and remove the module from their
> internal data structure when they are done (*). As long as they prevent
> text_poke*() to be called concurrently (e.g., using jump_label_lock()),
> everything is fine.
> 
> Having said that, the question is whether you “trust” text_poke*() users to
> do so. text_poke() description does not day explicitly that you need to
> prevent modules from being removed.
> 
> What do you say?

I agreed, but in that case, this is just a fool proof. I think we should
prevent this kind of bug by review, and should comment it on text_poke(),
instead of locking text_mutex.

What I thought was even if we take text_mutex here, such user can modify
the (released) module code right after we exit this section.

Maybe we'd better make text_poke() more smart?

> (*) I am not sure about kgdb, but it probably does not matter much

I think we don't need to care about kgdb. It is a tool which should be able
to shoot your feet and we can not prevent it. Only expert can avoid it. :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
