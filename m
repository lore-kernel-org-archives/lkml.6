Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C115F21788
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go0xzKAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C115F21788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeHQTMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:12:42 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39234 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQTMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:12:41 -0400
Received: by mail-yw1-f67.google.com with SMTP id r184-v6so4552606ywg.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vcbqEx7UFdEFmAEgSGZ271EXkgERQAEZnIF3GSD3LOU=;
        b=go0xzKACUlP7N2xKSOBNC7n1f82WAbVqwbzwVzbtQmNeqAwAnlNATLNEk2xmNKG421
         djKUfM27wn6gHEFQQwVXyOmqy4GzHwIKOYKiIvwp90LwrSiozURsSs+mKz6OiYCt3nWz
         GT/briDv5OaDKo42q/bLwlktIEcN7Es+ASw06nJv9LBLaYhZtd0H3ouBwERODKkuINHW
         ViSYNxZcJJToB+nfROBhe0wDeU/sy3cQWp9EMVwED4CftkUtXX5D6JBJU27Vgkff3m5z
         p+T75aFJzQew8MrhpvqAHwvaFhzNedRy5cpIvdh0An41ryPRIe+NNAK1Wfe8JiA1MwM3
         at0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vcbqEx7UFdEFmAEgSGZ271EXkgERQAEZnIF3GSD3LOU=;
        b=b/BPFEH1bIOQYNJez4/C6YHXzq42QtJoruGBQH1cq8NIevJTaiaOJTtyK3rt1rLp+D
         sLtvJw7bU8H7BqH1lrge6E+cpAfZh0E+/MB6Fjr7OnOHfOn8XdVq9CdVD097w/BRxWU1
         hIkqslAEK91pCUMIZ7dmf4B/2i6ubnrLRj7kgGcmznLng/hR5afzfVOULAn3WH5ITtwA
         EeTPkRXGn8gJJWJfuObTmMElpQwDeTdWpX34V8u+YWqI312M/u4yY7X6ATzZLD6ga5GF
         som0V9uyVSB27Da+YCfcLSpkR8VLQjJu+LdYvnUlFxt1V+wUAPa9Q4xd9MjSkJ+SI6ch
         SDIg==
X-Gm-Message-State: AOUpUlFqpuohJAmDd6PAg3Ch9hMW8ckk7NADM5cw7YjaZ8GiJYctx0OA
        MXQqjiwaAjJlWSdfWuQQ+lI=
X-Google-Smtp-Source: AA+uWPwlZwpg83Bnyw5WWb9id9LmbhOBgeOEPp9Qls2biCO+HFyBlA9w0fCfDAEqKGb5DwzOKQG4fA==
X-Received: by 2002:a81:af23:: with SMTP id n35-v6mr18561337ywh.468.1534522125082;
        Fri, 17 Aug 2018 09:08:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:9b8b])
        by smtp.gmail.com with ESMTPSA id f5-v6sm1304037ywa.39.2018.08.17.09.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 09:08:44 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:08:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] Make call_srcu() available during very early boot
Message-ID: <20180817160842.GK3978217@devbig004.ftw2.facebook.com>
References: <20180814162448.GA20414@linux.vnet.ibm.com>
 <20180814124945.5cf1753f@gandalf.local.home>
 <20180814170618.GA24813@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814170618.GA24813@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 14, 2018 at 10:06:18AM -0700, Paul E. McKenney wrote:
> > Is there a way we could make a union, or reuse one of the other fields,
> > as we know that synchronize_srcu() can't be used yet (and if it is,
> > either warn, or just make it a nop). And when we call srcu_init() and
> > remove the srcu_struct from the list, we can then initialize whatever
> > we used as the temporary boot up list field.
> 
> I will take a look.  If nothing else, I could union it with the
> struct work_struct, since it cannot be used that early anyway.  ;-)
> 
> Or I could just use the work_struct that is already inside the struct
> work_struct.  Tejun, would you be OK with that?

Hmm... not super against it given how specialized the whole thing is
but maybe just making it a union is cleaner?

Thanks.

-- 
tejun
