Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AB8JxZonNZ6M0NhH2960w3Xw3F8A6Ro2djlVqqWFLXCpaiSaSJGnKB64gY9KdnP61dzqS6ae5Yuv
ARC-Seal: i=1; a=rsa-sha256; t=1525941704; cv=none;
        d=google.com; s=arc-20160816;
        b=tKJ5Mq7nF5HSFLpOX83GCaRKddvwLsxQXuO6f+t0G3CTtsh7ZyI+b9Ynt+FhXYXV8Z
         khoSbrOwwER/XKYBrryzgrTB2BZnM+AQjYfIFQu6arjCGBKjLneDrNk+6fJQLZ7tgHXF
         0hNGXYtfSsgmiLiuk5u26XoIsrmG9ZZVjw9ycbiWcBLHJhD5m7Hh2632lAdok5ZwkkIQ
         qR3PRYmLenzC+MPYwdrVl817ewEOeTX3GMFSe3lfjy1RtSw3kSdaSuayNl0e+Ter7ADf
         5P9HGIFfFxYdESHAoTDmjlyXclHZt/SdcqhRhvrHxpt+jEwSLfcvy3sbzhOIz4Ah1KAc
         Fsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=pVSPTtiOskpCaBKUUvbktT7zYihHor7vfp1Z60bv67o=;
        b=wpBKpINEfnhFb4tStp98XTd1ka0akTZ5Z4462hXEVgtWhrRvXLDUsFpqLJHEPbev3D
         4dz3hif11jFVfN2O86Yh9Xv3bj/2Mitxu3OURQCHSYEwkb/uCSup44DP96An/KzRpdke
         BVfLjxezeWeyM5PZGtTul7E0hWk9WXcOxeFn+bPzwmoEOhVlD7oEqKA607uZsz/hFf8e
         Y/8/wm2dHbmmKd+tugAcDm+fJS60Niy/e3nSNYDQUx6pKwvSwcZgsQn02pKjF9Eg2qIr
         XcCg6/EzL+Pa3P9kdojXi8iVrZOZvtszdUstVhzLkyq4rzunXKvSkO6wS8bLzclke/3K
         xdJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=xmgCWq5c;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=xmgCWq5c;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 10 May 2018 10:41:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	damian <damian.tometzki@icloud.com>
Subject: Re: [PATCH 3/3] objtool: Support GCC 8 switch tables
Message-ID: <20180510084125.GY12217@hirez.programming.kicks-ass.net>
References: <cover.1525923412.git.jpoimboe@redhat.com>
 <60ba92277204856ced0723f7d7ca52c691baace3.1525923412.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ba92277204856ced0723f7d7ca52c691baace3.1525923412.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046846156782249?=
X-GMAIL-MSGID: =?utf-8?q?1600065848921937638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 10:39:16PM -0500, Josh Poimboeuf wrote:
> Add some additional checks to the switch jump table logic.  This fixes
> the following warnings with GCC 8:
> 
>   drivers/block/virtio_blk.o: warning: objtool: virtio_queue_rq()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+72
>   net/ipv6/icmp.o: warning: objtool: icmpv6_rcv()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+64
>   drivers/usb/core/quirks.o: warning: objtool: quirks_param_set()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+48
>   drivers/mtd/nand/raw/nand_hynix.o: warning: objtool: hynix_nand_decode_id()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+24
>   drivers/mtd/nand/raw/nand_samsung.o: warning: objtool: samsung_nand_decode_id()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+32
>   drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.o: warning: objtool: gk104_top_oneinit()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+64

Could you maybe detail how the GCC8 switch tables are different? And
thus what needed fixing?
