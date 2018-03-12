Return-Path: <kernel-hardening-return-12407-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvsnkAvekDOgjsIkzDliDuoH+bbGFgkC2S6/cVmGvhMmsw1OiKuuyZDhXiK3o/PnBBuMjJb
ARC-Seal: i=1; a=rsa-sha256; t=1520824137; cv=none;
        d=google.com; s=arc-20160816;
        b=w5/hBjDMgfFd8tUOZtDx7WrH65HaRql/QdcSqvi4XJDyzwXrUte48GqYFQrt7thB7V
         +Z/Bnnox16uGDdUMQmCV93siOgiWZfjy2UJFrTOSiQdJcRcsI5wcYS9+/MdZvhfxZ1BH
         td0BTyMZhzddxxPRUt4FJXun0H1BM5b4tK4QJ4qdOCiS58d3GlmjHCEpt2NmDgyb+HHj
         K8lEZCJN/pHk+3NmYdmRvzmWOyATiM/bspQTnEDkWxemTbabcZLQBD3N/gDgJ5H1vwl4
         kyLjO2FxCRG9paRpuMyike5AyMBGInE1dRF7KtqRNx3iBnNbGLdhurMTUZguTmVVDTvz
         RW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Pjmq0+bWnIEQMLIxO7FXq1efItrl9lo2aqebNKMK6Mo=;
        b=mk4jvw4GY7KlwLWmLTNK4Sk8gAXEqFtbGrHEbKVzwURlFQRPwogDVuU9afGBhlG+/3
         SH1PFOMIhsi5yXQGe/ytCHb1WvQUr93vaEjlmBXGkrCnNTQPy4rJkbbAiYW1gkm8KxOJ
         neXZCBvvqyDaYCB5+tgk5Edx7pdMWLOG3djU6t2cqVlKLLBFRggWslEGm6dRi/DKABFl
         FVNhT0tPy9LecdLUJm+jCU2vQo/WQrDkg8IKJ5t4QEWJ/vg2Ljpujx82C4JOfF52tp6w
         rrWl1a+HjgvnQTn9818Y4IdRR48Ji5hpaz6Ncxt9W2can57+wzHCSGXsyGrg2KEqZ1W5
         dMiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=jPeIl+4d;
       spf=pass (google.com: domain of kernel-hardening-return-12407-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12407-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=jPeIl+4d;
       spf=pass (google.com: domain of kernel-hardening-return-12407-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12407-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:Nu-lWnFbyph-7c_yYp6WuNLuKzdSZ201OQkWDDERMwTHV5HAhtoGIw>
Date: Mon, 12 Mar 2018 14:08:34 +1100
From: "Tobin C. Harding" <tobin@apporbit.com>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dario Ballabio <ballabio_dario@emc.com>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] scsi: eata: drop VLA in reorder()
Message-ID: <20180312030834.GC8631@eros>
References: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594676969721761588?=
X-GMAIL-MSGID: =?utf-8?q?1594699690968465024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding kernel newbies to CC because I pose a few noob questions :)
Adding Linus to CC because I quoted him.

On Sun, Mar 11, 2018 at 10:06:58PM +0100, Salvatore Mesoraca wrote:
> n_ready will always be less than or equal to MAX_MAILBOXES.
> So we avoid a VLA[1] and use fixed-length arrays instead.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>  drivers/scsi/eata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/eata.c b/drivers/scsi/eata.c
> index 6501c33..202cd17 100644
> --- a/drivers/scsi/eata.c
> +++ b/drivers/scsi/eata.c
> @@ -2096,7 +2096,7 @@ static int reorder(struct hostdata *ha, unsigned long cursec,
>  	unsigned int k, n;
>  	unsigned int rev = 0, s = 1, r = 1;
>  	unsigned int input_only = 1, overlap = 0;
> -	unsigned long sl[n_ready], pl[n_ready], ll[n_ready];
> +	unsigned long sl[MAX_MAILBOXES], pl[MAX_MAILBOXES], ll[MAX_MAILBOXES];

I think we are going to see a recurring theme here.  MAX_MAILBOXES==64
so this patch adds 1536 bytes to the stack on a 64 bit machine or 768
bytes on a 32 bit machine.  Linus already commented on another VLA
removal patch that 768 was a lot of stack space.  That comment did,
however say 'deep in some transfer call chain'.  I don't know what a
'transfer call chain' (the transfer bit) is but is there some heuristic
we can use to know how deep is deep?  Or more to the point, is there some
heuristic we can use to know what is an acceptable amount of stack space
to use?

As far as this patch is concerned wouldn't a kmalloc (with GFP_ATOMIC)
be ok?  We are in an interrupt handler, can we assume that since IO has
just occurred that the IO will be so slow comparatively that a memory
allocation will be quick.  (assuming IO since eata.c only requests a
single irq line.)


thanks,
Tobin.
