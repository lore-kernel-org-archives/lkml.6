Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeDTVvV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:51:21 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35345 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeDTVvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:51:19 -0400
X-Google-Smtp-Source: AIpwx48SejwKlq5tfb7mGBKpbUEP6MZhC+hyTIa6rcnpqu7MuQnrTlN+LiIGGoLKlNhaK8eJD7waN/PPEO+aLNYO2Qo=
MIME-Version: 1.0
In-Reply-To: <20180420154933.3235131-4-arnd@arndb.de>
References: <20180420154933.3235131-1-arnd@arndb.de> <20180420154933.3235131-4-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 23:51:18 +0200
X-Google-Sender-Auth: ovDKP8fYwUz9vEAUhC5cRzS80AI
Message-ID: <CAK8P3a2vh+BH_GJSPkc8D61+J2NK_e_HWJkuz6DVmb_Ln6ND0Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] sh: remove board_time_init() callback
To: Rich Felker <dalias@libc.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 5:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> @@ -41,8 +39,7 @@ static void __init sh_late_time_init(void)
>
>  void __init time_init(void)
>  {
> -       if (board_time_init)
> -               board_time_init();
> +       timer_init();

Testing revealed this to be broken, the fix is:

diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index a29eb989d81b..8a1c6c8ab4ec 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -39,7 +39,7 @@ static void __init sh_late_time_init(void)

 void __init time_init(void)
 {
- timer_init();
+ timer_probe();

  clk_init();

Let me know if you'd like me to resend the series with that typo fixed.

      Arnd
