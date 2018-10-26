Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFD7C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346762082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyQKPceA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346762082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeJZRrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:47:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43557 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeJZRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:47:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id y22-v6so435947lji.10;
        Fri, 26 Oct 2018 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HCMdC6HtqwsUWuIHcmvcGrVj+BYFnTU4ijoQ+qwyhEw=;
        b=SyQKPceAC6P00V3bNeWzCtAdukRa8xi39EEp53RxmNDD0j2LYaZhH70QzebgRg6CwD
         VOLMmtFc9cCPr7TZ8QKgAlNNMOoeinPb5VRTj/XHoqInY3eIye6jmU6Kyh+Ixs1OIh0Q
         oV7n7X7XAnfuERXxg5XwJIw8KnaUDxwl500MbBU6ORgRn8YvACbh1DGeriJOdUzwcSdt
         DG3tbVtqRve3fC4aaCA3+vTumlDP8UCvx4edxvCt+fwHG7Q4ra8hlcRSe1k0NYO0Pu2J
         cIc89/HZuWI8QX1m2XB7tpdKiuaK0T6Y1oMIjmKX8k5d7WGkG63QXdG3GmpY49rX8srU
         E57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HCMdC6HtqwsUWuIHcmvcGrVj+BYFnTU4ijoQ+qwyhEw=;
        b=IYdgOQwJrMrGA1VZqmKMM6t/SBPydqFjaQJpTzb/lFNCsD5m59MC6hyMhYDKAF9ADY
         NDInHsCgBAu/oEuawReLx19wz2kiIu9Tr2yDPUrobwxvIaB5CpoCpY8IGWGrSa8ITxIG
         a9kg23DuhgjiOwA7MB92My9nxw4Gt69QV3bJvELGVX5C1ETUsH23rJiU1QPMzW4tXijG
         mL1IQAdJB3QMUY9CVCk0/zCM15sEEWZkkHk38cTaxa8xyhlibEq+fFSQ42fEOtYmGjrM
         JClNSZ18NI+R9tuCmwTNIlIB4cGqCSPEJpArY94yPe5o2hc7szw7CHIjZisi/Sgb0OEc
         JFfQ==
X-Gm-Message-State: AGRZ1gJSlbXQgryU4Kj/D+ozQxFm4wh9ZBbHTw1US5I9pzS72a4Pu118
        l+pyxNH7dN1gmnwcyTOi/Zc=
X-Google-Smtp-Source: AJdET5c8ASYNBuW3OqZ9OCOar4Sr0ccJqj9kugI9BI/jS80z4L8BiQD7vzKjb+MFIcb6uBBcFWwiqA==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr931687ljb.106.1540545090163;
        Fri, 26 Oct 2018 02:11:30 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b22sm642982lfg.32.2018.10.26.02.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 02:11:29 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gFy9P-0003c2-GU; Fri, 26 Oct 2018 11:11:27 +0200
Date:   Fri, 26 Oct 2018 11:11:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     Johan Hovold <johan@kernel.org>, Sasha Levin <sashal@kernel.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 3.18 04/98] USB: qcserial: Fix support for HP
 lt4112 LTE/HSPA+ Gobi 4G Modem
Message-ID: <20181026091127.GD27852@localhost>
References: <20181025141853.214051-1-sashal@kernel.org>
 <20181025141853.214051-4-sashal@kernel.org>
 <20181026084920.GB27852@localhost>
 <87ftwt5bdr.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftwt5bdr.fsf@miraculix.mork.no>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:02:24AM +0200, Bjørn Mork wrote:
> Johan Hovold <johan@kernel.org> writes:
> 
> > Note that the stable tag above lacks a version comment (e.g. "# 4.19"),
> > but I can see how that may be too subtle to convey this (and not all
> > maintainers use those). Perhaps an explicit comment should just be added
> > in such cases.
> 
> I have always thought that the inclusion of a "Fixes" tag made such
> comments redundant. A simple "git tag --contains .." returns the same
> info, and is more likely to be correct...
> 
> Or am I missing something?

No, you're right. I also assume a Fixes tag to be sufficient these days
and any version comment to be more of a hint for humans.

> I see the problem with matching up fixes to backported commits, but I've
> assumed the stable maintainers all keep a small "database" of backported
> commits to make such tasks easier.  That's what I would have done, and
> they are much smarter than me ;-)

Indeed, and that would also catch things like dependencies and other
commits that eventually end up in the stable trees. This could also be
automated based on the

	commit 59536da34513c594af2a6fd35ba65ea45b6960a1 upstream

that gets added to the commit message during backporting.

Thanks,
Johan
