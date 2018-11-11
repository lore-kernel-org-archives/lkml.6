Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23DBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB319214DE
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3Ic7jPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB319214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeKLCMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:12:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35137 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbeKLCMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:12:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so2943054pgu.2;
        Sun, 11 Nov 2018 08:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hpjpNGWibDpkBbiAKn0ROENYD7YT/4PqKMBTXGlIkrs=;
        b=a3Ic7jPML5ey9fQiMtRd5WZGG+9HmnOg3iobgKtLgukvV7MDKnOgXuVMRCr6SZuCoO
         v5+cv+EuseQeb1iL2qSAWCFiMBIpyudjQMxTwZJDIS7r7H0uNBdqHu1GwrWfsrF6xJF4
         KjGqhpK8suReaU3fEUQXcRG4D4+JYcIQ5OOPvcWbcXUX4zuLxXl0sk2adpc2K8QpLaJY
         LyotpgiRbHylsnZLrnlCMA1iE9XVqKwVFgGX1glAdNOQFea12y85yTGSDiX611Q/Qy1K
         igbjRJxCyJeHDmWgb39c4Yo7i2XNGw/yi8ewyZN585phoOAo9hEbYmYkTuLdaGVbHU2b
         TK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hpjpNGWibDpkBbiAKn0ROENYD7YT/4PqKMBTXGlIkrs=;
        b=CSm/eryKpZi9XHmu1TGRopHF6AshUciQIQ12Ghg1ZQqXKSzvrFctOsKujEbpRSIHNo
         G5UYIZLpqt0I1k1NCVuFcML2PTLQekDoCgK7APWb185HC6IQJO11BNmGYbHXwGfSS44l
         AfnempYd90mZSyDumeZEYDS1yWd8AJuNqk8Vncyp2IrLqGybTHKsfHWDzs26FAq8a+af
         +9ePsvLzVLSt8jhyoSt5TrzzjeKdddOfSfLHLwfr6LPUTIh2QC5uhn3BSnLnTOX/L80Z
         OQ8oWiD0J3DfPiPH0Kqn0z4baSDH7wQB9SFLGC6DSSNmiTGDvotLS3N676SLJHtyUXtA
         PTPA==
X-Gm-Message-State: AGRZ1gIEJw204SKXcJK5ZYlQCKhBLEgQLJ1UGs3U7qhy6NGnZSo+O6Ob
        r3LjDVOTXrQERP88sLLSde96EExrN4E=
X-Google-Smtp-Source: AJdET5cx7eTIW6dl08RzB8MG981k465hErjMaAvAotMkymIJX/gUqGr7ecccwB7Mpu/ypDYnkOK63Q==
X-Received: by 2002:a62:4c6:: with SMTP id 189-v6mr12757197pfe.110.1541953425834;
        Sun, 11 Nov 2018 08:23:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s141-v6sm27599966pfc.63.2018.11.11.08.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 08:23:44 -0800 (PST)
Date:   Sun, 11 Nov 2018 08:23:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 000/410] 3.16.57-rc1 review
Message-ID: <20181111162343.GA15513@roeck-us.net>
References: <lsq.1528380320.647747352@decadent.org.uk>
 <20180608141426.GA5242@roeck-us.net>
 <945ce3bb1ecd9c70249e79d2cb5572f9475c9786.camel@decadent.org.uk>
 <bf66aa7e856d4c2c83dc78dca95eee76437a1513.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf66aa7e856d4c2c83dc78dca95eee76437a1513.camel@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:09:03AM +0000, Ben Hutchings wrote:
> On Sat, 2018-06-16 at 22:18 +0100, Ben Hutchings wrote:
> > On Fri, 2018-06-08 at 07:14 -0700, Guenter Roeck wrote:
> > > On Thu, Jun 07, 2018 at 03:05:20PM +0100, Ben Hutchings wrote:
> > > > This is the start of the stable review cycle for the 3.16.57 release.
> > > > There are 410 patches in this series, which will be posted as responses
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Thu Jun 14 18:00:00 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 138 pass: 136 fail: 2
> > > Failed builds: 
> > > 	i386:tools/perf 
> > > 	x86_64:tools/perf 
> > > Qemu test results:
> > > 	total: 116 pass: 116 fail: 0
> > > 
> > > tools/perf builds are new, so it is probably not entirely surprising
> > > that they fail.
> > > 
> > > Deetails are available at http://kerneltests.org/builders/.
> > 
> > Thanks for testing.  I see you've now made the tools/perf builds work
> > for 3.16, so thanks for that as well.
> 
> I looked again and for the current patch queue I see:
> 
>     Building i386:tools/perf ... failed (script) - skipping
> 
>     Building x86_64:tools/perf ... failed (script) - skipping
> 
> I can still build it here in a Debian jessie environment though.
> 
I re-enabled it, but now it fails. Let me know if you want to try to fix
it. Probably something with out-of-tree build - I didn't try to find
the reason.

Please ignore the arm qemu failures - I restructured the tests, and need
to make some fixes.

Guenter
