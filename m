Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AG47ELsnuW3RzzwYeWeELTUb19s5XDMkzr2x3hgnjpe5+AkNkAtICyWezbTqfEg47nQu6NnWTAux
ARC-Seal: i=1; a=rsa-sha256; t=1521237584; cv=none;
        d=google.com; s=arc-20160816;
        b=Bcg8DJZwViQ7XkuF+m3AFNnLVs1kk3lmOaCD2mTdqHDNoc1fHJulPLPUUfsmBadyM9
         eRlHq+9jpl6//sBCJ1SiuB7K3D2hQvppwZno24545qM+8V0SSz+3ghXYjPcvzy4DrWuz
         r+Ieti9LyUS1laG7tdfwEhDw9U+jGm1JdYBaDazbcYtNBtpJhdQc0Ku8jAcMVOzlzlmD
         im9SGya1fV7cpQZ8UhzYG3PW9IvlkXwf1268H220MbIpjaegHgzg+avKO6c3X1E3fXBW
         pZ++rUGUCobDG+30No8csFLwN3ObQXXnU9XgRd+Sr5VNEsJFXEz1GwbXRSR9eMd9+bFc
         5+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nKKdxbGV1mle5x1BjCH7AWz7F3TzZRjlFWkAJRUNEsc=;
        b=C9zRZ8wyOb5MlknwDI2Dr2gJMeo7wt4IqWjZPTjq3zEtP+gYX3m+dbKLPPRCLgLu04
         pzRI0tqrtgQItcLF0pD2rLoOzbHCCT3w2eJqAH8DFeU3xG4PnAxTN5QNMS8WcgFshCyS
         +wQCsOoYqdWnIOp4jcVBvwh2i+ZgWrFbCWkRw4b5+paWFhVZId58U6s/46Omx/NnXicC
         I8FCPY487WGOIQjEPUjynEdz3Tl469XeMpePpllINGkXt9EEwnXJrPcFqvJz2DbVQvEM
         o9c5+WzwWtrCU7GzcS4xOA0Z/N9SJrCwM+6rVGK6DhcUCj0b87vAgXl6AquVjAPV3P1j
         02rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Fri, 16 Mar 2018 14:59:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Wang <wei.vince.wang@gmail.com>
Cc: Wei Wang <wvw@google.com>, gregkh@linuxfoundation.org, Todd Poynor
 <toddpoynor@google.com>, Dan Williams <dan.j.williams@intel.com>, Michal
 Hocko <mhocko@suse.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Jan Kara <jack@suse.cz>,
 =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>, Hugh Dickins
 <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Sherry Cheung <SCheung@nvidia.com>, "Oliver O'Halloran"
 <oohall@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Huang Ying
 <ying.huang@intel.com>, Dennis Zhou <dennisz@fb.com>, Pavel Tatashin
 <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add config for readahead window
Message-Id: <20180316145942.9e2d353ed10041fbac42e5a3@linux-foundation.org>
In-Reply-To: <CAMFybE7EKyJMmR=Ntn1UX1ZMWJ=32v9G_kYdXh4LhinDv_JO8Q@mail.gmail.com>
References: <20180316182512.118361-1-wvw@google.com>
	<20180316143306.dd98055a170497e9535cc176@linux-foundation.org>
	<CAMFybE7EKyJMmR=Ntn1UX1ZMWJ=32v9G_kYdXh4LhinDv_JO8Q@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595133221485075684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 21:51:48 +0000 Wei Wang <wei.vince.wang@gmail.com> wrote:

> On Fri, Mar 16, 2018, 14:33 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Fri, 16 Mar 2018 11:25:08 -0700 Wei Wang <wvw@google.com> wrote:
> >
> > > Change VM_MAX_READAHEAD value from the default 128KB to a configurable
> > > value. This will allow the readahead window to grow to a maximum size
> > > bigger than 128KB during boot, which could benefit to sequential read
> > > throughput and thus boot performance.
> >
> > You can presently run ioctl(BLKRASET) against the block device?
> >
> 
> Yeah we are doing tuning in userland after init. But this is something we
> thought could help in very early stage.
> 

"thought" and "could" are rather weak!  Some impressive performance
numbers for real-world setups would help such a patch along.
