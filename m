Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F0FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E99220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0Xys081"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E99220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbeKHBlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:41:04 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39655 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbeKHBlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:41:03 -0500
Received: by mail-vk1-f194.google.com with SMTP id o10-v6so3817674vki.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WygdfWgc82JLORm6/ybR+mPW6gq6639PAYDpVjtVbrQ=;
        b=e0Xys081855tteOPeAQ63WgrsEJPcuAfBlonEt+hCPRp6wBEAx78wdpi2Yef9Z65Qq
         R+g2L7t0lIVcpiEUZM4bPsVT9vdD0nXKEaY2R/RWYe0CY3DPdMJScXU7eezjOD6CF5pr
         XLcNI39Gw6XSnVl+foX3oPS4yMcf62El1IX2EoOHsgSkzXe+Ki0iG6Xyl3COuGxg3rM6
         1RenVa4I2+953BxSZfHNR/MoIgLsRfX5ADNBUwjWhHOQbo6g9QXuQrEkOTkiVDhEAyvp
         1IE5hIIRDW0QwnqNhh9Y2N+DW7yVHBcM0bhLazuuNJAQrqBVJAEOP2b2GPoytZ3NiGL+
         hAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WygdfWgc82JLORm6/ybR+mPW6gq6639PAYDpVjtVbrQ=;
        b=LxckL1ukINAWS98VwAcsvAokqVZR1t+wWII/aPYqj4nJIpRYetjoHLsI9Anc9IFBfU
         eJ357YtMjHpPEHhnDnbE59b5veyEwXjfRF+HTaoro0Lr022YdPKiYBERPDAlIr3ajd4v
         2J21sPZ/N5V1POt364jY6dBAo0We1puxLheUARcn84JVg500higkyFxagT997rxZqIjX
         Wls8uM3wBtuHpL3GHsb3GPAvTvts3IQ5+FTkCfgBEpTwFFikBAMumpBvatjBOp8mYN/X
         2vrq5LDgcEQw4vf5DRstd7LC0ujjtSzSnXfCisT4wjnthDeNVxVnXwX6bzkWqgLDaO6Q
         BkoA==
X-Gm-Message-State: AGRZ1gJsO2p0ooKKVSHXXSXfQHAFkXsvkEjBq3Iv8SJG7ZXwUcX/jdlf
        NnsbO0LlOy7cu+lAxhCUSryulnZLw2XwhiQQ2IuqHA==
X-Google-Smtp-Source: AJdET5eg7Y/m+5hFooFEA0LYZih92J8o1ZZqUAkuObhj6foTrtam/KnC2SSznNfJlScOnz/EQngLIYADAoL2cJToik4=
X-Received: by 2002:a1f:7cca:: with SMTP id x193mr335348vkc.89.1541607002114;
 Wed, 07 Nov 2018 08:10:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 08:10:01 -0800 (PST)
In-Reply-To: <20181107160015.GI27423@dhcp22.suse.cz>
References: <20181031150625.147369-1-dancol@google.com> <20181105132205.138695-1-dancol@google.com>
 <20181106130524.GC2453@dhcp22.suse.cz> <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
 <20181107160015.GI27423@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 7 Nov 2018 16:10:01 +0000
Message-ID: <CAKOZuevb-MED0QiL5RWJ0py=yt48=N7bPSq5bFqiwWcqN9L=Xg@mail.gmail.com>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, rppt@linux.ibm.com,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 4:00 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 07-11-18 15:48:20, Daniel Colascione wrote:
>> On Tue, Nov 6, 2018 at 1:05 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> > otherwise anybody could simply DoS the system
>> > by consuming all available pids.
>>
>> People can do that today using the instrument of terror widely known
>> as fork(2). The only thing standing between fork(2) and a full process
>> table is RLIMIT_NPROC.
>
> not really.

What else, besides memory consumption and (as you mention below)
cgroups? In practice, nobody uses RLIMIT_NPROC, so outside of various
container-y namespaced setups, avoidance of
system-DoS-through-PID-exhaustion isn't a pressing problem.

If you really do care about pid space depletion then you
> should use pid cgroup controller.

Or that, sure. But since cgroups are optional, the problem with the
core model remains. In general, if there's a problem X with the core
system API, and you can mitigate X by using a cgroup, X is still a
problem.
