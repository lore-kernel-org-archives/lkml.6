Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AB8JxZp9Ozhs9rQBStt4QT65NnmZ2dQdgSj8Cr6i0jD+pPPtiuSzrALHiYH63NImUOYN+EyzQuCS
ARC-Seal: i=1; a=rsa-sha256; t=1525081715; cv=none;
        d=google.com; s=arc-20160816;
        b=Aq0iIhD1Cpbt4ScezMsq6wzCdB0D/pYrjCMamrJklVii1j2wbddMqlZM74XLl/zWBx
         9AnFQ8YcAEZqkVO+p3RU0F/XtEp7FQpJrMagCEorENIel4K1OB9j4P4B2AIp+u3ZPSN+
         hHsU+KbGUEpsZetmo91RDBgt3dDpC5i/2xDrylz9VaU1HYy78vT2HQZJjywYY3fWPTJS
         G21KUnkUFmBVRiZVW0mq47M+IRBbQMHIfMOex3jg3Dy3Y4B/IG+WIrlpzleQGACEkxEs
         11k++t1pKC4lFrODaKNX2b+ZqWFPpXmpBlcYaHacIhCloOnYo0gM9xkA9euzdpEDBTMB
         gjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=vxJg1w/jmT0qKxMs+FyKwrf9fG98f9oI/6Ligj0YQQ0=;
        b=toN3vs5qiCzdMF4YRFdxd7z62Q+La0dulm/69aRZcysSQ9fmOVe7tGVuIZsGuBm8Ea
         nl2X6N/10ezoso9kZhb9TqyF033DUirDmstkb46U45gw4Xqz+6CBjVdeiVkzi2uhaDna
         2dtyRbGAguMQ1nLezWOPxVjZLYvOHxSAcJtBuAmOp6OAC4EjZ2qef1PHcyHHN9BTkK54
         Pjp8/fSX7gK4t9vvDcPYSo3NC6IkYgUOsUEMro8d+biTZH3BXzShf9wlIJGMMGegm2s1
         y45dl8OPL9W/HelkE4x8ZcNKAM3oTAF2I0Pa+iGzzZxg6XwdKmzdgwiC00qvFEP8nMbe
         /NVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Mon, 30 Apr 2018 11:48:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Wang <davidwang@zhaoxin.com>
Cc: tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, gregkh@linuxfoundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	brucechang@via-alliance.com, cooperyan@zhaoxin.com,
	qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com,
	timguo@zhaoxin.com
Subject: Re: [PATCH v3 2/2] x86/mce: add CMCI support for Centaur CPUs
Message-ID: <20180430094802.GF6509@pd.tnic>
References: <1524652420-17330-1-git-send-email-davidwang@zhaoxin.com>
 <1524652420-17330-3-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524652420-17330-3-git-send-email-davidwang@zhaoxin.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598713954946471832?=
X-GMAIL-MSGID: =?utf-8?q?1599164085498266980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 06:33:40PM +0800, David Wang wrote:
> Newer Centaur support CMCI mechnism, which is compatible with INTEL CMCI.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mcheck/mce.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index 38ccab8..f9a7295 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -1757,6 +1757,8 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
>  		}
>  	case X86_VENDOR_CENTAUR:
>  		mce_centaur_feature_init(c);
> +		mce_intel_feature_init(c);
> +		mce_adjust_timer = cmci_intel_adjust_timer;

This won't work in configs with CONFIG_X86_MCE_INTEL disabled.

You need to define CONFIG_X86_MCE_CENTAUR or so which depends on
CONFIG_CPU_SUP_CENTAUR and CONFIG_X86_MCE_INTEL and which then makes
sure the intel CMCI et al stuff is enabled.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
