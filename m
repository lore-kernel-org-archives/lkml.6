Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AB8JxZoAtSkIqsjHPRN87Qnk0QVO0WQT/fbJq1GfN0c7yMaVFVQN/R8NsUXZZqM7ctnr2t6HfGLq
ARC-Seal: i=1; a=rsa-sha256; t=1525230344; cv=none;
        d=google.com; s=arc-20160816;
        b=TMLowlOgPu/TJNKtpzgsfiBjEjhdRzNp6IZxiWZ/Npj6s9I4Vqd9SSB3wecN1gosIm
         XF4+kkvfQS1NexqSTjSVdFtf+MQSMsSb9LshE9zqzwiboJX3n1+vUsVlH/Z/kcaPJEP8
         Y2lRjDjOH7fL9UABdmvSkyHH0xQrxH3OuV1Ff7QRPdtF+Gtc+dvQBRP2HwBcce8RU4jh
         c+Vc2QyVP9XIidudj/mdjX2kVCXiwssLs/nDVgcgcAxO/J+nJIzC6jzz9zp3N5BUBfsZ
         b5DLAP16BwVepn58NWD4PtrmzHvlSP8cHk/1ij/JaOeNHhaiFb06ODGNvwNk1KHWOea2
         EuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=me45gw7ITYDQFqNbTKg7UDDx+WxtdXn8rcibZTinnJg=;
        b=tXSY7W6rBmUlzx6EdMrpQmotnGE9gQoV+PgIOe6lHRM9ZsV2X9I8VdjDPWqHFWJ9ex
         OAi5CMJPCFBodM2skGatyQ+MizGnbiz1qZE00KSDfksHlI4Le8oWJHzQ8L6wlnW5RUel
         1e+lUXvR4gkW8OTy7iy6R7LGqel6jo+IMBOe/+x2i/v4q8bKZbuKuhmHstN2n3kAyovK
         zI3xu6gpCzIzzCMYYDlRjB30EuVhFBG8Wd+tSKMd3ketnDHOu7+0AJzohkpWObhfd+9K
         yabgobTbCAERSK95GVdlorjKaZMBUNUnuV5FuMfjgQkTyFt135+88k/37ulv2BB7Dacc
         ytlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=b4CifmJK;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=b4CifmJK;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Wed, 2 May 2018 04:05:39 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 10/10] staging: lustre: fix error deref in
 ll_splice_alias().
In-Reply-To: <152514675919.17843.11688659715084804936.stgit@noble>
Message-ID: <alpine.LFD.2.21.1805020403530.2551@casper.infradead.org>
References: <152514658325.17843.11455067361317157487.stgit@noble> <152514675919.17843.11688659715084804936.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180502_040540_021520_AA8D8C41 
X-CRM114-Status: GOOD (  16.13  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232390798280014?=
X-GMAIL-MSGID: =?utf-8?q?1599319932647535296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> d_splice_alias() can return an ERR_PTR().
> If it does while debugging is enabled, the following
> CDEBUG() will dereference that error and crash.
> 
> So add appropriate checking, and provide a separate
> debug message for the error case.

Yeah!!! It fixed the issues. Thank you.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Reported-by: James Simmons <jsimmons@infradead.org>
> Fixes: e9d4f0b9f559 ("staging: lustre: llite: use d_splice_alias for directories.")
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/staging/lustre/lustre/llite/namei.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
> index 6c9ec462eb41..24a6873d86a2 100644
> --- a/drivers/staging/lustre/lustre/llite/namei.c
> +++ b/drivers/staging/lustre/lustre/llite/namei.c
> @@ -442,11 +442,15 @@ struct dentry *ll_splice_alias(struct inode *inode, struct dentry *de)
>  	} else {
>  		struct dentry *new = d_splice_alias(inode, de);
>  
> +		if (IS_ERR(new))
> +			CDEBUG(D_DENTRY, "splice inode %p as %pd gives error %lu\n",
> +			       inode, de, PTR_ERR(new));
>  		if (new)
>  			de = new;
>  	}
> -	CDEBUG(D_DENTRY, "Add dentry %p inode %p refc %d flags %#x\n",
> -	       de, d_inode(de), d_count(de), de->d_flags);
> +	if (!IS_ERR(de))
> +		CDEBUG(D_DENTRY, "Add dentry %p inode %p refc %d flags %#x\n",
> +		       de, d_inode(de), d_count(de), de->d_flags);
>  	return de;
>  }
>  
> 
> 
> 
