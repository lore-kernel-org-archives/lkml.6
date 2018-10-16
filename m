Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67A6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EFB2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EFB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJPTih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:38:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:12157 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPTih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:38:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 04:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="99622796"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2018 04:48:30 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] drm/i915: Silence build error with UBSAN
In-Reply-To: <153968444736.22931.7687263957265816381@skylake-alporthouse-com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181015203410.155997-1-swboyd@chromium.org> <87sh16ky9d.fsf@intel.com> <153968444736.22931.7687263957265816381@skylake-alporthouse-com>
Date:   Tue, 16 Oct 2018 14:48:13 +0300
Message-ID: <87murekt8i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Quoting Jani Nikula (2018-10-16 10:59:42)
>> diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
>> index f27dbe26bcc1..897d5a557d88 100644
>> --- a/drivers/gpu/drm/i915/intel_engine_cs.c
>> +++ b/drivers/gpu/drm/i915/intel_engine_cs.c
>> @@ -461,12 +461,14 @@ static void intel_engine_init_batch_pool(struct intel_engine_cs *engine)
>>         i915_gem_batch_pool_init(&engine->batch_pool, engine);
>>  }
>>  
>> +#define IS_POWER_OF_2(n) ((n) != 0 && ((n) & ((n) - 1)) == 0)
>> +
>>  static void intel_engine_init_execlist(struct intel_engine_cs *engine)
>>  {
>>         struct intel_engine_execlists * const execlists = &engine->execlists;
>>  
>>         execlists->port_mask = 1;
>> -       BUILD_BUG_ON_NOT_POWER_OF_2(execlists_num_ports(execlists));
>> +       GEM_BUG_ON(!IS_POWER_OF_2(execlists_num_ports(execlists)));
>
> That should be happy with is_power_of_2() from log2.h

D'oh. Thanks. I was sure there was one, I looked for it, but my git
greps were all upper case. :/

I'll spin a new version, along with the other clang build fix.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
