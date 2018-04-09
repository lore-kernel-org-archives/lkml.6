Return-Path: <kernel-hardening-return-12942-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/WrRuw4yNo58HaL15boMJj0zLnib+2IcH+x69pZWPiXJRCZDBMhPLL1Ob8GvEncrmQknv3
ARC-Seal: i=1; a=rsa-sha256; t=1523312534; cv=none;
        d=google.com; s=arc-20160816;
        b=xkIfdNMLAlczH6HCziiD9314VuykKpZ+ycuAxtP9YsfcrmoQcw/tYP2G8SG8xjWn28
         wXO54ePn/f4BYBQNKeQZbvVHHvP605FsGz7HynWybWDfJn8B4opzUcSinf6xr3AqLz+T
         Mm3Y7uneIcF7YmrFhMZ4FQ51CPI+TUfoIWeW1ZBLha336MfPqj0RRHZ34FOLJeReuqTq
         0pxVx6i/odtg2lMtCIGBkP7W4XtJhbnr+2F0Ki5Ab4FkMmDudn0bRllB4ucIAgq4sSDi
         Fh39DQuzB6kkaE8BZV+jgAzs/7d6tTlubL6CB0oM9Ma/jt28pBcdMYRrhaMMAzmREc2U
         95Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Lpom34oTIIagmiCwV1gox+SofcsC0GhihfdeVrCb+XM=;
        b=Uvrvp3UhrzylTA7/IvFbGueXGvmwD4EBI9X7mjjhJ6Ryoli+VZYESnq7G8h1o/nKEI
         fjSW+fMh6V00tz99CdM/CkVMaNFuLgN7PdUc8jgHXkM1aTYucdHxOoLl1cF43JEMp4xw
         sMGn776EsTWFKU38TTmud859gwkJxk+Hx36U+HCCg43VbMUIptjmnsseXVMlpj2dzhA4
         DWDR7S/9bJWLqxuNIXlXUAUht0LzQ74L+Lt+FDpbkuYVe9Uan+YmAiZ586+I0lTBAzYD
         Bh3m9iUvixOBzr1hPKpaWIuE2TYfcZGpHQ8ZY8u2POPrPcOOOhWXEU6ScLh4tXyYdxr1
         ksqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@armlinux.org.uk header.s=pandora-2014 header.b=fABparhz;
       spf=pass (google.com: domain of kernel-hardening-return-12942-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12942-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=fail header.i=@armlinux.org.uk header.s=pandora-2014 header.b=fABparhz;
       spf=pass (google.com: domain of kernel-hardening-return-12942-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12942-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 9 Apr 2018 23:21:41 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Laura Abbott <labbott@redhat.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/i2c: tda998x: Remove VLA usage
Message-ID: <20180409222141.GR16141@n2100.armlinux.org.uk>
References: <20180409210703.3787-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409210703.3787-1-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304263905140111?=
X-GMAIL-MSGID: =?utf-8?q?1597308964471575226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 02:07:03PM -0700, Laura Abbott wrote:
> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> turn on -Wvla. The vla in reg_write_range is based on the length of data
> passed. The one use of a non-constant size for this range is bounded by
> the size buffer passed to hdmi_infoframe_pack which is a fixed size.
> Switch to this upper bound.

Does this _really_ make it safer?  What if the code is modified to write
more than 32 bytes in the future?

Sorry, I don't think this is safer at all.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
