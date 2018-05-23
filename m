Return-Path: <kent.overstreet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527113929; cv=none;
        d=google.com; s=arc-20160816;
        b=uHLNsJ8UuLZ9HdWKQWoawIFwb+dy9/Yy6yVmTXUEr+tzKA9FfFo3VNRJTluox+gXhR
         vw5WTQVV1KF3QGqF24cqIYzhK6+dH1Kea994+KmxkFEej7vYrD1coHeacdVGE9MIec/A
         UxZSe/ieUs2Fjl31QjoDz98doG/DY8c4k8H4RMBx81krbtJnea+yoilf6htt0uyvbOPT
         z/m+xlT33WZLIBZhXZ04do67z4KYCKAgCDggQ2VPtzf4XittWDWoB4ksEKcz20jWQekj
         UmWfYqJgSeNxInW6QwBNC/MFRYjYsq7J7BQNyvyRfzAbgz1+qjQuvYEEIVPiK9y5pb9x
         +lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=AeESRiz/Adr+lLhHjUf8q5r8QcIF6KBtIVQVHRxeTKk=;
        b=JmnvNfarf84sC2TdOALPn20UydiYNvjH45vp/jyToZBg1PNWPfgg0YcSQd3CaAjK7X
         sTKrTub//PP2sNnhdTrevdxfb0+zmYQJ6EgMuRFr9YVAjwsWey3p+G7eWVpbHwSckRXt
         iSQ5RZBKNpTUSyB+ycdD7YTIqXmTiNgN8WGX6IZJDTYGO9VWlWCI8mdv4ebXYE3kNPdr
         zEv4U+nBG5r92vUnsQ2T0DILXHLlQI+AIbdvfmvrlpOsBK5NuJMPxkZt1xsJlAqx9GtC
         1GI5hw/XZjBL+YSGB5H2gaqAMOgAcYAvVd9OBWVXM23Co/dNVslg9MFfFl/XnATf+4Fx
         DMzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tWJD9oyV;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tWJD9oyV;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZp8EBqAX6Vz1UwM8Ofu27USrYFqm8Bvj1UGp2lLbJtbLP7yudVHZibQfVDSH44XcqCwTF9LNg==
Date: Wed, 23 May 2018 18:18:45 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, gregkh@linuxfoundation.org,
	linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
	dev@openvswitch.org, shli@kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 2/6] proc: commit to genradix
Message-ID: <20180523221845.GB23040@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-2-kent.overstreet@gmail.com>
 <20180523112823.GA19987@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523112823.GA19987@bombadil.infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601215737590926779?=
X-GMAIL-MSGID: =?utf-8?q?1601295016233309031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 04:28:23AM -0700, Matthew Wilcox wrote:
> On Tue, May 22, 2018 at 09:18:17PM -0400, Kent Overstreet wrote:
> > @@ -2140,11 +2140,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
> >  	struct task_struct *task;
> >  	struct mm_struct *mm;
> >  	unsigned long nr_files, pos, i;
> > -	struct flex_array *fa = NULL;
> > -	struct map_files_info info;
> > +	GENRADIX(struct map_files_info) fa;
> >  	struct map_files_info *p;
> >  	int ret;
> >  
> > +	genradix_init(&fa);
> 
> Could we have a DEFINE_GENRADIX(type, name) which initialises the tree?

Already exists. I kind of prefer not to use it when I don't need to though, and
stick to things that look more like normal declarations instead.
