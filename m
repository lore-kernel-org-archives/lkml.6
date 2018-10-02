Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FEDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C29206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxbox.cz header.i=@linuxbox.cz header.b="mOpe2BEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C29206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxbox.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeJBSbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:31:12 -0400
Received: from gwu.lbox.cz ([62.245.111.132]:37454 "EHLO gwu.lbox.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJBSbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:31:12 -0400
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
        by gwu.lbox.cz (Sendmail) with ESMTPS id w92BlYnX016801
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 13:47:34 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 gwu.lbox.cz w92BlYnX016801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxbox.cz;
        s=default; t=1538480856;
        bh=OXvxD5+VRNhbhOvEmceclUz9ANoOaxApf34HWj0BZ4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOpe2BEtSg1LeD77HvR3grSawpfC14uN4JHv0bfGrCKGI6MokyHG/N0WNSVKGDFZX
         /QfkYv0q9n5T25ZIieLWgzMx/nBVeYutO7p84Dv+vrJXbkYLzUJAL2aGgfsgogxMtC
         jCuafQ21oNoIlXCpcuacjq5ZkF9f7T6LKoh38jhM=
Received: from pcnci.linuxbox.cz (pcnci.linuxbox.cz [10.76.3.14])
        by linuxbox.linuxbox.cz (Sendmail) with ESMTPS id w92BlYXO005107
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 13:47:34 +0200
Received: from pcnci.linuxbox.cz (localhost [127.0.0.1])
        by pcnci.linuxbox.cz (8.15.2/8.15.2) with SMTP id w92BlYNl000662;
        Tue, 2 Oct 2018 13:47:34 +0200
Date:   Tue, 2 Oct 2018 13:47:34 +0200
From:   Nikola Ciprich <nikola.ciprich@linuxbox.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Rickard <matt@softrans.com.au>,
        Borislav Petkov <bp@alien8.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Subject: Re: [PATCH 4.14 114/165] x86/vdso: Fix vDSO build if a retpoline is
 emitted
Message-ID: <20181002114734.GA31855@pcnci.linuxbox.cz>
References: <20180903165655.003605184@linuxfoundation.org>
 <20180903165701.245301231@linuxfoundation.org>
 <20181002080655.GV31855@pcnci.linuxbox.cz>
 <20181002114614.GA2581@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002114614.GA2581@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: on proxybox by F-Secure antivirus, database version 2018-10-02_03
X-Scanned-By: MIMEDefang v2.74/SpamAssassin v3.004001 on proxybox (nik)
X-Milter-Copy-Status: O
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RHEL / centos 6: 

gcc-4.4.7

will check newer kernels too..

thanks

n.

On Tue, Oct 02, 2018 at 04:46:14AM -0700, Greg Kroah-Hartman wrote:
> On Tue, Oct 02, 2018 at 10:06:55AM +0200, Nikola Ciprich wrote:
> > Hi Greg and others,
> > 
> > sorry for reporting this so late, but still...
> > 
> > this breaks build on older compilers, since it requires
> > -mindirect-branch=thunk-inline -mindirect-branch-register even though
> > retpoline support is disabled in kernel config.. is this expected?
> 
> What exact "older compilers" break here?
> 
> And does the same breakage happen in 4.18.6 or 4.19-rc?
> 
> thanks,
> 
> greg k-h
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
