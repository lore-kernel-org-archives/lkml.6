Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AH8x226VlZEdtxj4kC2hFGTQx+axvpOxP/ws6hNLLzqPAjT4BwcgETFGJY0glgpzFitEq8oDQLaf
ARC-Seal: i=1; a=rsa-sha256; t=1517601397; cv=none;
        d=google.com; s=arc-20160816;
        b=bnCYNxSCtNUrI7mwSCywf5BvNzNIAMcu4OlWigZSN5HZWsw+pXqCpatNctIqeXL908
         qCDjfJ8KcuOKpUP6YUcbW7SwcVQuv9huLoCf3lGO8c/26gaAxvEgTewxAepEZaFOEfhB
         ctnINFokQ29wog90RpkXCHNxkl2sDecVEo1SjpnzpP/EWSB8wqjMLPKGRzW17Gp06snT
         3W0QY80U2sRkoJiXeS35ipCqu4SJ3Xv3PYABflEXn8rHa0j6Xznx61ywwBmxWWdmCb8J
         78ZQZhY2zhaCaCKINOWA6s8CRbxnYQUvD7aaap94X42eOvBAJsYmAeh/gaqEdlzd37Td
         /TFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=/+TeL7BPNhw0iejxJ0Tum35tjS+7L9qnxZdLnd4T9ak=;
        b=v5p84xK8vLz8zLvb/8hxNgEqq7giGTlu6N/GXoZWZdP3Luxw4m1U2eXKMWJjFk9s7h
         7dE35C98To9bAzittf/DdXeOnAStQtvcDywwEnAG2UHWZpVt/uI0FY6KcrqtNFb646TF
         NQL35+nCnQ+y5G6QMf0BPqZ8TETrw26flyTsvGNegX3zBX0JjXNsiLEz3CT7jzvEp85Z
         WxZHIAW/SW8bXYVM+2xCtQCUespKbLrAD/uXcPPbXn/AvtgaFyVra8CPnkbnTCxyKDv4
         Kt7vZ/Cv4O0ITS8WiNzEDsBqUtDOkdMnMhlW5lqhO1Hd3/yHMpBbN7dzrEkDvabOoC5C
         9NaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=umOlgpnV;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=umOlgpnV;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 14:56:01 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
Message-ID: <20180202195601.GD28192@char.us.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de>
 <20180202174932.GR28192@char.us.oracle.com>
 <1517594544.31953.62.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1517594544.31953.62.camel@infradead.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020237
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1591320402961465289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 06:02:24PM +0000, David Woodhouse wrote:
> On Fri, 2018-02-02 at 12:49 -0500, Konrad Rzeszutek Wilk wrote:
> > > @@ -625,7 +629,12 @@ static inline int __do_cpuid_ent(struct
> > > kvm_cpuid_entry2 *entry, u32 function,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!g_phys_as)
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0g_phys_as =3D phys_as;
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0entry->eax =3D g_=
phys_as | (virt_as << 8);
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0entry->ebx =3D entry-=
>edx =3D 0;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0entry->edx =3D 0;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* IBPB isn't necessa=
rily present in hardware cpuid>  */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (boot_cpu_has(X86_=
FEATURE_IBPB))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0entry->ebx |=3D F(IBPB);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0entry->ebx &=3D kvm_c=
puid_8000_0008_ebx_x86_features;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0cpuid_mask(&entry->eb=
x, CPUID_8000_0008_EBX);
> >=20
> > It is with x86/pti nowadays. I think you can remove that comment.
>=20
> In this code we use the actual CPUID instruction, then filter stuff out
> of it (with &=3D kvm_cpuid_XXX_x86_features and then cpuid_mask() to tu=
rn
> off any bits which were otherwise present in the hardware and *would*
> have been supported by KVM, but which the kernel has decided to pretend
> are not present.
>=20
> Nothing would *set* the IBPB bit though, since that's a "virtual" bit
> on Intel hardware. The comment explains why we have that |=3D F(IBPB),
> and if the comment wasn't true, we wouldn't need that code either.

But this seems wrong. That is on Intel CPUs we will advertise on
AMD leaf that the IBPB feature is available.

Shouldn't we just check to see if the machine is AMD before advertising
this bit?
