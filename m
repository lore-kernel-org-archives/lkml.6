Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91645C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305AC270E3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ik4v2TSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305AC270E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbeF1IhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:37:11 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54650 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeF1IhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:37:07 -0400
Received: by mail-it0-f65.google.com with SMTP id 76-v6so11533980itx.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JwdvDEjDL0wO/8LVJSlLBCNIFWXwlSGt9FmhuvB1gIM=;
        b=Ik4v2TSUOdsNfBUsYqrAoBCYmlyfzBDw6N2E5U8RQxTwmfeCmFNs/5ngPG1sn+LbVW
         7t731qbA0CeTt563mkvdk8mYp/BEN0LS7Jt7TlkLKBtvIZ3Z/hwFcT3rG2GPDLqmLWX/
         UdJWfWMJsm8DAzxVA8KJzMOKoB6sfHpfpNB9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JwdvDEjDL0wO/8LVJSlLBCNIFWXwlSGt9FmhuvB1gIM=;
        b=qRKYVhLlhe/JjUEMdPdOZZxnRo9AgEX7iG1GEc2enNqqcFjm0qG71gmAJWS/90uNXO
         5X3kQXdcsEENOy6AdHZrOXrGt9/z48Y7VCXZyrbJmpG+uBAdSfDnY39YFTkt6wuoKC4M
         HBQ8yhr7c2We3A+c9QGNa/y23TM6DgmDDH4ZNmiZG2UH3Bdj/jcWZBfhmwBwjnkq2NaE
         1SKbkvX7juwkOwflk3VP93jQhS/gF/MeTNQr6Lrjgtfp99zcsC38MzFWzdFWaej8gU+z
         YYaxPGHjJrLwAf+w7jJSr8mc4/z3XttoTiV7x1XJdIeUaEFz0Ys9OFm6HOq0Ab36Jrqz
         qvHA==
X-Gm-Message-State: APt69E20qWSoVK9d4iuYhiYv2h2lU/DeD78zJX4VlCxiMXkwT7lytYVk
        TjAUXBBGX4lcxQOGfagtWwumguHwazdJMpnqRE0ZFg==
X-Google-Smtp-Source: AAOMgpeXgAg2u3S43baqKMbfaeqAgy5UAF8n0R3rEVAM737ONm1D1U43UVcb+tuda5ebXDFRq28OTmpdUGS9JVCB6X0=
X-Received: by 2002:a02:982:: with SMTP id 2-v6mr7558301jam.79.1530175026742;
 Thu, 28 Jun 2018 01:37:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e48b:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 01:37:06
 -0700 (PDT)
X-Originating-IP: [212.51.149.109]
In-Reply-To: <4365b09a-639b-2217-a49e-30f9119e4f96@redhat.com>
References: <20180626183612.321-1-hdegoede@redhat.com> <20180626183612.321-4-hdegoede@redhat.com>
 <20180628075500.GP13978@phenom.ffwll.local> <4365b09a-639b-2217-a49e-30f9119e4f96@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 28 Jun 2018 10:37:06 +0200
X-Google-Sender-Auth: it0uAyRX4cbzsM5iig76D-h2M4o
Message-ID: <CAKMK7uE3isnwSZYDT73tsZoYZMV8LUn+OjCSLbY6MtkOrbnG8A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] console/fbcon: Add support for deferred console takeover
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:20 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 28-06-18 09:55, Daniel Vetter wrote:
>>
>> On Tue, Jun 26, 2018 at 08:36:12PM +0200, Hans de Goede wrote:
>>>
>>> Currently fbcon claims fbdevs as soon as they are registered and takes
>>> over
>>> the console as soon as the first fbdev gets registered.
>>>
>>> This behavior is undesirable in cases where a smooth graphical bootup is
>>> desired, in such cases we typically want the contents of the framebuffer
>>> (typically a vendor logo) to stay in place as is.
>>>
>>> The current solution for this problem (on embedded systems) is to not
>>> enable fbcon.
>>>
>>> This commit adds a new FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER config
>>> option,
>>> which when enabled defers fbcon taking over the console from the dummy
>>> console until the first text is displayed on the console. Together with
>>> the
>>> "quiet" kernel commandline option, this allows fbcon to still be used
>>> together with a smooth graphical bootup, having it take over the console
>>> as
>>> soon as e.g. an error message is logged.
>>>
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>>
>> A bit a late comment, and feel free to reject: Have you considered
>> registering the fbcon driver, but not doing any modesets until the very
>> first real message shows up?
>
>
> I have tried something like that, but it did not work out, this patch-set
> actually is my 3th attempt at this (the other 2 were never posted
> because they did not work).
>
> The fbcon code is woven quite tightly into the console code, so this was
> the only clean way I could find to achieve what I want.

I assumed/feared as much. Would be good to cover that in the commit
message, to justify your approach better.
-Daniel

>
> Regards,
>
> Hans
>
>
>
>>> ---
>>> Changes in v2:
>>> -Check the whole string when checking for erases in putcs, instead of
>>> just
>>>   the first char
>>> -Make dummycon_blank return 1, so that a redraw gets triggered and any
>>> text
>>>   rendered while blanked gets output so that it can trigger a deferred
>>>   takeover if one is pending
>>>
>>> Changes in v3:
>>> -Call WARN_CONSOLE_UNLOCKED() from fbcon_output_notifier()
>>> -Unregister the notifier on fbcon_exit()
>>> -Document the fbcon=nodefer commandline option in
>>> Documentation/fb/fbcon.txt
>>> ---
>>>   Documentation/fb/fbcon.txt       |  7 ++++
>>>   drivers/video/console/Kconfig    | 11 +++++
>>>   drivers/video/console/dummycon.c | 67 +++++++++++++++++++++++++----
>>>   drivers/video/fbdev/core/fbcon.c | 72 ++++++++++++++++++++++++++++++++
>>>   include/linux/console.h          |  5 +++
>>>   5 files changed, 154 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
>>> index 79c22d096bbc..d4d642e1ce9c 100644
>>> --- a/Documentation/fb/fbcon.txt
>>> +++ b/Documentation/fb/fbcon.txt
>>> @@ -155,6 +155,13 @@ C. Boot options
>>>         used by text. By default, this area will be black. The 'color'
>>> value
>>>         is an integer number that depends on the framebuffer driver being
>>> used.
>>>   +6. fbcon=nodefer
>>> +
>>> +       If the kernel is compiled with deferred fbcon takeover support,
>>> normally
>>> +       the framebuffer contents, left in place by the
>>> firmware/bootloader, will
>>> +       be preserved until there actually is some text is output to the
>>> console.
>>> +       This option causes fbcon to bind immediately to the fbdev device.
>>> +
>>>   C. Attaching, Detaching and Unloading
>>>     Before going on how to attach, detach and unload the framebuffer
>>> console, an
>>> diff --git a/drivers/video/console/Kconfig
>>> b/drivers/video/console/Kconfig
>>> index 4110ba7d7ca9..e91edef98633 100644
>>> --- a/drivers/video/console/Kconfig
>>> +++ b/drivers/video/console/Kconfig
>>> @@ -150,6 +150,17 @@ config FRAMEBUFFER_CONSOLE_ROTATION
>>>            such that other users of the framebuffer will remain normally
>>>            oriented.
>>>   +config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>>> +       bool "Framebuffer Console Deferred Takeover"
>>> +       depends on FRAMEBUFFER_CONSOLE=y && DUMMY_CONSOLE=y
>>> +       help
>>> +         If enabled this defers the framebuffer console taking over the
>>> +         console from the dummy console until the first text is
>>> displayed on
>>> +         the console. This is useful in combination with the "quiet"
>>> kernel
>>> +         commandline option to keep the framebuffer contents initially
>>> put up
>>> +         by the firmware in place, rather then replacing the contents
>>> with a
>>> +         black screen as soon as fbcon loads.
>>> +
>>>   config STI_CONSOLE
>>>           bool "STI text console"
>>>         depends on PARISC && HAS_IOMEM
>>> diff --git a/drivers/video/console/dummycon.c
>>> b/drivers/video/console/dummycon.c
>>> index f2eafe2ed980..45ad925ad5f8 100644
>>> --- a/drivers/video/console/dummycon.c
>>> +++ b/drivers/video/console/dummycon.c
>>> @@ -26,6 +26,65 @@
>>>   #define DUMMY_ROWS    CONFIG_DUMMY_CONSOLE_ROWS
>>>   #endif
>>>   +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>>> +/* These are both protected by the console_lock */
>>> +static RAW_NOTIFIER_HEAD(dummycon_output_nh);
>>> +static bool dummycon_putc_called;
>>> +
>>> +void dummycon_register_output_notifier(struct notifier_block *nb)
>>> +{
>>> +       raw_notifier_chain_register(&dummycon_output_nh, nb);
>>> +
>>> +       if (dummycon_putc_called)
>>> +               nb->notifier_call(nb, 0, NULL);
>>> +}
>>> +
>>> +void dummycon_unregister_output_notifier(struct notifier_block *nb)
>>> +{
>>> +       raw_notifier_chain_unregister(&dummycon_output_nh, nb);
>>> +}
>>> +
>>> +static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
>>> +{
>>> +       dummycon_putc_called = true;
>>> +       raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
>>> +}
>>> +
>>> +static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
>>> +                          int count, int ypos, int xpos)
>>> +{
>>> +       int i;
>>> +
>>> +       if (!dummycon_putc_called) {
>>> +               /* Ignore erases */
>>> +               for (i = 0 ; i < count; i++) {
>>> +                       if (s[i] != vc->vc_video_erase_char)
>>> +                               break;
>>> +               }
>>> +               if (i == count)
>>> +                       return;
>>> +
>>> +               dummycon_putc_called = true;
>>> +       }
>>> +
>>> +       raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
>>> +}
>>> +
>>> +static int dummycon_blank(struct vc_data *vc, int blank, int
>>> mode_switch)
>>> +{
>>> +       /* Redraw, so that we get putc(s) for output done while blanked
>>> */
>>> +       return 1;
>>> +}
>>> +#else
>>> +static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
>>> { }
>>> +static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
>>> +                          int count, int ypos, int xpos) { }
>>> +static int dummycon_blank(struct vc_data *vc, int blank, int
>>> mode_switch)
>>> +{
>>> +       return 0;
>>> +}
>>> +#endif
>>> +
>>>   static const char *dummycon_startup(void)
>>>   {
>>>       return "dummy device";
>>> @@ -44,9 +103,6 @@ static void dummycon_init(struct vc_data *vc, int
>>> init)
>>>   static void dummycon_deinit(struct vc_data *vc) { }
>>>   static void dummycon_clear(struct vc_data *vc, int sy, int sx, int
>>> height,
>>>                            int width) { }
>>> -static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
>>> { }
>>> -static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
>>> -                          int count, int ypos, int xpos) { }
>>>   static void dummycon_cursor(struct vc_data *vc, int mode) { }
>>>     static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
>>> @@ -61,11 +117,6 @@ static int dummycon_switch(struct vc_data *vc)
>>>         return 0;
>>>   }
>>>   -static int dummycon_blank(struct vc_data *vc, int blank, int
>>> mode_switch)
>>> -{
>>> -       return 0;
>>> -}
>>> -
>>>   static int dummycon_font_set(struct vc_data *vc, struct console_font
>>> *font,
>>>                              unsigned int flags)
>>>   {
>>> diff --git a/drivers/video/fbdev/core/fbcon.c
>>> b/drivers/video/fbdev/core/fbcon.c
>>> index cd8d52a967aa..5fb156bdcf4e 100644
>>> --- a/drivers/video/fbdev/core/fbcon.c
>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>> @@ -129,6 +129,12 @@ static inline void fbcon_map_override(void)
>>>   }
>>>   #endif /* CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY */
>>>   +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>>> +static bool deferred_takeover = true;
>>> +#else
>>> +#define deferred_takeover false
>>> +#endif
>>> +
>>>   /* font data */
>>>   static char fontname[40];
>>>   @@ -499,6 +505,12 @@ static int __init fb_console_setup(char *this_opt)
>>>                                 margin_color = simple_strtoul(options,
>>> &options, 0);
>>>                         continue;
>>>                 }
>>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>>> +               if (!strcmp(options, "nodefer")) {
>>> +                       deferred_takeover = false;
>>> +                       continue;
>>> +               }
>>> +#endif
>>>         }
>>>         return 1;
>>>   }
>>> @@ -3100,6 +3112,9 @@ static int fbcon_fb_unregistered(struct fb_info
>>> *info)
>>>         WARN_CONSOLE_UNLOCKED();
>>>   +     if (deferred_takeover)
>>> +               return 0;
>>> +
>>>         idx = info->node;
>>>         for (i = first_fb_vc; i <= last_fb_vc; i++) {
>>>                 if (con2fb_map[i] == idx)
>>> @@ -3140,6 +3155,13 @@ static void fbcon_remap_all(int idx)
>>>         WARN_CONSOLE_UNLOCKED();
>>>   +     if (deferred_takeover) {
>>> +               for (i = first_fb_vc; i <= last_fb_vc; i++)
>>> +                       con2fb_map_boot[i] = idx;
>>> +               fbcon_map_override();
>>> +               return;
>>> +       }
>>> +
>>>         for (i = first_fb_vc; i <= last_fb_vc; i++)
>>>                 set_con2fb_map(i, idx, 0);
>>>   @@ -3191,6 +3213,11 @@ static int fbcon_fb_registered(struct fb_info
>>> *info)
>>>         idx = info->node;
>>>         fbcon_select_primary(info);
>>>   +     if (deferred_takeover) {
>>> +               pr_info("fbcon: Deferring console take-over\n");
>>> +               return 0;
>>> +       }
>>> +
>>>         if (info_idx == -1) {
>>>                 for (i = first_fb_vc; i <= last_fb_vc; i++) {
>>>                         if (con2fb_map_boot[i] == idx) {
>>> @@ -3566,8 +3593,46 @@ static int fbcon_init_device(void)
>>>         return 0;
>>>   }
>>>   +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>>> +static struct notifier_block fbcon_output_nb;
>>> +
>>> +static int fbcon_output_notifier(struct notifier_block *nb,
>>> +                                unsigned long action, void *data)
>>> +{
>>> +       int i;
>>> +
>>> +       WARN_CONSOLE_UNLOCKED();
>>> +
>>> +       pr_info("fbcon: Taking over console\n");
>>> +
>>> +       dummycon_unregister_output_notifier(&fbcon_output_nb);
>>> +       deferred_takeover = false;
>>> +       logo_shown = FBCON_LOGO_DONTSHOW;
>>> +
>>> +       for (i = 0; i < FB_MAX; i++) {
>>> +               if (registered_fb[i])
>>> +                       fbcon_fb_registered(registered_fb[i]);
>>> +       }
>>> +
>>> +       return NOTIFY_OK;
>>> +}
>>> +
>>> +static void fbcon_register_output_notifier(void)
>>> +{
>>> +       fbcon_output_nb.notifier_call = fbcon_output_notifier;
>>> +       dummycon_register_output_notifier(&fbcon_output_nb);
>>> +}
>>> +#else
>>> +static inline void fbcon_register_output_notifier(void) {}
>>> +#endif
>>> +
>>>   static void fbcon_start(void)
>>>   {
>>> +       if (deferred_takeover) {
>>> +               fbcon_register_output_notifier();
>>> +               return;
>>> +       }
>>> +
>>>         if (num_registered_fb) {
>>>                 int i;
>>>   @@ -3594,6 +3659,13 @@ static void fbcon_exit(void)
>>>         if (fbcon_has_exited)
>>>                 return;
>>>   +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>>> +       if (deferred_takeover) {
>>> +               dummycon_unregister_output_notifier(&fbcon_output_nb);
>>> +               deferred_takeover = false;
>>> +       }
>>> +#endif
>>> +
>>>         kfree((void *)softback_buf);
>>>         softback_buf = 0UL;
>>>   diff --git a/include/linux/console.h b/include/linux/console.h
>>> index dfd6b0e97855..f59f3dbca65c 100644
>>> --- a/include/linux/console.h
>>> +++ b/include/linux/console.h
>>> @@ -21,6 +21,7 @@ struct console_font_op;
>>>   struct console_font;
>>>   struct module;
>>>   struct tty_struct;
>>> +struct notifier_block;
>>>     /*
>>>    * this is what the terminal answers to a ESC-Z or csi0c query.
>>> @@ -220,4 +221,8 @@ static inline bool vgacon_text_force(void) { return
>>> false; }
>>>     extern void console_init(void);
>>>   +/* For deferred console takeover */
>>> +void dummycon_register_output_notifier(struct notifier_block *nb);
>>> +void dummycon_unregister_output_notifier(struct notifier_block *nb);
>>> +
>>>   #endif /* _LINUX_CONSOLE_H */
>>> --
>>> 2.17.1
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
