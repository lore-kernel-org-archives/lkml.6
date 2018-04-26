Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AB8JxZrC3yIFlF1vP8L/O6MHqS9c35oDa4mc77a3Dm0CNeS97YUZW3mlJmazZ+6MHHUOw1isTvBx
ARC-Seal: i=1; a=rsa-sha256; t=1524736381; cv=none;
        d=google.com; s=arc-20160816;
        b=GwN46on/VeexsODjm0AN4zITFF3X3bxcNYfCuaOoh6tvraY5tTcx7rREH/1Bfxn+mB
         EJSaJegRpDmOdDhSPOETcOnqWW/gAQpmDoZqQDGAH8eI+DZ6pVTPQDQwVnWoSyxTi+03
         vmYJS7D0yk1N8wsQo60zJjevKfVa1IJm+gTj8asWD+3l8WaZ2pjFqgpPTGIs1+xd1YSw
         453JbhGQs0CV70ZnhWUZfUNKuTebBGw/hvlR4URwjtNTL5cGumvAF5CNo5qxbdZJXFRj
         bfvGrzYbEvH03g1+xDQMTYIom28kJEXAEnTVJo5DOtfz/1chlM0g1o4Di/V1P1F6ftuW
         +4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vWe5pwYLpqmt52la8LCoDlhsfkE1VjR0iaeC0brGrmA=;
        b=hxO7Ng9vZsUyRq0lrkBSj3zGu8h0DW8v1bH0zDuHYLFEHfSZCskj/OUveLLr4QMODU
         +3VBDiiVA+oWvKrDw05TuEiCVVCCjnW4cXUmVGvv+5Tx4wnPvWETSP34rbJnwS8ZN8wL
         xGy7JWrmeJh6ATL/QKDCbTL8icwLaEf2QByDWaemj28amfJrGYfd+DZyi4vZAgkblzKe
         UPwJgSGSYjR6CiST64YH3fln7n+9tonEWK3UEU35dcXlvAoRvoeh85EhdQds2cK8CoiQ
         6pdG5k4FdycFT8VnkDt4cxzbyyhrxBwqjyXN5GvMSyhdief+rMFOFq0yZeSMde/6vLWv
         3A6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: 'Thomas Gleixner' <tglx@linutronix.de>
CC: <mingo@redhat.com>, <hpa@zytor.com>, <gregkh@linuxfoundation.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>
Subject: Re: [PATCH v2] x86/centaur: report correct CPU/cache topology
Date: Thu, 26 Apr 2018 17:52:37 +0800
Message-ID: <000001d3dd44$4eddf500$ec99df00$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdPdQ/mjDUypXtYJQW6UX3kY6chqzA==
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598707331736594259?=
X-GMAIL-MSGID: =?utf-8?q?1598801975589728225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Mail-----
> Sender: Thomas Gleixner [mailto:tglx@linutronix.de]
> Time: 2018=C4=EA4=D4=C226=C8=D5 17:12
> Receiver: David Wang <davidwang@zhaoxin.com>
> CC: mingo@redhat.com; hpa@zytor.com; gregkh@linuxfoundation.org;
> x86@kernel.org; linux-kernel@vger.kernel.org; brucechang@via-
> alliance.com; cooperyan@zhaoxin.com; qiyuanwang@zhaoxin.com;
> benjaminpan@viatech.com; lukelin@viacpu.com; timguo@zhaoxin.com
> Subject: Re: [PATCH v2] x86/centaur: report correct CPU/cache topology
>=20
> On Wed, 25 Apr 2018, David Wang wrote:
> >
> > +static void early_init_centaur_mc(struct cpuinfo_x86 *c) { #ifdef
> > +CONFIG_SMP
> > +	unsigned int eax, ebx, ecx, edx;
> > +
> > +	if (c->cpuid_level < 4)
> > +		return;
> > +
> > +	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
> > +	if (eax & 0x1f)
> > +		c->x86_max_cores =3D (eax >> 26) + 1;
> > +	else
> > +		return;
> > +#endif
> > +}
>=20
> My review comment from last time still stands:
>=20
> > > This is a bad copy of intel_num_cpu_cores(). See for the subtle
> > > difference. Please rename the intel function and move it to =
common.c
>=20
> In other words:
>=20
> Make a patch which moves intel_num_cpu_cores() into common.c. Rename
> the function into something like detect_num_cpu_cores() and fix up the
call
> site in intel.c.
>=20
> Then add your patch and use the very same function.
>=20

	OK. I got it.
> > +
> >  static void early_init_centaur(struct cpuinfo_x86 *c)  {
> > +	early_init_centaur_mc(c);
> >  	switch (c->x86) {
> >  #ifdef CONFIG_X86_32
> >  	case 5:
> > @@ -146,6 +163,7 @@ static void centaur_detect_vmx_virtcap(struct
> > cpuinfo_x86 *c)
> >
> >  static void init_centaur(struct cpuinfo_x86 *c)  {
> > +	unsigned int l2 =3D 0;
> >  #ifdef CONFIG_X86_32
> >  	char *name;
> >  	u32  fcr_set =3D 0;
> > @@ -161,6 +179,17 @@ static void init_centaur(struct cpuinfo_x86 *c)
> > #endif
> >  	early_init_centaur(c);
> >
> > +	l2 =3D init_intel_cacheinfo(c);
> > +
> > +	/* Detect legacy cache sizes if init_intel_cacheinfo did not */
> > +	if (l2 =3D=3D 0) {
> > +		cpu_detect_cache_sizes(c);
> > +	}
>=20
> Aside of the pointless parentheses, this really wants to be cleaned up =
as
well.
>=20
> init_intel_cacheinfo() is called from the intel init code and it does =
the
same
> silly thing.
>=20
> So the right thing to do is in a separate patch first
>=20
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -679,12 +679,6 @@ static void init_intel(struct cpuinfo_x8
>=20
>  	l2 =3D init_intel_cacheinfo(c);
>=20
> -	/* Detect legacy cache sizes if init_intel_cacheinfo did not */
> -	if (l2 =3D=3D 0) {
> -		cpu_detect_cache_sizes(c);
> -		l2 =3D c->x86_cache_size;
> -	}
> -
>  	if (c->cpuid_level > 9) {
>  		unsigned eax =3D cpuid_eax(10);
>  		/* Check for version and the number of counters */
> --- a/arch/x86/kernel/cpu/intel_cacheinfo.c
> +++ b/arch/x86/kernel/cpu/intel_cacheinfo.c
> @@ -802,6 +802,11 @@ unsigned int init_intel_cacheinfo(struct
>=20
>  	c->x86_cache_size =3D l3 ? l3 : (l2 ? l2 : (l1i+l1d));
>=20
> +	/* Detect legacy cache sizes if the above did not work */
> +	if (!l2) {
> +		cpu_detect_cache_sizes(c);
> +		l2 =3D c->x86_cache_size;
> +	}
>  	return l2;
>  }
>=20
> Hmm?
>=20
> 	tglx
>=20
	OK. I got it.
	Patch v3 will be sent later.
	Thank you.
---
David
