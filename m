Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161311AbeEXV1X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:27:23 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46495 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033204AbeEXV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:27:21 -0400
X-Google-Smtp-Source: AB8JxZo0UA+S8vAFGwVZWOpnm8Y7OZcyXb1VC+rzVZVizW4GSAHuVwPS/8uZY5crk8ipr7cXHEt0tQSNowOZVzDp7pM=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <CAKwvOdmQER7XtO_uygYDBxGgUr-EruGyjUq9DMbNwQFh11=9gg@mail.gmail.com> <CAKwvOdkd480hmHduDHnV2ekoAm_dyPnApU9jc7TARyD072KOGA@mail.gmail.com>
In-Reply-To: <CAKwvOdkd480hmHduDHnV2ekoAm_dyPnApU9jc7TARyD072KOGA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 24 May 2018 14:27:08 -0700
Message-ID: <CAKwvOdnKo4k_Q7dRF0vSq7FuwiDsy3hdx9kPvrgMrb5pV_nS2Q@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 2:12 PM Nick Desaulniers <ndesaulniers@google.com>
wrote:
> On Thu, May 24, 2018 at 1:52 PM Nick Desaulniers <ndesaulniers@google.com>
> wrote:
> > On Thu, May 24, 2018 at 1:26 PM Nick Desaulniers <
ndesaulniers@google.com>
> > wrote:
> > > On Thu, May 24, 2018 at 11:59 AM <hpa@zytor.com> wrote:
> > > > Issue 3: Let's face it, reading and writing the flags should be
> > builtins,
> > > exactly because it has to do stack operations, which really means the
> > > compiler should be involved.

> > > I'm happy to propose that as a feature request to llvm+gcc.

> > Oh, looks like both clang and gcc have:
> > __builtin_ia32_readeflags_u64()

> > https://godbolt.org/g/SwPjhq

> > Maybe native_save_fl() and native_restore_fl() should be replaced in the
> > kernel with
> > __builtin_ia32_readeflags_u64() and __builtin_ia32_writeeflags_u64()?
> > --
> > Thanks,
> > ~Nick Desaulniers

> Looks like those builtins got added to GCC around the 4.9 timeframe:
> https://godbolt.org/g/9VS2E9

> Problematically, it seems that GCC does not have __has_builtin to do
> feature detection:

https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros
> https://godbolt.org/g/oku8ux

Is there a more canonical way the kernel does feature detection that looks
better than:

diff --git a/arch/x86/include/asm/irqflags.h
b/arch/x86/include/asm/irqflags.h
index 89f08955fff7..90974b5d023c 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -13,6 +13,8 @@
   * Interrupt control:
   */

+#ifdef GCC_VERSION
+#if GCC_VERSION < 40900
  static inline unsigned long native_save_fl(void)
  {
         unsigned long flags;
@@ -38,6 +40,17 @@ static inline void native_restore_fl(unsigned long flags)
                      :"g" (flags)
                      :"memory", "cc");
  }
+#else
+static inline unsigned long native_save_fl(void)
+{
+       return __builtin_ia32_readeflags_u64();
+}
+static inline void native_restore_fl(unsigned long flags)
+{
+       __builtin_ia32_writeeflags_u64(flags);
+}
+#endif
+

  static inline void native_irq_disable(void)
  {

-- 
Thanks,
~Nick Desaulniers
