Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567A1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF56F20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjEn0Ca/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF56F20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbeH3BK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:10:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39154 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeH3BK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:10:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so2832855pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HqBEHDIZc7MZ98yoWs4L5iipffBfsFQPEDX0QFvgE98=;
        b=NjEn0Ca/Yp2+W0EcvxA/SV+3yn/+F1g8yEE9ZMk3ZXFML87uBOWxIEOKn6MlURyWzL
         VhQP+44C3SMyUdcWlEl/Hb4d7+kQd3/umK2mJBupOfdBk97XND1VzuMfMaJe54egz9Hr
         LWPaDPDmDVrs9LNW8cM74Ud56R9iL6pNPppCiAoTY8y46NL5GMvWyFbopMs63L5QCHHF
         RDf/l6wRIwJHEhJ95hkWOEuGl1rDGLVZ3HFf6EEey1Sgz8FLpjfsBNQHkIqLYK+djkrM
         yS+LYgoTE2rNnsozsrsfDZKg4gFEQv3PsBp88LUgIX4zqk2wp7A4ONn0PdYEz545J1Hr
         2GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HqBEHDIZc7MZ98yoWs4L5iipffBfsFQPEDX0QFvgE98=;
        b=ODX0GwZlmIOow1OZ3Papwu7yRzLcRS+kAJPqz/0ecsfzAEmyGrKYyHiyIIe+43XHK/
         uqtadQHGyoDRXmhxctzjcNJsj16DY2sY6SONFOcDTlvfE2Yqv/oVbDfNZqwXI58346Wj
         RD+FZY8zb2SiAz8deSBTlnF5zlLUg/s2y56xitLsRDFdpe4eShy4r7znVhsMOr0OImFd
         1jtDPiPcMy6eXeZInAYpxcewt/15H1ani3zsczrdF5t1zo8raNf+J4Uau5vim6M+Y9xV
         WKtG0YWtx4PwGlcY303VuSwc9hUztP3AGJnPWCJdUfboz1LYUkK83EXSE/nXFk2t8HXb
         EELQ==
X-Gm-Message-State: APzg51B9yFT+XdVhEXv4RWt6BCZt0WMHh49bTFbHyz3Jkggf0L+d/f6/
        5d8nWB6J1AzCcd0UbmOpYhQ=
X-Google-Smtp-Source: ANB0Vdbdn4sX6624YTAnJCqgnXGyJ8opAkUzvUrsMS9EXAG2xbt/wltxWc3kw/qK4RqvarIb2+sRoA==
X-Received: by 2002:a62:45d2:: with SMTP id n79-v6mr7500165pfi.137.1535577134478;
        Wed, 29 Aug 2018 14:12:14 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n83-v6sm9343267pfk.19.2018.08.29.14.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 14:12:13 -0700 (PDT)
Date:   Wed, 29 Aug 2018 14:12:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, Pavel Machek <pavel@ucw.cz>
Subject: Re: efi boot failures due to PTI with 32 bit builds and Intel CPUs
Message-ID: <20180829211212.GA18036@roeck-us.net>
References: <20180829201659.GA29801@roeck-us.net>
 <cd62e6b9-aec4-b8a5-be71-7edc10734955@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd62e6b9-aec4-b8a5-be71-7edc10734955@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 01:28:16PM -0700, Dave Hansen wrote:
> On 08/29/2018 01:16 PM, Guenter Roeck wrote:
> > 
> > I see boot failures on mainline when trying to boot x86 images with an efi
> > bios on Intel CPUs in qemu. Behavior is quite unusual: qemu dies silently
> > after the kernel displays "Run /sbin/init as init process". With debugging
> > enabled, qemu reports a CR3 update followed by a triple fault.
> 
> My first thought would be that the EFI pgd is broken somehow.
> 
> Is 0e39b000 in your kernel binary, or was it dynamically allocated?
> 
No idea. In the log below (taken after I recompiled with the latest upstream
kernel) the CR3 value is completely different. Where is the value expected
to come from ?

> What was CR2 when things went bad?  Could you just share a full register
> dump?

Here you are. I have a complete log file, but its size is about 1.7GB
(21MB compressed). Let me know if you need it, and I'll publish it
somewhere.

Thanks,
Guenter

---
0xce1f1cd9:  66 90                    nop      
0xce1f1cdb:  8b 44 24 38              movl     0x38(%esp), %eax
0xce1f1cdf:  8a 64 24 40              movb     0x40(%esp), %ah
0xce1f1ce3:  8a 44 24 34              movb     0x34(%esp), %al
0xce1f1ce7:  25 03 04 02 00           andl     $0x20403, %eax
0xce1f1cec:  3d 03 04 00 00           cmpl     $0x403, %eax
0xce1f1cf1:  75 27                    jne      0xce1f1d1a

EAX=f60b8000 EBX=ff8020bc ECX=00000000 EDX=00000000
ESI=f60c1ff8 EDI=ff802100 EBP=00000000 ESP=f60c1fb4
EIP=ce1f1cd7 EFL=00200006 [-----P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00cf9a00 DPL=0 CS32 [-R-]
SS =0068 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
FS =00d8 2819b000 ffffffff 008f9300 DPL=0 DS16 [-WA]
GS =00e0 f67f29c0 00000018 00409100 DPL=0 DS   [--A]
LDT=0000 00000000 00000000 00008200 DPL=0 LDT
TR =0080 ff803000 0000206b 00008900 DPL=0 TSS32-avl
GDT=     f67e2000 000000ff
IDT=     ff800000 000007ff
CR0=80050033 CR2=b7f30854 CR3=35402000 CR4=000006d0
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000 
DR6=ffff0ff0 DR7=00000400
CCS=00000022 CCD=00000011 CCO=SARL    
EFER=0000000000000000
----------------
IN: 
0xce1f1d1a:  66 90                    nop      
0xce1f1d1c:  0f 20 d8                 movl     %cr3, %eax
0xce1f1d1f:  0d 00 10 00 00           orl      $0x1000, %eax
0xce1f1d24:  0f 22 d8                 movl     %eax, %cr3

EAX=00000003 EBX=ff8020bc ECX=00000000 EDX=00000000
ESI=f60c1ff8 EDI=ff802100 EBP=00000000 ESP=ff8020bc
EIP=ce1f1d1a EFL=00200087 [--S--PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00cf9a00 DPL=0 CS32 [-R-]
SS =0068 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
FS =00d8 2819b000 ffffffff 008f9300 DPL=0 DS16 [-WA]
GS =00e0 f67f29c0 00000018 00409100 DPL=0 DS   [--A]
LDT=0000 00000000 00000000 00008200 DPL=0 LDT
TR =0080 ff803000 0000206b 00008900 DPL=0 TSS32-avl
GDT=     f67e2000 000000ff
IDT=     ff800000 000007ff
CR0=80050033 CR2=b7f30854 CR3=35402000 CR4=000006d0
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000 
DR6=ffff0ff0 DR7=00000400
CCS=00000403 CCD=fffffc00 CCO=SUBL    
EFER=0000000000000000
CR3 update: CR3=35403000
----------------
IN: 
0xce1f1d27:  5b                       popl     %ebx
0xce1f1d28:  59                       popl     %ecx
0xce1f1d29:  5a                       popl     %edx
0xce1f1d2a:  5e                       popl     %esi
0xce1f1d2b:  5f                       popl     %edi
0xce1f1d2c:  5d                       popl     %ebp
0xce1f1d2d:  58                       popl     %eax
0xce1f1d2e:  1f                       popl     %ds

EAX=35403000 EBX=ff8020bc ECX=00000000 EDX=00000000
ESI=f60c1ff8 EDI=ff802100 EBP=00000000 ESP=ff8020bc
EIP=ce1f1d27 EFL=00200006 [-----P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00cf9a00 DPL=0 CS32 [-R-]
SS =0068 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
FS =00d8 2819b000 ffffffff 008f9300 DPL=0 DS16 [-WA]
GS =00e0 f67f29c0 00000018 00409100 DPL=0 DS   [--A]
LDT=0000 00000000 00000000 00008200 DPL=0 LDT
TR =0080 ff803000 0000206b 00008900 DPL=0 TSS32-avl
GDT=     f67e2000 000000ff
IDT=     ff800000 000007ff
CR0=80050033 CR2=b7f30854 CR3=35403000 CR4=000006d0
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000 
DR6=ffff0ff0 DR7=00000400
CCS=00000403 CCD=35403000 CCO=LOGICL  
EFER=0000000000000000
EAX=35403000 EBX=ff8020bc ECX=00000000 EDX=00000000
ESI=f60c1ff8 EDI=ff802100 EBP=00000000 ESP=ff8020bc
EIP=ce1f1d27 EFL=00200006 [-----P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00cf9a00 DPL=0 CS32 [-R-]
SS =0068 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
FS =00d8 2819b000 ffffffff 008f9300 DPL=0 DS16 [-WA]
GS =00e0 f67f29c0 00000018 00409100 DPL=0 DS   [--A]
LDT=0000 00000000 00000000 00008200 DPL=0 LDT
TR =0080 ff803000 0000206b 00008900 DPL=0 TSS32-avl
GDT=     f67e2000 000000ff
IDT=     ff800000 000007ff
CR0=80050033 CR2=b7f30854 CR3=35403000 CR4=000006d0
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000 
DR6=ffff0ff0 DR7=00000400
CCS=00000004 CCD=35403000 CCO=EFLAGS  
EFER=0000000000000000
Triple fault
