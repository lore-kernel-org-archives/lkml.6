Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0288C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DDB20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfAQIUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:20:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33573 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfAQIUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:20:12 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so452257itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAQZv7n1nUktN3tlxwosRxhMI9TWhXqn4epYTY9BICg=;
        b=S3s1AXjh8VZ69d7ihWJ0JUvKY68aQZo3oa/1F/o8ZijS7xVIF4Le9GXOdfoRAAlkvi
         y02rSxDckfRKo8NPfdsuoIZxKn64Uy7SmkT7/NBgRpCAtKHehYiQ3QCqYUlOkInBeJxe
         PTEc6pB1/dP/8a0agDN4J3iJrA5bDdSJhVhik9TKyRefhH2PUssyhIuKfbT6t+4EndOV
         dUt4LzmBQs5+h4i3L7ryMKdcL1W+bG4zJUHoWbI43ZFRkXeNAA9LJRsWuPntB+klNlGI
         c6HS5dHE/lC/fxVL0jAbc2Lcn/zg8WZx91SfK+n/51GAnK08vzoUbFUBaBeS9aG3oLt5
         iX1A==
X-Gm-Message-State: AJcUukfPowHvMUVfqWEI076IgW2tg1nIE/r4Em5PH4fddozZbwd89gXu
        5QC9UJXctT62YITDSmGmjMlKHOqd5M85M7+IsOGBZGcTGRqNhQ==
X-Google-Smtp-Source: ALg8bN6KM2dPtjaz/R0+S9W32sakPD8bGs2cZz6Dbutsdpim6Ci6IjxiQy5GoGI4T/uZua8W+un47/yZ/U48Y9+4qQY=
X-Received: by 2002:a24:5fd2:: with SMTP id r201mr9035866itb.19.1547713211125;
 Thu, 17 Jan 2019 00:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com> <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic> <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic> <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190117074959.GB31097@localhost.localdomain>
In-Reply-To: <20190117074959.GB31097@localhost.localdomain>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 17 Jan 2019 16:20:00 +0800
Message-ID: <CACPcB9eXumk33=7ukrghYLwHbKyfbiQW4ZA7BhpX3hLewrdu-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 3:51 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Thu, Jan 17, 2019 at 03:41:13PM +0800, Kairui Song wrote:
> >On Wed, Jan 16, 2019 at 5:46 PM Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Wed, Jan 16, 2019 at 03:08:42PM +0800, Kairui Song wrote:
> >> > I didn't see a way to reuse things in that patch series, situation is
> >> > different, in that patch it needs to get RSDP in very early boot stage
> >> > so it did everything from scratch, in this patch kexec_file_load need
> >> > to get RSDP too, but everything is well setup so things are a lot
> >> > easier, just read from current boot_prams, efi and fallback to
> >> > acpi_find_root_pointer should be good.
> >>
> >> No no. Early code should find out that venerable RSDP thing once and
> >> will save it somewhere for further use. No gazillion parsings of it.
> >> Just once and share it with the rest of the code that needs it.
> >>
> >
> >How about we refill the boot_params.acpi_rsdp_addr if it is not valid
> >in early code, so it could be used as a reliable RSDP address source?
> >That should make things easier.
>
> I think it's OK.
> Try to read it, if get RSDP, use it.
> If not, search in EFI/BIOS/... and refill the RSDP to
> boot_params.acpi_rsdp_addr.
> By the way, I search kernel code, I didn't find other code fill and
> use it, only you(KEXEC) are trying to fill it.
> If I miss something, please let me know.

Yes, kexec would read RSDP again to pass it to second kernel, and only
if EFI is disabled (efi=noruntime/old_map, else second kernel will get
rsdp just fine). Not sure if any other component would use it.

>
> Thanks,
> Chao Fan

>

--
Best Regards,
Kairui Song
