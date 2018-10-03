Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BFEC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173A120684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxbox.cz header.i=@linuxbox.cz header.b="O1kS7ZnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173A120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxbox.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeJCQDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:03:09 -0400
Received: from gwu.lbox.cz ([62.245.111.132]:35488 "EHLO gwu.lbox.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbeJCQDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:03:09 -0400
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
        by gwu.lbox.cz (Sendmail) with ESMTPS id w939Emwi025806
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 11:14:48 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 gwu.lbox.cz w939Emwi025806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxbox.cz;
        s=default; t=1538558090;
        bh=OJGtlu4YJA72QRgbkRsDEf+Z5Ejz9Z/B9haxFMQHxqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1kS7ZnZbK1aDoaI3CR9vVgKEbWZ0ACVqDhiia/ijWS/0wfgun3dO6mEZ49NtdHGF
         4R/DYdxHuTv1LU1456fNvrreicYQe88RH22dmHdDqNTgdixjlCmsmBt9EHbENVfT/n
         R3vYlud+rrl6PwXpQS/NThWEC6vYcMX2Kyh7wTIE=
Received: from pcnci.linuxbox.cz (pcnci.linuxbox.cz [10.76.3.14])
        by linuxbox.linuxbox.cz (Sendmail) with ESMTPS id w939EmMg017051
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 11:14:48 +0200
Received: from pcnci.linuxbox.cz (localhost [127.0.0.1])
        by pcnci.linuxbox.cz (8.15.2/8.15.2) with SMTP id w939EkPP008799;
        Wed, 3 Oct 2018 11:14:46 +0200
Date:   Wed, 3 Oct 2018 11:14:46 +0200
From:   Nikola Ciprich <nikola.ciprich@linuxbox.cz>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Rickard <matt@softrans.com.au>,
        Borislav Petkov <bp@alien8.de>, jason.vas.dias@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Subject: Re: [PATCH 4.14 114/165] x86/vdso: Fix vDSO build if a retpoline is
 emitted
Message-ID: <20181003091446.GD31855@pcnci.linuxbox.cz>
References: <20180903165655.003605184@linuxfoundation.org>
 <20180903165701.245301231@linuxfoundation.org>
 <20181002080655.GV31855@pcnci.linuxbox.cz>
 <CALCETrXcJCNFJ3fbFnxvijk4ts_yoxHnqM7xbZTir0MrhnvceA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXcJCNFJ3fbFnxvijk4ts_yoxHnqM7xbZTir0MrhnvceA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: on proxybox by F-Secure antivirus, database version 2018-10-03_04
X-Scanned-By: MIMEDefang v2.74/SpamAssassin v3.004001 on proxybox (nik)
X-Milter-Copy-Status: O
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

yes, it indeed does fix the problem.

Thanks!

nik


On Tue, Oct 02, 2018 at 09:27:21PM -0700, Andy Lutomirski wrote:
> On Tue, Oct 2, 2018 at 1:21 AM Nikola Ciprich
> <nikola.ciprich@linuxbox.cz> wrote:
> >
> > Hi Greg and others,
> >
> > sorry for reporting this so late, but still...
> >
> > this breaks build on older compilers, since it requires
> > -mindirect-branch=thunk-inline -mindirect-branch-register even though
> > retpoline support is disabled in kernel config.. is this expected?
> >
> 
> Nope, my patch was buggy.  Can you test the fix I just sent?
> 

-- 
-------------------------------------
Ing. Nikola CIPRICH
LinuxBox.cz, s.r.o.
28.rijna 168, 709 00 Ostrava

tel.:   +420 591 166 214
fax:    +420 596 621 273
mobil:  +420 777 093 799
www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------
