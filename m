Return-Path: <kernel-hardening-return-13038-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48/zkIYh8AG3YC4a21B7U6mXsSZkZfjgFbGEf4YXHMfxQDxnQtEiHVPNtsSFRWXcLNhZGf2
ARC-Seal: i=1; a=rsa-sha256; t=1524059274; cv=none;
        d=google.com; s=arc-20160816;
        b=DqqgjrB7Ak4yUQ5YrVHwB1COM5msrUu3sq+hoB19bnc/8IuyEY7nJZw7zKCtkRZHhB
         Vs7hm+gZsuqqXxmOaQT8qkwOVn8xHrcfGfr5jVxIQ4oZgtFzJzYEs8uOrEuHmnVMp01I
         ak8bvbPTYimWvo5eXXMagO+d80A/BAOBzHBdLqoB+iUqhN2iDDomOORa/98fJt5tx4OH
         tdkwoLzoiNIjmngudrVnium72KwCcmijt30ME1ivTXO21xRuDb5u14DWh7TxzoWHT9I7
         UUQbyn5i7/Ad7bb2vRUaZDzD+D3Ef7BTzqXyiecpdbJFFRu8fv7985thOrzICC1iEsWl
         k//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=BZGUIEHVLbf0Bu3hCR+hzGkeDnLNorPYgD+jv4Dc2/c=;
        b=SzEs2HnWUJGy4XDs/w09FZrd4XXv2byp4htRjLCA8rA/I3LsChEwldu33ltU2YIjeV
         Igs6GjZ15aJSdggCGopVrNn48ndS1Wtr/f2pBEUhKYPAorxiQMTNnkgvpdq4cIUs2pM2
         UY7W/zPg+B51Wlz1GUhd8ER6mHpbcZDT8sfOimCElze18pxIiBNWe5kicRQknJGIg8qC
         ajg6VKR7SIDVafaAL8IfhICsGWOFHQzQShm7jSZijRunyKIg7wwFlMptk3YfWKsvg0GO
         xmTFuEKjHza5ZV72miFNL4BsyLVMdRZcpHKDB3gLXpIwHmgPdg2VVyKH8FnB5CBZifDn
         D6iA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13038-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13038-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13038-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13038-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 18 Apr 2018 14:47:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andrew Jones <drjones@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	catalin.marinas@arm.com, cdall@kernel.org,
	kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
	marc.zyngier@arm.com, ramana.radhakrishnan@arm.com,
	suzuki.poulose@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, awallis@codeaurora.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCHv3 03/11] arm64/kvm: hide ptrauth from guests
Message-ID: <20180418134729.fzu4r7rvgdzlckw7@lakrids.cambridge.arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-4-mark.rutland@arm.com>
 <20180418131926.pbjlbcjspg7azq2j@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418131926.pbjlbcjspg7azq2j@kamzik.brq.redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019694139875288?=
X-GMAIL-MSGID: =?utf-8?q?1598091977765931977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 03:19:26PM +0200, Andrew Jones wrote:
> On Tue, Apr 17, 2018 at 07:37:27PM +0100, Mark Rutland wrote:
> > @@ -1000,6 +1000,15 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
> >  				    task_pid_nr(current));
> >  
> >  		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> > +	} else if (id == SYS_ID_AA64ISAR1_EL1) {
> > +		const u64 ptrauth_mask = (0xfUL << ID_AA64ISAR1_APA_SHIFT) |
> > +					 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> > +					 (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
> > +					 (0xfUL << ID_AA64ISAR1_GPI_SHIFT);
> > +		if (val & ptrauth_mask)
> > +			pr_err_once("kvm [%i]: ptrauth unsupported for guests, suppressing\n",
> > +					task_pid_nr(current));
> 
> Marc just changed the equivalent SVE pr_err_once() to kvm_debug().
> So we probably want to do the same here.

Good point. Done.

> > +		val &= ~ptrauth_mask;
> >  	} else if (id == SYS_ID_AA64MMFR1_EL1) {
> >  		if (val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))
> >  			pr_err_once("kvm [%i]: LORegions unsupported for guests, suppressing\n",
> > -- 
> > 2.11.0
> >
> 
> Otherwise
>  
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Cheers!

Mark.
