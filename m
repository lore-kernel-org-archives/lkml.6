Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957CCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491F524C8F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491F524C8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeGCL5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:57:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:54424 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeGCL5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:57:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 04:57:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="69275097"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2018 04:57:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?utf-8?Q?Jan_H=2E?= =?utf-8?Q?_Sch=C3=B6nherr?= 
        <jschoenh@amazon.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] video/console/vgacon: Print big fat warning with nomodeset
In-Reply-To: <20180703073452.GD7880@phenom.ffwll.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180702210442.18648-1-lyude@redhat.com> <20180703073452.GD7880@phenom.ffwll.local>
Date:   Tue, 03 Jul 2018 14:57:08 +0300
Message-ID: <87a7r8r0q3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jul 2018, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Mon, Jul 02, 2018 at 05:04:40PM -0400, Lyude Paul wrote:
>> It's been a pretty good while since kernel modesetting was introduced.
>> It has almost entirely replaced previous solutions which required
>> userspace modesetting, and I can't even recall any drivers off the top
>> of my head for modern day hardware that don't only support one or the
>> other. Even nvidia's ugly blob does not require the use of nomodeset,
>> and only requires that nouveau be blacklisted.
>> 
>> Effectively, the only thing nomodeset does in the year 2018 is disable
>> your graphics drivers. Since VESA is a thing, this will give many users
>> the false impression that they've actually fixed an issue they were
>> having with their machine simply because the laptop will boot up to a
>> degraded GUI. This of course, is never actually the case.
>> 
>> Things get even worse when you consider that there's still an enormous
>> amount of tutorials users find on the internet that still suggest adding
>> nomodeset, along with various users who have been around long enough to
>> still suggest it.
>> 
>> There really isn't any legitimate reason I can see for this to be an
>> option that's used by anyone else other then developers, or properly
>> informed users. So, let's end the confusion and start printing warnings
>> whenever it's enabled.
>> 
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Yeah makes tons of sense. I think we should also perhaps mark the option
> as a tainting one, but I think that's only wired up for module option.

You could do that by adding

	add_taint(TAINT_USER, LOCKDEP_STILL_OK);

in text_mode(). If you do that, you should probably amend the warning
message accordingly.

Either way,

Acked-by: Jani Nikula <jani.nikula@intel.com>

> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
>> ---
>>  drivers/video/console/vgacon.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
>> index f09e17b60e45..09731b2f6815 100644
>> --- a/drivers/video/console/vgacon.c
>> +++ b/drivers/video/console/vgacon.c
>> @@ -112,6 +112,11 @@ EXPORT_SYMBOL(vgacon_text_force);
>>  static int __init text_mode(char *str)
>>  {
>>  	vgacon_text_mode_force = true;
>> +
>> +	pr_warning("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
>> +	pr_warning("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
>> +	pr_warning("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
>> +
>>  	return 1;
>>  }
>>  
>> -- 
>> 2.17.1
>> 
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Graphics Center
