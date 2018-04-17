Return-Path: <BATV+1a17e12b704b27f00da8+5350+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4+64zoDl5gC7egs3ABzDCdZDfQglGyT5kSb4CTuNpZbrSGRLnLcoAwSGJ7BQRUfCfxzkIrk
ARC-Seal: i=1; a=rsa-sha256; t=1523970051; cv=none;
        d=google.com; s=arc-20160816;
        b=OhNBwUkUe45Lp0ObhP0fJIydI9eYsh+jmNtoiKh9nl1HMrTVBoBvVVKhzBKsihv6zC
         tceGTnZKskCCQx43nKMfUzmDs3iSOXKZ18BQwT57xNVCSymwSgbnOlQwS5FQw5DexEAU
         vletkMk2xZP8K0dUx1aadehTDPQ0blaDA91oC+MBssluoaa9SrqP6UGqEKyNznfC6F1I
         yswRhRrBzKXsmEd9IdxHMY+lPehulbLznBGmr7WiDNK9BebhZcfZRpIVHPy74Fd2A6Hw
         q6Bp/klpGjzLTUIVeG97j5j+WKh2jC6dDqlAD4MyaPYDq/tBe0HHR07Rr4xi2ElGtyay
         BsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=wNkpQkf9I/0o9gsqCau7bVLlimMLgvSnYja4kBOyRyQ=;
        b=ayLOtMmLeG/Qog9gtcjcVvX10/xmwTs1gxbA+sgqkncln6ixRD0Ffe0biOiZ9wcIdY
         8XNo2iyGcvKU+D+YggHBgFblAVD7z9JOU5sr3AAQriD/bZJTYcbGRfHqL0XP2NzHynut
         VRtwYG9qyLZsFm+S15jsoN6cuaLkpK5P7N5V6osdDMrZrhmHTSZzWVrr1E7Q2XoFSS5n
         15DmDVWUYyB0TGogS7AvQfHlSNPGuKONMzD6Wo4Ij2GMlMI/dLktD0SPjhVG4Scydrm5
         vqDXHMHXqAaKXNtM5ckENlOIrCNiDxN2Aelji8VnHUllyfk7UP5HWEaia+/qrjTT5GFP
         EKbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=HuINp5SQ;
       spf=pass (google.com: best guess record for domain of batv+1a17e12b704b27f00da8+5350+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+1a17e12b704b27f00da8+5350+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=HuINp5SQ;
       spf=pass (google.com: best guess record for domain of batv+1a17e12b704b27f00da8+5350+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+1a17e12b704b27f00da8+5350+infradead.org+hch@bombadil.srs.infradead.org
Date: Tue, 17 Apr 2018 06:00:40 -0700
From: 'Christoph Hellwig' <hch@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Wang <davidwang@zhaoxin.com>,
	'Christoph Hellwig' <hch@infradead.org>, mingo@redhat.com,
	hpa@zytor.com, gregkh@linuxfoundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, brucechang@via-alliance.com,
	cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com,
	benjaminpan@viatech.com, lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH] x86/dma-mapping: override via_no_dac for new VIA PCI
 bridges
Message-ID: <20180417130040.GA9426@infradead.org>
References: <000001d3d628$4e91a4c0$ebb4ee40$@zhaoxin.com>
 <alpine.DEB.2.21.1804171052440.1694@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804171052440.1694@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597894379144798679?=
X-GMAIL-MSGID: =?utf-8?q?1597998418827866083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 10:54:37AM +0200, Thomas Gleixner wrote:
> The question was rather to have a list of PCI IDs for those chipsets which
> have the problem and set the 'disable' flag only for those. That makes a lot
> more sense than making a list of new chips which disable the disable flag.

Agreed.

There are a few other things I'd like to do in this area while we're
at it (I'm happy to do the work, not trying to offload it to David
or Thomas):

 (1) make the nodac flag a per-device flag.  Set for every device
     under one of the affected VIA bridges, or for all PCI devices
     if the nodac command line option is used
 (2) move that flag into the common struct device (or the to be
     designed dma struct hanging off it in the future) and make that
     bit handled in common code as there is a common Xilinx host
     bridge with a 32-bit dma limitation
 (3) kill of the forcesac option, which was a strange performance
     tweak back in plain PCI days, which probably didn't even work
     as expected to start with.
