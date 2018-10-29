Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB13C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D902082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Qf5dpBMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D902082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeJ2KC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:02:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43260 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJ2KC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:02:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id 30-v6so2962186plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 18:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kR/eUjzyO3DZ2lA5DhRx8E4YrP7im8f3HcYTQzzogLM=;
        b=Qf5dpBMoM02jHDrHos8NByjl0rNE1G0avhsF+G4AZheujoqsRKg9KnNw6nJvzCi/3J
         rnpt2iTUNsF5v3OFSck8cXJLy1cWMs9S6zKzTMAh7GvEqU4pPstoMQJ+SAlCdR5Q9vsv
         yMtIoZ3zHQyyQeeGci2EQTCfHGDXW6GLOWwg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kR/eUjzyO3DZ2lA5DhRx8E4YrP7im8f3HcYTQzzogLM=;
        b=haEmIrvKh7ANoOlNQLO3zY9rklpr3MkgEDAvTk/kyPoXcYmPPE9ITFZurGYAC+McEt
         tvw1O47KjUeLV9p4qVzloSdpUJtAHJb2M+vSFBXop9tApzGpmoDbOMpxq9ku+sFD1wuB
         ziU+L7PfZPcGsICQAHPuB3T8K5k2rztD4B+R0l2H0Cn9R2HKcwT8zgEIOwEyaj9vCBwy
         6dSAdDhME0Eq5MoOIEbDZTtT+dGAQ2lgHlvdnnZv3oURfL9wTBkQrcze8lGO9yYY9Onf
         FgtXxmt2NtL5DO3b9eXdlouqqMaNPDFO1l6ZR5mvFy6WnkAZaUDMB1KVnm1dI1ozZkmW
         ISAg==
X-Gm-Message-State: AGRZ1gKxwAtpU/aElzx0+KcHvM+WOpvjcfX8JEDK6KEk115W0c237fpb
        c0mv+pgssZNxEqRdZQPqNVd3lw==
X-Google-Smtp-Source: AJdET5fQTUt/0nv7G+sxhHHbu8TgpgxthN5e+n5Cf+hIYmQ88emFztjBwyyUhyY0Mt0y8q9NL3+Sew==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr12465092plo.188.1540775794402;
        Sun, 28 Oct 2018 18:16:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id o1-v6sm19077662pgq.21.2018.10.28.18.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 18:16:33 -0700 (PDT)
Date:   Sun, 28 Oct 2018 18:16:31 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] rcu: doc: update example about stale data
Message-ID: <20181029011631.GA261737@joelaf.mtv.corp.google.com>
References: <20181028021653.155513-1-joel@joelfernandes.org>
 <20181028172142.GN4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181028172142.GN4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 10:21:42AM -0700, Paul E. McKenney wrote:
> On Sat, Oct 27, 2018 at 07:16:53PM -0700, Joel Fernandes (Google) wrote:
> > The RCU example for 'rejecting stale data' on system-call auditting
> > stops iterating through the rules if a deleted one is found. It makes
> > more sense to continue looking at other rules once a deleted one is
> > rejected. Although the original example is fine, this makes it more
> > meaningful.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Does the actual audit code that this was copied from now include the
> continue statement?  If so, please update the commit log to state that
> and then I will take the resulting patch.  (This example was inspired
> by a long-ago version of the actual audit code.)

The document talks of a situation that could be but is not really in the
implementation. It says "If the system-call audit module were to ever need to
reject stale data". So its not really something implemented. I was just
correcting the example you had there since it made more sense to me to
continue looking for other rules in the list once a rule was shown to be
stale. It just makes the example more correct.

But I'm Ok if you want to leave that alone ;-) Hence, the RFC tag to this
patch ;-)

- Joel
 
