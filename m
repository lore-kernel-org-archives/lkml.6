Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525181948; cv=none;
        d=google.com; s=arc-20160816;
        b=v+fC8dx0HDquOqlt9bBp02dBsSzUXdrX+/RpfayNx5BaG7E94YzIN/M4VeEqUJOCag
         U6p9bJHZFCOeOcJRkdquqhRCCkpEtfXR5vWZ9TVlso2UYF1k4bUYzLhlKlQXNIerR77E
         vUd9nZ4PXkGq9kw+6dS1u+Ps+BrkT2LZIR3TY8pWGVvVIMX1hyJiEpJh2AULQz6Ir5RC
         1nSL+4ow4Vy0Z3RfTRzC/ynJKLLzJF3TdhvUaqBm6+Bf9ATpG11btD2qJqGHnarNVM9e
         dzOQfFK/81hRlCsVMFDfmIeFQxrc55MkCivCDvm8fEPKPH07mWG29z/9QjmR2TBsPCL0
         aCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=xUX6W7+vwIdMFXoEyd39s+p434VVz2QFOxh4tyPDzGo=;
        b=dMnbTNWz2VCd1PLGNzYfdjxWhMiMgamr/7ewUx8juiO3YNrYdZIJ3cDKwdHPXzEhN5
         uSoKhZ8DENcfallRZNy3PDMStMnBgmat1ylzcq0M92RPZvqD2NVPPS4iabHcZN54Zbsd
         SlI0HAz6aQivCbHWo0HavqtGMlJ+nHgzCBhvDgLeDBJYgIIGV0wSxno319H6MhIPijWZ
         R6h/4zmofHUjO5/Hgb5gyjVHw+BLW18JPwtpm5B/eT8wSdpp4BVp76ugFe8Jisv5wj4d
         5ZIDDGL0NsVz1OEfXeXB+6YVzmmD3rQCjZCsUTiyZtjAX/okU9t/CKq9wCNENmu2OTXo
         EOuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZoGIT1gorkw0wLwIJ5e1lVfS5IaGcTIQ51IfIsI+HaT99bs11E01g3UTLqS5RITz5b2KS5Vhg==
Date: Tue, 1 May 2018 08:39:06 -0500
From: Rob Herring <robh@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
	Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 09/16] bus: ti-sysc: Add handling for clkctrl opt clocks
Message-ID: <20180501133906.GA18650@rob-hp-laptop>
References: <20180423174549.57412-1-tony@atomide.com>
 <20180423174549.57412-10-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423174549.57412-10-tony@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559971820741391?=
X-GMAIL-MSGID: =?utf-8?q?1599269186464544018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 10:45:42AM -0700, Tony Lindgren wrote:
> There can be up to eight optional device functional gate gate clocks for
> each clkctrl instance in clkctrl register bits 8 to 15. Some of them are
> only needed for module level reset while others may always be needed
> during use. Let's add support for those and update the binding doc
> accordingly.
> 
> Note that the optional clkctrl mux and divider clocks starting at bit 20
> can be directly mapped to the child devices, and ti-sysc does not need to
> manage those.
> 
> And as GPIOs need the optional clocks for reset, we can now add it with
> SYSC_QUIRK_OPT_CLKS_IN_RESET.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/bus/ti-sysc.txt       |   6 +-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/bus/ti-sysc.c                         | 140 ++++++++++++++----
>  2 files changed, 120 insertions(+), 26 deletions(-)
