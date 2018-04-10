Return-Path: <kernel-hardening-return-12963-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/C/LKTs1a5cuZqFC7QkPW7Izsq+rpFOR4TkkDXafq6l9uhCUjiM2ayR37p5pWPVN1DvVkW
ARC-Seal: i=1; a=rsa-sha256; t=1523398032; cv=none;
        d=google.com; s=arc-20160816;
        b=VTB7+VjLsL4Fm3WCc6x6JmQV/Ri6A4GUM1fvApheCSl2JJNyD1rIaXeI0chM2Fbv2a
         DTkzl2Gy9s1Jt2KOJcD3z5QvGCJpjDh8CjBlzRtOwr2BJOpK1Av79QlOhDcXDeJ6ui0j
         XfqP5dPjOX7Va2sY35wtA1N6M34vbIPYrAVEs5VI+taJpHSm0QcRNzP+laad5FppSILe
         /z9iJHqEJMJ1h7ZosZZCOxQFhynHGA7ftI8J7AZ316C3v2AWsNn6FHNshiwOSt83cC7q
         Ff77nXEez8kOF6irXJahZBlk/PWGMFwyw0ioTHrJ3p3EkIx4QBDIfQ+OSqdLfna8NdM8
         y9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=OQ1WbnH7Hih4Y3SOYYP8syz0ADBgTn+UXQogxTGd2Cg=;
        b=ixKvats+ki281sFiJDUpgUgTKqKmZg50/C7u9RqHL+ge1CWO/vR0d7tz9Y2g4nyLyO
         8VB8fxNsMQvOGrfU/Ekm4zPpK3UiKzwubnnOH5P5qmoKdPzBY09eM81vCEKMX9bnl2J+
         u8blsarXyMk7rk3o68PcAWhzK7gRh1I/Ca2+tElely/eHK9K1huZsclkJ/uenWTKsLDm
         9UcRgbh93KHtA4JMn5yCbl3uomR7aZU6+4zvVP7mBPDtEOiQhzuoDGhnhCCKahL2AiuO
         1cBpQMYH/2k39iK5f8ZpW7Ay7VlfnGLWFje09Qstg3h58l62XwU/kAODfzx93RM+vNwi
         YWuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@armlinux.org.uk header.s=pandora-2014 header.b=WReCMQT7;
       spf=pass (google.com: domain of kernel-hardening-return-12963-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12963-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=fail header.i=@armlinux.org.uk header.s=pandora-2014 header.b=WReCMQT7;
       spf=pass (google.com: domain of kernel-hardening-return-12963-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12963-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 10 Apr 2018 23:06:34 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Laura Abbott <labbott@redhat.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/i2c: tda998x: Remove VLA usage
Message-ID: <20180410220634.GZ16141@n2100.armlinux.org.uk>
References: <20180409210703.3787-1-labbott@redhat.com>
 <20180409222141.GR16141@n2100.armlinux.org.uk>
 <855433a0-72f5-df29-3a17-5c2016e988e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855433a0-72f5-df29-3a17-5c2016e988e1@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304263905140111?=
X-GMAIL-MSGID: =?utf-8?q?1597398615428738330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 02:52:35PM -0700, Laura Abbott wrote:
> On 04/09/2018 03:21 PM, Russell King - ARM Linux wrote:
> >On Mon, Apr 09, 2018 at 02:07:03PM -0700, Laura Abbott wrote:
> >>There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> >>turn on -Wvla. The vla in reg_write_range is based on the length of data
> >>passed. The one use of a non-constant size for this range is bounded by
> >>the size buffer passed to hdmi_infoframe_pack which is a fixed size.
> >>Switch to this upper bound.
> >
> >Does this _really_ make it safer?  What if the code is modified to write
> >more than 32 bytes in the future?
> >
> >Sorry, I don't think this is safer at all.
> >
> 
> Yeah I wasn't 100% sure about this one. Elsewhere, we've added bounds
> checks against the new static size buffer so we could do that here
> to ensure we don't overrun the stack if we do need to write more
> than 32 bytes in the future. Another option is to switch to
> a kmalloc buffer. Are either of those options acceptable to you or
> do you have a better idea of how to get rid of the VLA?

Limiting the size would be better (with an error message/WARN_ON) -
at least that results in a diagnostic message to alert the developer
rather than silently stomping over the stack.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
