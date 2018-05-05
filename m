Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeEECpd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751709AbeEECpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:45:31 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <0066b4db-8da6-007d-780d-a8ffc4884ad0@st.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>
References: <1525329609-7291-1-git-send-email-gabriel.fernandez@st.com>
 <0066b4db-8da6-007d-780d-a8ffc4884ad0@st.com>
Message-ID: <152548833044.138124.7516235724401510636@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RESEND PATCH] clk: stm32: fix: stm32 clock drivers are not compiled by
 default
Date: Fri, 04 May 2018 19:45:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w452jc8b032006

Quoting Alexandre Torgue (2018-05-04 00:54:16)
> Stephen
> 
> On 05/03/2018 08:40 AM, gabriel.fernandez@st.com wrote:
> > From: Gabriel Fernandez <gabriel.fernandez@st.com>
> > 
> > Clock driver is mandatory if the machine is selected.
> > Then don't use 'bool' and 'depends on' commands, but 'def_bool'
> > with the machine(s).
> > 
> > Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")
> > 
> 
> Sorry to insist but we need it to have STM32 MCUs booting on Kernel v4.17.

Thanks for the bump. I missed this one. Of course, the user can still select
the configs now, just it's annoying for upgrade path.

> 
> > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> > Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> > ---
> >   drivers/clk/Kconfig | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 24a5bc3..721572a 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -266,15 +266,13 @@ config COMMON_CLK_STM32MP157
> >         Support for stm32mp157 SoC family clocks
> >   
> >   config COMMON_CLK_STM32F
> > -     bool "Clock driver for stm32f4 and stm32f7 SoC families"
> > -     depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
> > +     def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746)

But the point of the change this patch is fixing was to expose these to
the user to turn off they wanted. You'll need to do something like that
again here, instead of removing the prompt and replacing it with a
def_bool.

So this patch instead? It leaves it around for the whole arch, but
limits the default to be the machines that matter. I suppose we could
put an 'if EXPERT' on the bool part too if we don't even want to expose
the options to normal users.

-----8<-----
From: Gabriel Fernandez <gabriel.fernandez@st.com>
Date: Thu, 3 May 2018 08:40:09 +0200
Subject: [PATCH] clk: stm32: fix: stm32 clock drivers are not compiled by
 default
Cc: <linux-kernel@vger.kernel.org>,
    <linux-arm-kernel@lists.infradead.org>

Clock driver is mandatory if the machine is selected. Add a default
of the machines that need the clk driver, so that the user can turn it
off if they want, but otherwise it's exposed on the SoCs the driver
is for.

Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 41492e980ef4..ac3f0e2bc03f 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -267,15 +267,16 @@ config COMMON_CLK_STM32MP157
 
 config COMMON_CLK_STM32F
 	bool "Clock driver for stm32f4 and stm32f7 SoC families"
-	depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
+	depends on ARCH_STM32
+	default MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
 	help
 	---help---
 	  Support for stm32f4 and stm32f7 SoC families clocks
 
 config COMMON_CLK_STM32H7
 	bool "Clock driver for stm32h7 SoC family"
-	depends on MACH_STM32H743
-	help
+	depends on ARCH_STM32
+	default MACH_STM32H743
 	---help---
 	  Support for stm32h7 SoC family clocks
 
-- 
Sent by a computer through tubes
