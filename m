Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DB5E9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D49204EE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D49204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeFLH1a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:27:30 -0400
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:28267
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932944AbeFLH13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:27:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DQAAAXdR9b/zSOqnwNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGFTIN3lTABAQEBAQEGgQUpllOEdwKDBDgUAQIBAQEBAQEChj4BAQE?=
 =?us-ascii?q?DIxVBEAsNCwICJgICVwYBDAYCAQGDHoF0qW1tghwag2ABhEyBaIELiEmBB4EPJ?=
 =?us-ascii?q?IJoh3OCVQKZAwgBjm+IGIUdkw2BczMaCCgIgn6QGQFHXZAxAQE?=
X-IPAS-Result: =?us-ascii?q?A2DQAAAXdR9b/zSOqnwNTxoBAQEBAQIBAQEBCAEBAQGFTIN?=
 =?us-ascii?q?3lTABAQEBAQEGgQUpllOEdwKDBDgUAQIBAQEBAQEChj4BAQEDIxVBEAsNCwICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGDHoF0qW1tghwag2ABhEyBaIELiEmBB4EPJIJoh3OCVQKZAwg?=
 =?us-ascii?q?Bjm+IGIUdkw2BczMaCCgIgn6QGQFHXZAxAQE?=
X-IronPort-AV: E=Sophos;i="5.51,213,1526313600"; 
   d="scan'208";a="87014098"
Received: from unknown (HELO [192.168.0.106]) ([124.170.142.52])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 12 Jun 2018 15:26:24 +0800
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 1/3] m68k: coldfire: Normalize clk API
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-2-git-send-email-geert@linux-m68k.org>
Message-ID: <944b08ba-a882-e6cd-42fa-9251bce1d7b1@linux-m68k.org>
Date:   Tue, 12 Jun 2018 17:26:22 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528706663-20670-2-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 11/06/18 18:44, Geert Uytterhoeven wrote:
> Coldfire still provides its own variant of the clk API rather than using
> the generic COMMON_CLK API.  This generally works, but it causes some
> link errors with drivers using the clk_round_rate(), clk_set_rate(),
> clk_set_parent(), or clk_get_parent() functions when a platform lacks
> those interfaces.
> 
> This adds empty stub implementations for each of them, and I don't even
> try to do something useful here but instead just print a WARN() message
> to make it obvious what is going on if they ever end up being called.
> 
> The drivers that call these won't be used on these platforms (otherwise
> we'd get a link error today), so the added code is harmless bloat and
> will warn about accidental use.
> 
> Based on commit bd7fefe1f06ca6cc ("ARM: w90x900: normalize clk API").
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

I am fine with this for ColdFire, so

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Are you going to take this/these via your m68k git tree?

Regards
Greg


> ---
>   arch/m68k/coldfire/clk.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
> index 849cd208e2ed99e6..7bc666e482ebe82f 100644
> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -129,4 +129,33 @@ unsigned long clk_get_rate(struct clk *clk)
>   }
>   EXPORT_SYMBOL(clk_get_rate);
>   
> +/* dummy functions, should not be called */
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_round_rate);
> +
> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_rate);
> +
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_parent);
> +
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	WARN_ON(clk);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(clk_get_parent);
> +
>   /***************************************************************************/
> 
