Return-Path: <kernel-hardening-return-13148-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZp2BGFeg4IH3YmmHI8PcDN80owJ5fwLGhQdG72Gl0+/6bCe7ncdzgb5n4UqnrUuI2Mg0ekw
ARC-Seal: i=1; a=rsa-sha256; t=1524824049; cv=none;
        d=google.com; s=arc-20160816;
        b=VJu5lrFtRlDlDFotq4JGI316c8CrA3vFXrqhOTLswhDlRYueOWrOETTS7YNAQCmhIJ
         j+mh+HOcZOqZgbPcPflhZLtdHuwCyRhNw3qK87Rw7zQAMsDypK5618UA4iIx/PUqXhJf
         QHSCfrsKgJ/JM9O4ZlJ8A9yYMWs56RgOaPR9EqjoZW0KU+3Lm7sXAXET2rOquAXXEq9k
         EJoHTnSrQ5r8KU8aF/il5VEB7Sy6FWQ9I6k3NL4Tdt6k1Z3beZm5NKERT4U6aHA+f3vN
         wlu/qfLyWXf6aBLWlLjLQ53VtYtuJDhfcM1+mZqrtJj7mGCdXx+cj5tKo7sp6/D1lEJk
         WPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=8XvtedOS39UKqnW8amsoMohfpTdHZjxUdHmcTyEWnjY=;
        b=KE/FQnS3Xrj+/P2p53AXqDf1Hg55sE5vcnp4xjmbfKqiBuWNIdR+wI/q0BuIw6gqtJ
         aTQNk94iBZ+qHboB2BTi9nZhoWivK76xjOV7BEdFgcOd2Xm47T0msSszt5nGfv0kWnx3
         2DiiOTgYrdCQ2aMg7MmeUqlAuNDGcg0qhudlLXBLZU6KevcMxetDUfpkMUOFHzv3AYB7
         uRDW0yX+uHUIYGzqbQuFaXamdv3W2fqUoW50EgQd4VAfv8lwH9kdh+ABdFitG56ToM10
         zEyyoSJCAatQGdddh2BcYhIaAQV116pI2RiXOPI1NujSASdeqLVRITHUrDAjYbKhEe/M
         Y27Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13148-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13148-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13148-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13148-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 27 Apr 2018 11:13:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	drjones@redhat.com, arnd@arndb.de, suzuki.poulose@arm.com,
	marc.zyngier@arm.com, catalin.marinas@arm.com,
	awallis@codeaurora.org, kernel-hardening@lists.openwall.com,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	ramana.radhakrishnan@arm.com, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCHv3 02/11] arm64/kvm: consistently handle host HCR_EL2 flags
Message-ID: <20180427101346.nabhblz3csp3cy36@lakrids.cambridge.arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-3-mark.rutland@arm.com>
 <20180427095139.GH13249@C02W217FHV2R.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427095139.GH13249@C02W217FHV2R.local>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019685895863114?=
X-GMAIL-MSGID: =?utf-8?q?1598893902471833122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 11:51:39AM +0200, Christoffer Dall wrote:
> On Tue, Apr 17, 2018 at 07:37:26PM +0100, Mark Rutland wrote:
> > In KVM we define the configuration of HCR_EL2 for a VHE HOST in
> > HCR_HOST_VHE_FLAGS, but we don't ahve a similar definition for the
> 
> nit: have
> 
> > non-VHE host flags, and open-code HCR_RW. Further, in head.S we
> > open-code the flags for VHE and non-VHE configurations.
> > 
> > In future, we're going to want to configure more flags for the host, so
> > lets add a HCR_HOST_NVHE_FLAGS defintion, adn consistently use both
> 
> nit: and
> 

Sorry about those; fixed up now.

[...]

> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>

Cheers!

Mark.
