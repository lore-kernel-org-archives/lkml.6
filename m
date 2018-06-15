Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E894FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C76208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="UyvDaBgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C76208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936368AbeFORQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:16:45 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40134 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936136AbeFORQo (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:16:44 -0400
Received: by mail-ua0-f193.google.com with SMTP id l11-v6so6874315uak.7
        for <Linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QYIzPrjeiyNxAK55dmln+/7Ms6ycCLA5IMAYzGHiFog=;
        b=UyvDaBgUVttfGcxEymF8uxasqYv1TanudnixRDSncDaYfOdQNzHc3agPbyjshSzfvi
         5yxSl0ovaSu0oXyalwxv//ZR+JnefFit4ziltMTaeSaVZgW/SeCELSr/5U0k3qY8x44p
         aVujdvcqLiRp0ry7UWxEeeEiaWU2/oP5CaWElx0D9ejbONDHLXsMytjQc10crma6nUwu
         ZaYfTOzo1s/0bdlzLD6JOoR8fiMMPuTyO/+4Rrry5nRGdE3FeQrvmFkNjaAyfYh+ZzCQ
         Zu7aIuLrexVdT+vNEFBEnYPXzocBrvzrIXtYKx9TW/bEVUbNkeo68K72s5V3gOa1EeXx
         +FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QYIzPrjeiyNxAK55dmln+/7Ms6ycCLA5IMAYzGHiFog=;
        b=ssQkeRlWj8TgniFADV8F5yY6HHS4tImOy6dPQtxzA7jCkM2KY3IcjDvUsKPElJ7s4z
         JwC00doke9zcgzuCyvglWBfChEVQOSzQicePySHLpBd74YWV5nV4CiKwEc0xD3fXGmJx
         8kfubK09bJJgq7FM75bg4TMoPO9lLX+QXdqO7vUWKGryjZnKwC5RoLIQMcHWliTJfk3Q
         EG0veTw+FrsVFHU8IqxBAufk7l95lVAoK8lD2+WdBSlN1cin46ZUCmRkS7D5PRV1TRfO
         KQer6oeK3lEv1mmfmnyiQjW+XHJzmUW1DLEtP61P6JujFnHDypYiH74Tx7AMY3ETt2k8
         h2rw==
X-Gm-Message-State: APt69E1+H1qUtDSMHisiE8Ho8sHUy9TaUGEJWW3ZfnxEHdxq7H4EmZvX
        5EOs27PGYl+EYA5elI8Hb+uH02JWx4c2qyxtQi77SA==
X-Google-Smtp-Source: ADUXVKKIzFWufNOgI0egfiRc+0F+oIb+3IpweN7FeHF15uPBIH5WSVCkS+ljk7+i+bSw5ZCLflLl70IA+Xi2bh8qkX4=
X-Received: by 2002:ab0:5dd0:: with SMTP id l16-v6mr1668074uag.115.1529083003456;
 Fri, 15 Jun 2018 10:16:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:11c9:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 10:16:42
 -0700 (PDT)
In-Reply-To: <1a442b37-7a97-86f0-11e3-58d940ecfbc9@linux.intel.com>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <CAP045Aq_FEc_pEeRL86uXbOLBeW7aPvTqtnaq+Mbi-2=vp2BNA@mail.gmail.com> <1a442b37-7a97-86f0-11e3-58d940ecfbc9@linux.intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Fri, 15 Jun 2018 10:16:42 -0700
Message-ID: <CAP045ApFKUqUUf76GtWyxpYWdWe1RxYkPm1R2kUxaQyc4Fhucg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        open list <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:11 PM, Jin, Yao <yao.jin@linux.intel.com> wrote:
>
>
> On 6/15/2018 11:35 AM, Kyle Huey wrote:
>>
>> I strongly object to this patch as written. As I said when I
>> originally reported[0] the regression introduced by the previous
>> version of this patch a year ago.
>>
>> "It seems like this change should, at a bare minimum, be limited to
>> counters that actually perform sampling of register state when the
>> interrupt fires.  In our case, with the retired conditional branches
>> counter restricted to counting userspace events only, it makes no
>> difference that the PMU interrupt happened to be delivered in the
>> kernel."
>>
>> This means identifying which values of `perf_event_attr::sample_type`
>> are security concerns (presumably PERF_SAMPLE_IP is, and
>> PERF_SAMPLE_TIME is not, and someone needs to go through and decide on
>> all of them) and filtering on those values for this new behavior.
>>
>> And because rr sets its sample_type to 0, once you do that, the sysctl
>> will not be necessary.
>>
>> - Kyle
>>
>
> Since rr sets sample_type to 0, the easiest way is to add checking like:
>
> if (event->attr.sample_type) {
>         if (event->attr.exclude_kernel && !user_mode(regs))
>                 return false;
> }
>
> So the rr doesn't need to be changed and for other use cases the leaked
> kernel samples will be dropped.
>
> But I don't like this is because:
>
> 1. It's too specific for rr case.

Keeping existing software working is the first rule of kernel development!

There is no disclosure of kernel space state in the way rr uses this
API, so there is no reason that this API should not keep working.

> 2. If we create a new sample_type, e.g. PERF_SAMPLE_ALLOW_LEAKAGE, the code
> will be:
>
> if !(event->attr.sample_type & PERF_SAMPLE_ALLOW_LEAKAGE) {
>         if (event->attr.exclude_kernel && !user_mode(regs))
>                 return false;
> }
>
> But rr needs to add PERF_SAMPLE_ALLOW_LEAKAGE to sample_type since by
> default the bit is not set.

There's no reason to add a new PERF_SAMPLE flag. You need to audit the
*existing* PERF_SAMPLE flags and figure out which ones are problems,
and then do

if (event->attr.exclude_kernel && !user_mode(regs) &&
sampling_discloses_kernel_information(event->attr.sample_type)) {
    return false;
}

> 3. Sysctl is a more flexible way. It provides us with an option when we want
> to see if skid is existing, we can use sysctl to turn on that.

If you want a sysctl for your own reasons that's fine. But we don't
want a sysctl. We want to work without any further configuration.

> Thanks
> Jin Yao
>

- Kyle
