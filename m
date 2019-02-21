Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0640C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930BA2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550727867;
	bh=dr82F3FA3lls3wRAHDYEvzMuw7aMo2xYE79NELAuGRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uxexCI3MmftmU/UT5ZYC206gFmUkpUFJ5EbJbf6oiQwedw/GtzHIT7yuHSS0aUGOy
	 eskdhLfjebpKuErt/e+69w/FtfIF/BRvWOqOj1clO1JHaD4XWt5z5J6hHKHfbWzy8k
	 fB5fhti2q8QqTejkUpgoWsM8i4iPHvrO37QcIX7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfBUFoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:44:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33434 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfBUFoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:44:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id c55so4282769edb.0;
        Wed, 20 Feb 2019 21:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAiUTh5C3KVRnAHSSCluCo8bp+b0QIp4Uk1XhqYvfIk=;
        b=RESPUi4Hb5mq86icM2In28cOekskMUNCFioCXzL0Jv8TCB6HclmJtmQtNgtZXTL0yW
         yZmxHvrntFBDyTSPGkY2Ud6sSEvJENhKEP9Wx6ZqA4pU0QKdLPhwnZABT61hUul5MOke
         sFwxRFNvUIsFSrAuFFb5r4L08DgmCwq282JKYUGS/q50rQk6sG+flhXJTr55OsmImjja
         s7Eqa6QmfygF3SSxf4kCDI1Guc6kU968CcqJJA8QdO4SFse5LLHfAAm60nZBiWuS1sHP
         35cPBvSIetGcLUaxcfuNhhiJsePoONzasunHMLrybGtmlhOvG4dATrKYFXJdpJQ07bZO
         H90w==
X-Gm-Message-State: AHQUAuZSknMVPfPlTKv+K+Emrxg4PnicPGTU87u0ujLY1kIbPlXfSr3g
        EL2Z6WFJjE+5T8cto+iXYDDYe1Ju3HOHfkPeUhc=
X-Google-Smtp-Source: AHgI3IbqtZgHEZit/zBK8nFQRO8UbTLQjPnZz6LM8+vVBhNHd9HZ9gqMLzvEgU3P0EXoi63cRPNc0rKz54PUqtUmdPo=
X-Received: by 2002:a17:906:e2d4:: with SMTP id gr20mr2558488ejb.210.1550727862949;
 Wed, 20 Feb 2019 21:44:22 -0800 (PST)
MIME-Version: 1.0
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com> <20190220110200.GD17969@hirez.programming.kicks-ass.net>
In-Reply-To: <20190220110200.GD17969@hirez.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 21 Feb 2019 00:44:11 -0500
Message-ID: <CAJvTdKnpOdDiCaW9ntkNof+Ji7+HPaQqEk=ou-hWnw-BJxMGTQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] powercap/intel_rapl: Support multi-die/package
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 6:02 AM Peter Zijlstra <peterz@infradead.org> wrote:

> >       list_for_each_entry(rp, &rapl_packages, plist) {
> > @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
> >  /* called from CPU hotplug notifier, hotplug lock held */
> >  static struct rapl_package *rapl_add_package(int cpu)
> >  {
> > -     int id = topology_physical_package_id(cpu);
> > +     int id = topology_unique_die_id(cpu);
> >       struct rapl_package *rp;
> >       int ret;
>
> And now your new function names are misnomers.

That is fair.

Seems that a subsequent re-name-only patch is appropriate.

Len Brown, Intel Open Source Technology Center
