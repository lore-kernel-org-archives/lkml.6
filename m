Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FC9C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5852C21943
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5852C21943
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeHLM1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:27:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41897 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbeHLM1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:27:18 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so22658790oiw.8;
        Sun, 12 Aug 2018 02:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcJNNIXhsFnRf7QJGNT1NHpEXD6wz/Ar8lx4MSCgQQE=;
        b=X2YYljufBrTGxRlEOIYTg17HWKHvZjPxbRlLPlZy9SO+J7VwXW+QKPJHCq/gLeAqvA
         QXFYbQOz9URy1uIlIhX4SElHWvS/U6h2NUhapXwgPkNiVs0g3XzwP7DbADhJY8EqywWF
         ym0nglV5gY045wRDpmyMwdfGQwpCEFf4urJtxG8rezZlPQyKVEzH6wwinAPu/td/nFf4
         Vncu/Xjyf6SZY7oJiwn6nC5+pTQfd5QGsrrLWa9HdQTCbJwujnUcnwapuZYXCYxXDsXo
         WCpVJmUCHAp1CJ7l5oFDIZK8eCJmwfCScp28sB3VtXbRwTB3KdYjMQS+c8mDSE1m0Wpj
         DJUA==
X-Gm-Message-State: AOUpUlHBCa7DZV5ivUWCylbb6ygISYspHDSICT8KoiWBPQHQXbemZt/a
        qNvE4ifb3t/IqO6Kk3zl6+lwjFP74F+4qA0pqWw=
X-Google-Smtp-Source: AA+uWPwwzbonVXLLHCvyAVZKQOH0Q2MvRaPkaavfDI4QdmFZYZUDLNgKCFeJfooqNerBXqrwoXsAoRLTc9eZvFyu054=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr13829577oie.174.1534067391612;
 Sun, 12 Aug 2018 02:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <2467271.WAtZ4Z8dKT@aspire.rjw.lan> <20180810091216.nieosjtu7l33z4ap@queper01-lin>
 <8482157.ZqyaK8WryI@aspire.rjw.lan> <20180810123032.ixay2e3hlrayifdy@queper01-lin>
In-Reply-To: <20180810123032.ixay2e3hlrayifdy@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 12 Aug 2018 11:49:40 +0200
Message-ID: <CAJZ5v0iODf2nUhMuyp6MXpLVdF3etDmyXz9OVRuQJ5B5Z=t2OA@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] PM: Introduce an Energy Model management framework
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@quicinc.com,
        skannan@quicinc.com, Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 2:30 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 10 Aug 2018 at 13:13:22 (+0200), Rafael J. Wysocki wrote:
> > Something able to say how the numbers used by EM and IPA are related. :-)
> >
> > Do you think that IPA and EM will always need to use the same set of data for
> > the CPU?
>
> Hmm, I would say yes. Both EAS and IPA basically need some sort of
> <frequency, power> table, so hopefully the EM framework can provide them
> with that :-).
>
> If the EM framework doesn't accommodate the needs of its two users, then
> something needs fixing ... Did you have something specific in mind ?

Not really. :-)
