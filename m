Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318CDC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF02240C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF02240C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeF0LN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:13:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42403 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753089AbeF0LNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:13:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id g12-v6so2846218edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 04:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YUS3j8r8WhyWAKTnCxKeZ23PJXtgNlLX2Wd1sqspJ80=;
        b=ljF3bf7XhFVrD4do9KiCFLmWfQdnO+MfDbgJVl1Dgv6qkttyqzpx/ocawqid5OoPSF
         SSy3QHnPfp3cyaamSm5KYzQZg4b/I6N60+6wiNLe18h8is+t2Nx5TCQLwmmkrYOl8GV5
         tPVUG6bDeCHaVsfrFROOKaDlCrTMy8f6Zkrgo+7L6BUn7ms509rB+cHkzjw9U4YFcWBw
         HbQ2Rpm1rpARve1DbAvVro5Qf23aBGCNkpicagfmMb2CMl4BGUf52Q2ldTyKLcJX7uus
         u/gmZDl4AYhuDgO1aWRpgwKng7fgtGqoqUr+oLv8UeL8qDH7Q2E3eqLCjvCN0oxsC3aX
         rTOw==
X-Gm-Message-State: APt69E1XzY1DWCzUeZrN780szP4hdlN2XKv4bMnzao910I5FTuJZQD21
        XOsZRh72uARLdsfhqalaBsGSIzg2zuo=
X-Google-Smtp-Source: AAOMgpezWv6mVRJB2nsuUpykDkM9RWOPrbREMOOBYGJfC22ANH31APXiQT0JkiIi0DdC4dcXvLQmuw==
X-Received: by 2002:a50:d0d1:: with SMTP id g17-v6mr5249622edf.182.1530098034231;
        Wed, 27 Jun 2018 04:13:54 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c20-v6sm2362978ede.3.2018.06.27.04.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 04:13:53 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] console/fbcon: Add support for deferred console
 takeover
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180626183612.321-1-hdegoede@redhat.com>
 <CGME20180627091530epcas1p4bcb4d5421da77cd2e262e839dd50e5dc@epcas1p4.samsung.com>
 <20180627091520.GI13978@phenom.ffwll.local> <66532157.tkLS2buF0U@amdc3058>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <84977ce7-bfee-523a-852f-defc0243b520@redhat.com>
Date:   Wed, 27 Jun 2018 13:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <66532157.tkLS2buF0U@amdc3058>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27-06-18 11:47, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, June 27, 2018 11:15:20 AM Daniel Vetter wrote:
>> On Tue, Jun 26, 2018 at 08:36:09PM +0200, Hans de Goede wrote:
>>> Hi All,
>>>
>>> Here is v4 of my patch-set, to delay fbcon taking over the console (and
>>> binding to fbdev devices) until there actually is some text output to the
>>> console. This is intended for use with the "quiet" cmdline option, in
>>> combination with a bootloader which leaves the vendor's logo /
>>> EFI bootgraphics put up by the firmware intact on the EFI framebuffer.
>>>
>>> The end goal here is a boot where the firmware shows its boot graphics
>>> and these stay in place for a couple of seconds until the GUI loads and
>>> the GUI then smoothly takes over the framebuffer without any distruptions.
>>>
>>> This patch-set spans 2 subsystems.
>>>
>>> Petr, the printk subsys change is really trivial (1 line addition) can we
>>> get your Acked-by for merging all 3 patches through the fbdev tree?
>>>
>>> Changelog:
>>>
>>> Changes in v4:
>>> -Keep the comments about which fbcon functions need locks in place
>>>
>>> Changes in v3:
>>> -Export is_console_locke() for use in modules (as fbcon may be built as a .ko)
>>> -Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to assert
>>>   proper locking (requested by Daniel)
>>> -Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by Daniel)
>>> -Document the fbcon=nodefer commandline option (req. by Emil)
>>>
>>> Changes in v2:
>>> -Check the whole string when checking for erases in putcs, instead of just
>>>   the first char
>>> -Make dummycon_blank return 1, so that a redraw gets triggered and any text
>>>   rendered while blanked gets output so that it can trigger a deferred
>>>   takeover if one is pending
>>
>> Wrt merging I think it'd be best if we stuff this into drm-misc-next -
>> that will increase testing by gpu drivers a lot, instead of a suprise when
>> the fbdev pull lands in upstream.
>>
>> Bart, is that ok with you?
> 
> Not really, since there are efifb changes in the queue which depend
> on this series I would really prefer to merge all patches through
> fbdev tree.
> 
> Also fbdev tree is pulled into -next kernels so testing coverage
> should be okay (I assume that everybody are testing -next kernels in
> addition to their own branches :-)..

If you are talking about the "efifb: Copy the ACPI BGRT boot graphics to the
framebuffer" series, I could push those to drm-misc-next too (once acked).

I think most GPU driver developers are running drm-tip and not
-next, so putting things in drm-misc-next would give the changes somewhat
more test-exposure on a wider range of GPUs I believe. Where as -next
testing will likely be more server use-case oriented.

Alternatively you could merge things in the fbdev tree, do an
unmutable branch and then that could be merged into drm-misc-next by
the drm-misc-next maintainers.

Note either way is fine with me. This is up to you and Daniel.

Regards,

Hans
