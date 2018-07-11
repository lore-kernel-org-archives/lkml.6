Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D01C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDEC20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDEC20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbeGKPkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:40:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37592 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387715AbeGKPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:40:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so3050593wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 08:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5TGP06p4Xb2WjbByr7qMSLuRki2xuFpG+jWITW2blW0=;
        b=QLUf+kugV9m90jvuXWB9tzLVf5T4A4yeI5PzXm46eRq6WuJRXHZqgGZt7AhiktN/7L
         0U+F6ZTYkwWGmqukFtjZNrDfFlCqwJlnSo0ZMSd18L838LtGcaY8YNiuRwl0nzpCIhzL
         75iVa06nm3gbYO1+LP5viNIyDE1Sagtq54OM0TvAAOH36zIrV9xXfrzNeN7zHo/9BInw
         Bu4UyuYmRSUlROcvRuUYIYOd7RZgevfnsxizMLYG12j30jm/9JY+u6a97RZN4hIXCu3I
         u35eSwlR0JrqGUQ++KNj9exQLL4/DvhdC5fTkfWJlZWC03NgcCJBv06vM3pr23GdwQv9
         hxBg==
X-Gm-Message-State: APt69E3TJXyAbp4dT0B3lrBoW3VQDjbW88wtyIVkljKh/NOUjSRj4RS2
        XwlM037CZtMm0af9jreBGvP1poE2cLs=
X-Google-Smtp-Source: AAOMgpdkJyBpB1bwYu8f6+lTRB1PSFs61EfZArKhgmm8MOywuJ3yrreMucloI2/RGFKOf2bqv8lhZw==
X-Received: by 2002:a1c:894f:: with SMTP id l76-v6mr17290611wmd.103.1531323312095;
        Wed, 11 Jul 2018 08:35:12 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l15-v6sm1749121wrt.67.2018.07.11.08.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 08:35:11 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
 <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
Date:   Wed, 11 Jul 2018 17:35:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-07-18 17:28, Daniel Vetter wrote:
> On Wed, Jul 11, 2018 at 5:14 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 11-07-18 17:07, Thomas Zimmermann wrote:
>>>
>>> Hi
>>>
>>> Am 11.07.2018 um 16:52 schrieb Steven Rostedt:
>>>>
>>>>
>>>> What if you make lockless_register_fb visible to fbcon, and then we can
>>>> have a macro:
>>>
>>>
>>> There are more of these macro invocations under drivers/tty/vt, which
>>> also mess up the log during debugging.
>>
>>
>> Hmm, so this option is already broken (in a way) then, my first reaction
>> to your mail was that we should just remove that option. But that seemed
>> a bit harsh to me so I've been working on a fix for the last 10 minutes
>> or so.
>>
>> But if it is already broken I'm tempted to just remove the option and
>> be done with it.  We really need less cruft in the fbdev/fbcon code not
>> more.
> 
> Please don't remove it, it makes debugging kms driver issues on
> initial modeset (which is usually run from framebuffer_register, while
> hodling the console_lock) impossible.

OK, so if we don't remove it, we should probably make it so that it
can be used without triggering any WARN_ONs, which would require changing
the existing WARN_CONSOLE_UNLOCKED() so that the calls from drivers/tty/vt/vt.c
also do not trigger it ?

I guess one can just ignore the oopses when debugging, but debugging surely
would be easier if there are just no oopses ?

Regards,

Hans




> -Daniel
> 
>>> WARN_CONSOLE_UNLOCKED is already protected by an '#ifdef 1 ... #else
>>> ...' construct [1]. I thought about turning this into a config option.
>>
>>
>> Ah I noticed the #if but I did not notice that it was a "#if 1".
>>
>> If you want to fix lockless_register_fb it really should be replaced
>> with a runtime check, not a Kconfig option. This would require having
>> some lockless variable in the console code itself, which then gets
>> set by the fbdev code during init based on its lockless_register_fb
>> setting.
>>
>> But as said I think we should seriously consider just removing
>> lockless_register_fb.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>
>>
>>
>>>
>>> Best regards
>>> Thomas
>>>
>>> [1]
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/console.h#n203
>>>
>>>>
>>>> #define WARN_FB_CONSOLE_UNLOCKED()                      \
>>>>          do {                                            \
>>>>                  if (unlikely(!lockless_register_fb))    \
>>>>                          WARN_CONSOLE_UNLOCKED();        \
>>>>          } while (0)
>>>>
>>>> And use that instead?
>>>>
>>>> -- Steve
>>>>
>>>>
>>>>> Best regards
>>>>> Thomas
>>>>>
>>>>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>>>> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>> ---
>>>>>> Changes in v3:
>>>>>> -New patch in v3 of this patchset
>>>>>>
>>>>>> Changes in v4:
>>>>>> -Keep the comments about which fbcon functions need locks in place
>>>>>> ---
>>>>>>    drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>>>>>>    1 file changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/video/fbdev/core/fbcon.c
>>>>>> b/drivers/video/fbdev/core/fbcon.c
>>>>>> index c910e74d46ff..cd8d52a967aa 100644
>>>>>> --- a/drivers/video/fbdev/core/fbcon.c
>>>>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>>>>> @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, int
>>>>>> user)
>>>>>>          struct fb_info *oldinfo = NULL;
>>>>>>          int found, err = 0;
>>>>>>    +     WARN_CONSOLE_UNLOCKED();
>>>>>> +
>>>>>>          if (oldidx == newidx)
>>>>>>                  return 0;
>>>>>>    @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
>>>>>>    {
>>>>>>          int i, new_idx = -1, ret = 0;
>>>>>>    +     WARN_CONSOLE_UNLOCKED();
>>>>>> +
>>>>>>          if (!fbcon_has_console_bind)
>>>>>>                  return 0;
>>>>>>    @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info
>>>>>> *info)
>>>>>>    {
>>>>>>          int i, idx;
>>>>>>    +     WARN_CONSOLE_UNLOCKED();
>>>>>> +
>>>>>>          idx = info->node;
>>>>>>          for (i = first_fb_vc; i <= last_fb_vc; i++) {
>>>>>>                  if (con2fb_map[i] == idx)
>>>>>> @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info
>>>>>> *info)
>>>>>>    static void fbcon_remap_all(int idx)
>>>>>>    {
>>>>>>          int i;
>>>>>> +
>>>>>> +       WARN_CONSOLE_UNLOCKED();
>>>>>> +
>>>>>>          for (i = first_fb_vc; i <= last_fb_vc; i++)
>>>>>>                  set_con2fb_map(i, idx, 0);
>>>>>>    @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info
>>>>>> *info)
>>>>>>    {
>>>>>>          int ret = 0, i, idx;
>>>>>>    +     WARN_CONSOLE_UNLOCKED();
>>>>>> +
>>>>>>          idx = info->node;
>>>>>>          fbcon_select_primary(info);
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
