Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF95C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29761206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EglXUN+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfAICm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:42:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42718 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfAICm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:42:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so2886022pfr.9;
        Tue, 08 Jan 2019 18:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O5lY45eB1sB4ASWsJzgdIzA2Vs/j2EC5fVayf0kSdi4=;
        b=EglXUN+gkVL0SwFlxLZzUcKKWxybM2euLfK5umsPqhBTYeCFonLRH+PK6cDkeiqNYa
         n+TsXpD/dYpOerHTSySFDl67ihz2pne3EOZQosjQrH2p4nTaRlJJHqT43HFAyUaiScxK
         cFat8adiYHXLYhQ0ve+8cPbZsEMk52LKVfulrTkjlB2gO4l7XlnYG6i82llVzkSfiMk+
         NzNfKJp/oCBTzrpeaaIkoUNv/6YvLJxhdYaU4Q0/mZGtz6GksK8awsxPgRNXSSGkKlwl
         +a0M/29i8NkUwaZCcW4dFCk5+ERMfuowNHTMywyQTDbpezWgWPEIrfG3ZDRQYBw0A2re
         R9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O5lY45eB1sB4ASWsJzgdIzA2Vs/j2EC5fVayf0kSdi4=;
        b=m5X6is6cYG/xkW4+LdQ09GeM16vDewwDmNnASvzfaln426TSvb4uDM9bF6rCX+4Ou4
         0B01xjg84+q/ESJ+fYpiZVM5tp6BnA+45W2vWwxb8GdJrFfKB+cm5N54QnWBm/jWO6vq
         cIMe+13TF37y6Y4H0Exo4ugLNj1nnSQES8simHZqsHSepGj76F6WOCPRH8POFpXzO/Yb
         fSEbni2sGFcE+durv+CI/8z8xnx6phvkqrqpC0UpqzJMb+amA/Jv10l22DPTT2coqVVw
         aU/UYzkmZOlfgz6De2DrbhSBGtFx3F8gTb3u8oLxvtsq1fMlisuVCgTFF/cNSdfTiKHx
         mgdA==
X-Gm-Message-State: AJcUukcKsjMc2QH0Ca+LQnqCBgMy1lZUmfRypVH2e4wv2BSzd0rlxTPw
        o/YwTuzMJmN+vOXXTiLC2jU=
X-Google-Smtp-Source: ALg8bN6lRQ+tsNrh8aecP8y1sC0yzHuGiOefD57T1wFoRnPzWEy1ZARxEJWllDZP90MuM9b/FzkPnA==
X-Received: by 2002:a62:6b8a:: with SMTP id g132mr4243937pfc.201.1547001746784;
        Tue, 08 Jan 2019 18:42:26 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::7:958e])
        by smtp.gmail.com with ESMTPSA id j21sm100144893pfn.175.2019.01.08.18.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 18:42:25 -0800 (PST)
Date:   Tue, 8 Jan 2019 18:42:24 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and
 its mitigations
Message-ID: <20190109024222.izaveh2jm4mqtihk@ast-mbp>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
 <20181223231149.5yuenb53pavlvr3m@ast-mbp.dhcp.thefacebook.com>
 <2278b1c7-5d20-3c89-eab1-ea34145dc73d@linux.intel.com>
 <20190109011130.wrsrcaly2mgnou3k@ast-mbp>
 <9a2611f0-eaa6-ca7a-d47a-a86f4ca89ac6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2611f0-eaa6-ca7a-d47a-a86f4ca89ac6@linux.intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 05:41:37PM -0800, Tim Chen wrote:
> On 1/8/19 5:11 PM, Alexei Starovoitov wrote:
> 
> >>
> >> Alexi,
> >>
> >> Do you have any suggestions on how to rewrite this two paragraphs?  You
> >> are probably the best person to update content for this section.
> > 
> > how about moving bpf bits out of this doc and placing them under Documentation/bpf/ ?
> > We can create bpf_security.rst there with specdown mitigations, best practices,
> > useful sysctl and config knobs, etc.
> > 
> 
> Maybe we can provide some minimum but accurate info here on this category of Spectre attack
> for completeness.  We can later provide a link to bpf_security.rst here with more details
> when that becomes available.
> 
> Otherwise, I can remove it if you prefer.  But people concerned about Spectre will most likely read
> this doc first.  I want them to be pointed to the detailed BPF security doc. 

since Documentation/ got converted to .rst, the links made it easy to follow
from one doc into another.
I think splitting big doc makes it easier for users to read
and for us to maintain/update.

