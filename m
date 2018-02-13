Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518524963; cv=none;
        d=google.com; s=arc-20160816;
        b=hpXMGb858OUEaBVIqamxtRq8tl8fHmT3p5p5cDNP1FUACjHXVM+RqZPaBWBw2SCrm6
         Vqraewd7FMb9p+sOaXp7CL/+827HRjoy6CTnIvLCpXET19BmW1eOhPNoPBgmvw3695tm
         0WSuOP7e203eWVVApA1M4qJVw2Ej9ZjQ/xTidym+nZZ74pfRtDL5OG5A75QYtLvgg+Ve
         BF9+6WmDddatukYkHMhJsl2SloXkI9JuT8d1gErWgFRer1cTOQurxJZJZzeBs5cF6RYH
         tNmpsLBSKDzvs4VkHj52ak1pM0W1S8Ap5QYNYlbfNLWk7Drm1l7ezcM6O9vJ53+wiUCc
         eDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=T3QYOeOTpETDMT8MzPc7DBV2FYc8Tq7ss3+eMFPvrvM=;
        b=0K1rMuE71SaqK41zxVaN8fsIXbgwu5J7MOEszc5vDl+/xfniz+1oTlMIjNXuxzPEIy
         sPKu4KXDBeJ2mGrCPFQ+UfNTBsCXUtFU/sR0bhdIOexk2DAqg+4H6eP5PW2Uce3kwnjL
         yVN/IthA8KatAVUztIJZou30bStfKEpOt81LpvfJZN64GrdTPw1idSUKbsx8WxjM964n
         NrKWPa9N5j6O7FGblLxy2ij8zoKckcDgwrttjo+bcm94Nh2ntskmJzw7P7iBh38Jtgwh
         j0w7k/s60uUSE61yS3Idz3cBphCg8lmKr1m0rXIzebICXNV/gH/YJarWBbnS++H9dPvK
         epMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D7OkjIMu;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D7OkjIMu;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x224+QBXhdDRZdo06dREJVQLsV7AyYGW4Nes+asly4DMeA3clBkeLZFlRC+QkutuKsJigSZMdDQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 13 Feb 2018 13:29:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Prarit Bhargava <prarit@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	xen-devel@lists.xenproject.org, simon@invisiblethingslab.com
Subject: Re: [PATCH] x86/xen: Calculate __max_logical_packages on PV domains
Message-ID: <20180213122920.4afcvqqxcstbftan@gmail.com>
References: <20180207234923.13544-1-prarit@redhat.com>
 <5607eaea-5cc3-31a4-9685-1d7dd147f564@oracle.com>
 <0e2775c8-2114-e554-dd0f-7222300e3e27@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e2775c8-2114-e554-dd0f-7222300e3e27@suse.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591788037595473599?=
X-GMAIL-MSGID: =?utf-8?q?1592288832732145452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Juergen Gross <jgross@suse.com> wrote:

> On 08/02/18 01:59, Boris Ostrovsky wrote:
> > 
> > 
> > On 02/07/2018 06:49 PM, Prarit Bhargava wrote:
> >> The kernel panics on PV domains because native_smp_cpus_done() is
> >> only called for HVM domains.
> >>
> >> Calculate __max_logical_packages for PV domains.
> >>
> >> Fixes: b4c0a7326f5d ("x86/smpboot: Fix __max_logical_packages estimate")
> >> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> >> Tested-and-reported-by: Simon Gaiser <simon@invisiblethingslab.com>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >> Cc: x86@kernel.org
> >> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> >> Cc: Juergen Gross <jgross@suse.com>
> >> Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
> >> Cc: Prarit Bhargava <prarit@redhat.com>
> >> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Andy Lutomirski <luto@kernel.org>
> >> Cc: Andi Kleen <ak@linux.intel.com>
> >> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> Cc: xen-devel@lists.xenproject.org
> > 
> > 
> > Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> Thomas, Ingo, are you taking this via the tip tree or should I take
> it via the xen tree?

Since it's supposed to only affect Xen feel free to pick it up:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
