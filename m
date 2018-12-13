Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089E6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37AE20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE61p72M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37AE20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbeLMEf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:35:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54121 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbeLMEdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:46 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so1852909ita.3;
        Wed, 12 Dec 2018 20:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H39OR58W3acsQBEa1YAZ1/XuUL+6hxZA0kPr2fFpAxU=;
        b=JE61p72Mt8+5KKTfpZqabd0qgE/RAvgnmiUkNoCc62hKrNsSn127sLQEQm3VpE+3UW
         A9F1cAcLKpUXsC9RNE+F/WAdkMiyTpClpxKT1Ce4fcCOuG84sLdLjiRgm9VeS8ExvcSL
         9SleeLE7Z4oCrzZk0Wz2vblEEIGGyvaYz6V9fAuiVv49gqUlF0ko/2H4qeYh6Si81QBy
         /PV4KQmonvBiuolZ9yEQ21UpSb8yaG3TYC9N2O/KFIwKfaPh25YvVj1ahVKOPVLFXw7T
         EijLxo+0XYqwDiBuatNjNo1o61Q8EsBxr9WgjazauCP7J2hg1/u9kcbSHsY66kQ1fYeu
         KxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H39OR58W3acsQBEa1YAZ1/XuUL+6hxZA0kPr2fFpAxU=;
        b=ULABU8pXxi8KUPjHaFmeDKg3dnaJW/Efo38nB4+4NXoC1x/MGXm+Bwx+26YDtEvNJd
         d1yUoSxP4qLJ209sbIwY4ITf2ullaolbzkFUXt8VzEtt22nZnUtbLL/Z6kgxvb1AVs4K
         rsmJrzUMMjwScVovU6XHW/uxUqHSaQhWL4xKD29B/p+oNDAkdab96n3+RS066TaEz3VJ
         GNBrwM06pn3fPJnFp+1HKai27h0X2Jqe0IA3cnUo2F+7XPzGrq59ujUBNqsFaKlg+yqZ
         /weiIilBJsQYb1k+EnR+gG1ajLf97H1Fqe4I17uyKB0NlcUeVtsEciW/WmkEj5h6PeCP
         vv1g==
X-Gm-Message-State: AA+aEWYmPNaxladlgvtwxC5YQmeN+BXPzkSCmHR09mhcPe+LS1LbRc8D
        9OHQGX4EiGN/+fDOtWm75BQ=
X-Google-Smtp-Source: AFSGD/VTWwj5XW6SBvUyf2p8UsEMQpehewIpGuIQMqgKQ5LgHZfhNYyArWLRAXy/XFpNCBfGU4ecEg==
X-Received: by 2002:a24:19d5:: with SMTP id b204mr8316662itb.6.1544675624976;
        Wed, 12 Dec 2018 20:33:44 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:6dde])
        by smtp.gmail.com with ESMTPSA id y21sm359135iof.51.2018.12.12.20.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 20:33:44 -0800 (PST)
Date:   Wed, 12 Dec 2018 20:33:41 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     sfr@canb.auug.org.au, daniel@iogearbox.net, ast@kernel.org,
        netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next: Signed-off-by missing for commits in the bpf-next
 tree
Message-ID: <20181213043339.znj2674c2povyl2n@ast-mbp.dhcp.thefacebook.com>
References: <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
 <20181213094820.62d26354@canb.auug.org.au>
 <20181212233909.hhf5q4vpi3mmi37u@ast-mbp.dhcp.thefacebook.com>
 <20181212.164526.189502766995329983.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212.164526.189502766995329983.davem@davemloft.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 04:45:26PM -0800, David Miller wrote:
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Date: Wed, 12 Dec 2018 15:39:10 -0800
> 
> > But this approach doesn't scale.
> > We do rebase our trees when we need to fixup or drop patches and
> > at any given point a number of commits will be committed by me
> > and another set by Daniel. When we rebase we cannot keep adding
> > our SOBs to the other person SOBs.
> > Then comes the next rebase and we get to the point of
> > double and triple SOBs ?
> 
> If you use "--signoff" in whatever commands do the rebase you will
> get exactly one signoff for yourself and Daniel at maximum.  If it
> is there already, git will not add a duplicate one on top.

If Stephen's scripts can recognize SOB anywhere in the log then
--signoff can theoretically solve it.
Unfortunately it's "Incompatible with the --interactive option"
So we have to do things manually
or fix scripts
or fix git.

