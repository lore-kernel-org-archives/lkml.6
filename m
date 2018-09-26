Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826EEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F06C21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="pT2Y8V2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F06C21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeI0Fxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:53:33 -0400
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:58936 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbeI0Fxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:53:33 -0400
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-09v.sys.comcast.net with ESMTP
        id 5INPglItVhaho5JNjgU1uz; Wed, 26 Sep 2018 23:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1538005091;
        bh=wiOMwTrYq5R9ddsvIt6IAAy7iC7WPxxhcmO/6tmD+P8=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=pT2Y8V2Em2+RCD3XtRJZgSSq7fwZ0LvjREFydJqpnBtyotI0pvin4pQPokzd5ev+W
         wBDDehvNDQ/0upeVMBjjiTjNEA8tDRMeypnuhXmcA+XDE+dmFCGhGPo2IPR78X9rB9
         LKpgyGLcW+27B2kbliHqpP9+4EJhDoNLZGruHDXNdAcRDWrvwiQDmPh2hoUzYZuENm
         4CpUbtt/44yNc75bQRD0B1SzY/6CmajeNOiGWSEwAqG5vNYD917B+9Nzwx85RJJCjX
         XWdoRMmlSX+qek8E4XGMXQvWW08fpELvnOC04kh7si2XFKCcHN6k3/e+DpuxRsS8qM
         zjCpk3OARjGlg==
Received: from [10.1.10.100] ([73.214.254.59])
        by resomta-ch2-20v.sys.comcast.net with ESMTPSA
        id 5JNhgoe7Fi7DZ5JNig4BFB; Wed, 26 Sep 2018 23:38:10 +0000
Subject: Re: AMD Athlon bogus performance value causing RCU stalls?
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <6243f7cc-1a80-db0b-4765-fa12bda9b06a@comcast.net>
 <alpine.DEB.2.21.1809232314460.1398@nanos.tec.linutronix.de>
From:   Rob Prowel <rprowel@comcast.net>
Message-ID: <38932eb1-921f-55f7-10c8-358f9aae32b2@comcast.net>
Date:   Wed, 26 Sep 2018 19:38:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809232314460.1398@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMhRBq7tDMgSAFr0dVhVxLzIAV/ZpIK4ohlpupBXtkC1tbHU+aEKT7sGX0vdIiK47t8T4J9rqkiacDDoGhMS2PuZsnJ+JB3Z6opiGQv37JuBIR3JdUtq
 r7DBvlXMfkiHt+/m/aP7a+RclQ3A3kvbe0+CV9qC1VLrc7Ne+CiNKQ2g/ayMaS2Zh7uXq415ZrX9WHwUP4E2hhK5gMSPhmN8QSg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/23/18 17:19, Thomas Gleixner wrote:
>>
>> Other than RTFM, or please build a bunch of kernels from source on your slow
>> machine, using differing config options to help track down the cause of
>> this...any thoughts about a solution?
> 
> Yes. This was decoded recently as an issue on 32bit due to a calculation
> which is based on 'unsigned long' but requires to be 64bit wide.
> 
> It's in the 4.18.8 stable kernel, which should be available from your
> fedora repo anytime soon.

OK.  Followup on AMD performance counter problem in 4.18.7

The Dell machine I was experiencing the problem on had a lot of ACPI
issues.  One of the invalid ACPI entries was for a system timer.
dmesg suggests that the broken timer was used in calculating the
Athlon performance value.  So no, 32/64 bit math was not the issue.

ACPI=off in the kernel boot line fixed the issue completely. Machine
still functions well as a file/web/postgresql dev server so it's all
good.

tanks!
