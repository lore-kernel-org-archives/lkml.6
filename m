Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D39C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0E120685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TRCD+W/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0E120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbeKUFCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:02:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37708 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeKUFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:02:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so2345240oia.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 10:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCS+kDrqH7XNTHACmJZWL2qvQRk0qOfHP6zwP9JHfhs=;
        b=TRCD+W/e3YIvnsIQWqmPvIY21u60uAvxCZ2hMgRzHHkpumkwA9ftVsqL2ZLkFwFdXG
         B3r29+qOMZ+TYm13KDLshsZJ0PUiEmwYK8gwTBL2iJuZvqXd6gBXm8yswgmbwK8Fs8Da
         ObZVcnP5eqHCgvp5X3DGCPAU/lCmPex4cF5iatWT+v5ie9E8YjmJMOzQ1me1oLuwc2EV
         p1vUPbIwg106li6e3zLLOa/5KFfeRZpufsRHFIH03zzyKr7I3UB4/aQs3Z/CVhysWutW
         YmRPRX10JJRNaiKy6RGrGdwgMNO8d92QOi338pessCRAZDdHPc+OavhEbVzTd67tcHdr
         4DZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCS+kDrqH7XNTHACmJZWL2qvQRk0qOfHP6zwP9JHfhs=;
        b=p1aMqqNTIYq48RjG9Kt6prNJUauhz7n46vu3LeLLgkemdzg9IYb7uCgkfHeYh4Yg3s
         rEyYo2+G4kCq1BbvEuON/VhY35QJnd0KJwS/HTxSdxDiKPnT8XUGeRW52B0OjwLIXG+e
         fi/dz7HOK5ls+P/1aPphDcIixq1gHGY4QfyggxGOxwAyZzhqM11tLq6TQMfJiiZQ7Tk0
         qb2sYZ61D0w3dh5apCD1rR38M4nZvZWw69E1MxQJqM5/E1fkRbZJF9ArWsWHKYoPC5Km
         h3nvsUb+TPYWose0CfQFuUxXxKRpSQNZ+g5V+qDGgrgHVIfnC1d9ZO+o/tEUxBsMBTV0
         8tcQ==
X-Gm-Message-State: AGRZ1gKKnJbOPHoNZpW7JJqqmFL09LgCNJD6Jm9gQfm4dVlOnQ7LWHjo
        TYOzuAxyghMi4ZmQxa+bu7hUp4OLs47d+96z/fvWbA==
X-Google-Smtp-Source: AJdET5db7wMHPtRBlbFPHJrjv7DZ3wDwxAYtRHAWuYtEoYVvCOENEs3KJ4fGomBtwGcjaXSf0ShptsmzawrWNXWGlVM=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr1811409oih.244.1542738738981;
 Tue, 20 Nov 2018 10:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20181120103515.25280-1-mhocko@kernel.org> <20181120103515.25280-2-mhocko@kernel.org>
In-Reply-To: <20181120103515.25280-2-mhocko@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Nov 2018 10:32:07 -0800
Message-ID: <CAPcyv4j7=Mh9dt3Fv+cEhtYEXXKNDxErv0N9Zt+h+r9QxX_GAw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm, proc: be more verbose about unstable VMA
 flags in /proc/<pid>/smaps
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, adobriyan@gmail.com,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 2:35 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> From: Michal Hocko <mhocko@suse.com>
>
> Even though vma flags exported via /proc/<pid>/smaps are explicitly
> documented to be not guaranteed for future compatibility the warning
> doesn't go far enough because it doesn't mention semantic changes to
> those flags. And they are important as well because these flags are
> a deep implementation internal to the MM code and the semantic might
> change at any time.
>
> Let's consider two recent examples:
> http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz
> : commit e1fb4a086495 "dax: remove VM_MIXEDMAP for fsdax and device dax" has
> : removed VM_MIXEDMAP flag from DAX VMAs. Now our testing shows that in the
> : mean time certain customer of ours started poking into /proc/<pid>/smaps
> : and looks at VMA flags there and if VM_MIXEDMAP is missing among the VMA
> : flags, the application just fails to start complaining that DAX support is
> : missing in the kernel.
>
> http://lkml.kernel.org/r/alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com
> : Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
> : introduced a regression in that userspace cannot always determine the set
> : of vmas where thp is ineligible.
> : Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
> : to determine if a vma is eligible to be backed by hugepages.
> : Previous to this commit, prctl(PR_SET_THP_DISABLE, 1) would cause thp to
> : be disabled and emit "nh" as a flag for the corresponding vmas as part of
> : /proc/pid/smaps.  After the commit, thp is disabled by means of an mm
> : flag and "nh" is not emitted.
> : This causes smaps parsing libraries to assume a vma is eligible for thp
> : and ends up puzzling the user on why its memory is not backed by thp.
>
> In both cases userspace was relying on a semantic of a specific VMA
> flag. The primary reason why that happened is a lack of a proper
> internface. While this has been worked on and it will be fixed properly,
> it seems that our wording could see some refinement and be more vocal
> about semantic aspect of these flags as well.
>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  Documentation/filesystems/proc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 12a5e6e693b6..b1fda309f067 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -496,7 +496,9 @@ flags associated with the particular virtual memory area in two letter encoded
>
>  Note that there is no guarantee that every flag and associated mnemonic will
>  be present in all further kernel releases. Things get changed, the flags may
> -be vanished or the reverse -- new added.
> +be vanished or the reverse -- new added. Interpretatation of their meaning
> +might change in future as well. So each consumnent of these flags have to
> +follow each specific kernel version for the exact semantic.

Can we start to claw some of this back? Perhaps with a config option
to hide the flags to put applications on notice? I recall that when I
introduced CONFIG_IO_STRICT_DEVMEM it caused enough regressions that
distros did not enable it, but now a few years out I'm finding that it
is enabled in more places.

In any event,

Acked-by: Dan Williams <dan.j.williams@intel.com>
