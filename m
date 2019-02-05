Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E98C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C399C20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549401223;
	bh=0pYj1Ss54pSBHM4xfIqstKmNEOARAyWYQBMMGN91avU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cLtx91os57aCm/6K5KzXlOveChkmyLGcm8lKj74Bz9wDnAn785PAluZOFw0DBep3n
	 hHK3lderoCobR6dEj9lQg2yp+M1MLmFNnmV0V35JWv/bvhgB1jreDBsfl/tIuEcifU
	 8Xp7+qxWWGrZkG6CdqfN1WKCf3dZsp7/xn9vF/hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfBEVNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:13:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38415 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBEVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:13:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so2072220pfi.5;
        Tue, 05 Feb 2019 13:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFPQD0DGcHmEEBGEY8lzMWYsqX5YvqyV7GCO8ulw+Pg=;
        b=GijfyttG/w8t4vUR5g3hHmpYauPdBMa3M08I13kvwieYsAYR+LD8t71KpjpLBZZZrq
         c2c00j3vmMSVs5Vut2AiFghelQBDToKVw04rDr4ArXVjTw67dIrwIgjN/70111RYKVLh
         T4NNlal3saPOph0Q6WmcFt/iqhRm1fgMOicSkhQrxhK9RXoaGf1s40WIhkbfQX+v9BAF
         ts6fRI5JWaTfw1jykbietkbmnjBgaiwMc24frfK136fgHJfPETKiKmRIOSiNQjqAtqRe
         89FQU38FcyWpGgETJuExp2yVUldyC3cHVgimfkb7n73RJxfV8vnpNFctAWsc5DlRfsIW
         deCQ==
X-Gm-Message-State: AHQUAuYvg71dJLqggwQz3yvAf6npGKUyhRWz3bJHo3lq96TaeiTEvRdX
        w48lNqZWzs/695NSFxOltgFzC9Bxm7U=
X-Google-Smtp-Source: AHgI3Ib5wfeO4XJe9GediGhb2gFPcnRC2yB8zHKbv+u/GwZZCFR0ZvxoUDj/1/A6y0MGcZkhGUw7wA==
X-Received: by 2002:a65:488a:: with SMTP id n10mr6489187pgs.261.1549401220646;
        Tue, 05 Feb 2019 13:13:40 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id j9sm5038186pfi.86.2019.02.05.13.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 13:13:39 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Tue, 05 Feb 2019 13:13:37 -0800
Date:   Tue, 5 Feb 2019 13:13:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/ima: require signed kernel modules
Message-ID: <20190205211337.GX11489@garbanzo.do-not-panic.com>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
 <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
 <20190204203850.GP11489@garbanzo.do-not-panic.com>
 <1549317910.4146.124.camel@linux.ibm.com>
 <20190204223026.GR11489@garbanzo.do-not-panic.com>
 <1549369479.4146.142.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549369479.4146.142.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 07:24:39AM -0500, Mimi Zohar wrote:
> On Mon, 2019-02-04 at 14:30 -0800, Luis Chamberlain wrote:
> > On Mon, Feb 04, 2019 at 05:05:10PM -0500, Mimi Zohar wrote:
> > > On Mon, 2019-02-04 at 12:38 -0800, Luis Chamberlain wrote:
> 
> > > I don't see a need for an additional LSM just for verifying kernel
> > > module signatures.
> > 
> > But it is one, module signing was just spawned pre the boom of LSMs.
> > 
> > I do believe that treating the code as such would help with its reading
> > and long term maintenance.
> > 
> > Anyway, I had to try to convince you.
> 
> Perhaps, after IMA supports appended signatures (for kernel modules),
> I could see making the existing kernel module appended signature
> verification an LSM.

I don't see why wait.

> For now, other than updating the comment, would you be willing to add
> your Review/Ack to this patch?

But I don't particularly like the changes, I still believe trying to
LSM'ify kernel module signing would be a better start to help with
long term maintenace on this code.

Also, do we have selftests implemented to ensure we don't regress with
your changes?

  Luis
