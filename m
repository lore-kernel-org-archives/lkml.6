Return-Path: <kernel-hardening-return-11954-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtj7lGO6RmW53WfKXmRelAucqFyyxGChL2TJniyunKgbQllRW4RXwhOIWR++djt5InbNjlJ
ARC-Seal: i=1; a=rsa-sha256; t=1519610477; cv=none;
        d=google.com; s=arc-20160816;
        b=Ljvhklzk3iLQBXs9HP4TczN/k3r4jwvwlyKpvXRsa8JKgBKQgNW+412tuAi3+LlrCc
         2wsfkM14O/bAH746pNR7pz0DW6g59m4kgMc/sZgyIpeZwLofQ9h8T3tro1N1t8KLmJiw
         zZtJp+24z7iQjEthjGGEtt9EpNq1V0kDR5+NjcDn+GSa2cLPwBjPn2ZqnzN4uJov+dY5
         B1CcPkqIF6pi488FFwUoBGObnaRQgJDmIG08SeWEd02mDHuL/KzU1dHx86k891SXSGcj
         pXAFuRQE4iAjnKDeJn0ykqe1tu6HGQg1jVBd0rE4X3l/2b21vYPb+ET1T3soVxT301mG
         I9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=t5Xwa7LXUJcjtSRdmSjoO7+1Rxo4jTGddQS0sAugw6g=;
        b=NsV5cNq0pMBRGUAFRja8a+f3tc60CxkD4jTBXcR5XTDhvt6i5/qHUytPiqgTUVga0C
         kXIziFdDrOv1K+iGE0xC7lpBvoGVzbvdImfhopjuQo98hcHGvQVfb5oD/qDtu8IZQi/G
         IJALvkI+8g6iiLd4hC+q88ozme963f0RPHpqtg4ZY9bJNueRoNepBP2dTi5wGtJPsbsO
         +nUIfGyWCBvOcmYkpsR/yQuzzI07zpNeuFRPBkVzfGFHHnBpe05usgdYTp1ZRQBR4n8P
         kmD2i5yaK8Vrj9DJJO+cB0RJEcrn2Cs/Vq/hfzNLddc0v7w+tEoH/q+g6MKWvjQxCSop
         wkgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=XNH3d3zg;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=aSNmpLWQ;
       spf=pass (google.com: domain of kernel-hardening-return-11954-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11954-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=XNH3d3zg;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=aSNmpLWQ;
       spf=pass (google.com: domain of kernel-hardening-return-11954-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11954-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:R2qTWntoUEXLKoZ97wZ90CFCPrF-VzX-N2ty-fnCsT8sK7AZGsK2Og>
Date: Mon, 26 Feb 2018 13:00:36 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] leaking_addresses: simplify path skipping
Message-ID: <20180226020036.GE2808@eros>
References: <1519008649-15782-1-git-send-email-me@tobin.cc>
 <1519008649-15782-3-git-send-email-me@tobin.cc>
 <20180226012631.qff25qjngubxy4ia@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226012631.qff25qjngubxy4ia@cisco>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592796064766188382?=
X-GMAIL-MSGID: =?utf-8?q?1593427076527068539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 25, 2018 at 06:26:31PM -0700, Tycho Andersen wrote:
> Hi Tobin,
> 
> On Mon, Feb 19, 2018 at 01:50:47PM +1100, Tobin C. Harding wrote:
> > -# Do not parse these files under any subdirectory.
> > -my @skip_parse_files_any = ('0',
> > -			    '1',
> > -			    '2',
> > -			    'pagemap',
> > -			    'events',
> > -			    'access',
> > -			    'registers',
> > -			    'snapshot_raw',
> > -			    'trace_pipe_raw',
> > -			    'ptmx',
> > -			    'trace_pipe');
> 
> It might be worth adding 'syscall' here; the pointers listed are user
> pointers, and negative syscall args will show up like kernel pointers,
> e.g. I get this output, which is spurious:
> 
> /proc/31808/syscall: 0 0x3 0x55b107a38180 0x2000 0xffffffffffffffb0 0x55b107a302d0 0x55b107a38180 0x7fffa313b8e8 0x7ff098560d11

Nice.  Will add.

thanks,
Tobin.
