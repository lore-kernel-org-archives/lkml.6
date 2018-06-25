Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA91FC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EC62617D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Q95XAsPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EC62617D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeFYVZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:25:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32919 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeFYVZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:25:57 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so7428986plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUkTESzaDq0uOG7zppY+HC+sVwJ2xOyMgqqcET9Ay8M=;
        b=Q95XAsPyLQG0T4dllGrMwIC3bxBHeoZEPMh2IJt4eV2FSMsqqJveQjwPFJ5v/+94M/
         87R6V/fthVYbCd74guPGXsG1uu6ZWLLL8vpTsPOCNN3kGYWt0F4Fddgg9g53p/TQ1HRL
         Yue9lz/BZy6r1V0unXSJJPnMhnUmNhORJgszE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUkTESzaDq0uOG7zppY+HC+sVwJ2xOyMgqqcET9Ay8M=;
        b=TXS8J8o+UWSeTaGjjuF0Pd5PaMQF3DFm/CmER4cnDrAumikSZ3C3vvl0U0PbppRePQ
         XGI3WS25Y0KUKjNBvgYEgjztqc/xP/cNkxFUb2EKWQMDjFWHfUfcUwzIYVERr8SA6iNT
         nslG2I7aUDrDuj363eEuiHiH8WiUX2q4mlTnUeFQj6/o4J97bprIGVoYatU+QxgIp46o
         i7H6L1ZkREpTnGRd9PojI1IbP0uwlbCXAKU2s4qagpRRRIKJMYRSTjqYkg+xc4RnoI8n
         AaCaVRpBj0HYPyngjgDGODGuDgvwtVFq4IbRRZl3RbLNqjg31WzaWVh5ad8oSKf0O/yI
         JsPw==
X-Gm-Message-State: APt69E3i85cowYLv86vJ7QgQQRBIVaaVEUsuQYwhJvNmFFiJQPuDhn/+
        6konX+zPXDY37a13QTTeAarhYw==
X-Google-Smtp-Source: ADUXVKLM7VT/l9/EWPAUTYQP3zUyPr7R8MTI3Z/NkMmis6b1CcM2HjgNpPeL6muwL+5s2DTy+7hJbQ==
X-Received: by 2002:a17:902:a702:: with SMTP id w2-v6mr5239263plq.41.1529961956474;
        Mon, 25 Jun 2018 14:25:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id 14-v6sm3657499pft.10.2018.06.25.14.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:25:55 -0700 (PDT)
Date:   Mon, 25 Jun 2018 14:25:55 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180625212555.GA179242@joelaf.mtv.corp.google.com>
References: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622143247.781028b1@gandalf.local.home>
 <20180622200548.GA114655@joelaf.mtv.corp.google.com>
 <20180625082824.GB21377@X58A-UD3R>
 <20180625163951.GA52646@joelaf.mtv.corp.google.com>
 <20180625162557.7140664c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625162557.7140664c@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:25:57PM -0400, Steven Rostedt wrote:
> On Mon, 25 Jun 2018 09:39:51 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > For whatever its worth, I made some notes of what I understood from reading
> > the code and old posts because I was sure I would otherwise forget
> > everything:
> > http://www.joelfernandes.org/linuxinternals/2018/06/15/rcu-dynticks.html
> 
> Nice write up. I may point some people to this ;-)

Thanks! :)

> Anyway "complications due to nested NMIs (yes NMIs can nest!)"
> 
> What arch allows for NMIs to nest. Because we don't let that happen on
> x86, and there's code that I know of that is called by NMIs that is not
> re-entrant, and can crash if we allow for NMIs to nest. For example
> "in_nmi()" will not show that we are in_nmi() if we allow for nesting
> of NMIs. It has a single bit that gets incremented when we enter NMI
> code, and cleared when we leave it.

Great point. Andy mentioned something about MCEs in the other thread, I'll
let him clarify how such nesting is safe in light of what you mentioned. ;-)

Thanks,

- Joel
