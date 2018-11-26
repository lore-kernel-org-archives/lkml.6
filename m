Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3F7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C0620862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qposv00d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C0620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeK0Aby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:31:54 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:56065 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeK0Abx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:31:53 -0500
Received: by mail-wm1-f44.google.com with SMTP id y139so18201672wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JHnG0Qt8Q8UOZMoGZkQPlCPmbW+eVM6efrgpPG76T1Y=;
        b=Qposv00dtVpZDSqZs1N0QUgzTx2k2H6glYeO67l3ui3hZmAWElYuNOPd1rkvbr/geF
         f6vbBLBieaYGsN4I/JVKY9faTPKIAQfkTgS9sKDpBVwXk2qZ1sXyhcnisfmeeebk7olp
         OMr86vo+ACMwO/fifHdFw27Nloy/6B9IuxokAKwco7Q7nMMfDoQQqJES9dPwASaIrwQx
         /nJ6M1oPClptffVRGckMrNYXiCouN9txKjWkZayy1p8e572BcpjJu2/2WjqNwO1dfFuc
         QafZy+qR38KW1Anfk9+dn8wNsi9JFIGkW7LAdjWx+p1hu6/VpeCfAxwFctgaFBcXJaXM
         lOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JHnG0Qt8Q8UOZMoGZkQPlCPmbW+eVM6efrgpPG76T1Y=;
        b=i0bMs/fj8eVafvbI3D8cOnp5Rz6BKVTaTZ9mS4l1AJpiY1OUr+ZH/Cbg2uIogDGerh
         Rg3gM6yMNa5g0GqpWtNS3ZrwawUriWb7HO11kPMmtw9bjJ3ZUGPmG7IAFsS0YC+jjvqN
         rEUKBOGCFzTjxjRwoLRyc6fVlog+IzfpkuZ254oce33bb/cCa15AVDs409wh9rWhNVqW
         KFufUQ5Pukv5a/oz6pVBZBmaw9hb1p/lhTFTanJ8jWRfhMSzs1L5jdbHrCPfY4S7xJ2f
         gDFQ0KcMQlq3m0KAwdy5PkiUlr5iVTgZkVU1ex915inrRbL0qvUewFSrCXjpBVsBxy/r
         19cA==
X-Gm-Message-State: AA+aEWYLYTDimrJZUI0RCvdcR+spXQ1nd5MQi1nI2vczruQ0EG6pdzN8
        UpHj+OfJBi3ksab7kp36FFQ=
X-Google-Smtp-Source: AJdET5cIZqXp934eO0XKvbD1zUznpO53e4IjB3EUiHwV0Ph4N35er7UgT/SS7i8AXkmg57nOGl7DKg==
X-Received: by 2002:a1c:aecb:: with SMTP id x194mr21951039wme.96.1543239462438;
        Mon, 26 Nov 2018 05:37:42 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a1sm339618wrw.76.2018.11.26.05.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 05:37:41 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:37:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 00/28] x86/speculation: Remedy the STIBP/IBPB overhead
Message-ID: <20181126133739.GC108014@gmail.com>
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125183328.318175777@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Thats hopefully the final version of this. Changes since V1:
> 
>   - Renamed the command line option and related code to spectre_v2_user= as
>     suggested by Josh.
> 
>   - Thought more about the back to back optimization and finally left the
>     IBPB code in switch_mm().
> 
>     It still removes the ptrace check for the always IBPB case. That's
>     substantial overhead for dubious value now that the default is
>     conditional (prctl/seccomp) IBPB.
> 
>   - Added two options which allow conditional STIBP and IBPB always mode.
> 
>   - Addressed the review comments

With the typo review feedback outlined in the discussions:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
