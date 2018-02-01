Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeBAX1H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:27:07 -0500
Received: from violet.fr.zoreil.com ([92.243.8.30]:38125 "EHLO
        violet.fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeBAX1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:27:00 -0500
Date: Fri, 2 Feb 2018 00:26:52 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Chunhao Lin <hau@realtek.com>
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: add module param for control of ASPM
 disable
Message-ID: <20180201232652.GA19190@electric-eye.fr.zoreil.com>
References: <1517500663-24052-1-git-send-email-hau@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517500663-24052-1-git-send-email-hau@realtek.com>
X-Organisation: Land of Sunshine Inc.
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chunhao Lin <hau@realtek.com> :
[...]
> @@ -5878,6 +5881,20 @@ static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
>  	RTL_W8(Config3, data);
>  }
>  
> +static void rtl_hw_internal_aspm_clkreq_enable(struct rtl8169_private *tp,
> +				bool enable)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	if (enable) {
> +		RTL_W8(Config2, RTL_R8(Config2) | ClkReqEn);
> +		RTL_W8(Config5, RTL_R8(Config5) | ASPM_en);
> +	} else {
> +		RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
> +		RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
> +	}
> +}

s/enable(..., false)/disable()/

static void rtl_hw_internal_aspm_clkreq_enable(truct rtl8169_private *tp)
{
	void __iomem *ioaddr = tp->mmio_addr;

	RTL_W8(Config2, RTL_R8(Config2) | ClkReqEn);
	RTL_W8(Config5, RTL_R8(Config5) | ASPM_en);
}

static void rtl_hw_internal_aspm_clkreq_disable(truct rtl8169_private *tp)
{
	void __iomem *ioaddr = tp->mmio_addr;

	RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
	RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
}

If you really want to factor something out, you may use helpers that set
or clear bits according to the 3-uple (tp, register, bits) but
foo_enable(..., false) is pointlessly convoluted.

-- 
Ueimor
