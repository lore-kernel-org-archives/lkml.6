Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9B6C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C7F2184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="WUybDOPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfBAC6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:58:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43298 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBAC6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 21:58:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so5903518qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 18:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eKzGGb5J7xnw7YW9klEzISreEEiI8ajXRNdS4HRdGss=;
        b=WUybDOPT0Ir6GsF67zeiTl4e+obVjnbqnKajN9ynkx2TUorRE78G8h797zfEC4US+o
         CyZXCuPyzEgTAheG4maLrlxAuTZCu1z2E3z220ChhxSM1dtGqkTfBTZYynVXZqRV42h6
         nSvYYRKIdNgkukoPBcM9JvKPZ+5PuUv7qM/vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eKzGGb5J7xnw7YW9klEzISreEEiI8ajXRNdS4HRdGss=;
        b=ic2eHnjhEEzirBOcJnBVlfpFNsy6adgO5PnSC7pEsUNHe6PAOo0Zl+KHkwvDmvYjN+
         DQPvCq5VAnZQT+jwOCj4pooNw7g2KbKbK+TTIK/Rqu93IMeQ1xjzZhbIsM4iWBT5WaC9
         kTKG4HEJ60lEcdNYcD3Lk3OKwAYK+XhizvXg+aryP4ox53OIcjE8hyZQFbt6MxiOYwo5
         +8ixNeE1O9Q5SmC5snxEIYYSjf7QGlE6TbSpu+IGVybwnlcs56Q0upjJtm8pRdVSjE4+
         Sw2iwW0DNESuLb0GkqwY7C0oyKf+yNQSVaGJHzrfrxplIL16QlLD+/QIQnqdKkc22oOy
         zXrQ==
X-Gm-Message-State: AJcUukfEKuDc0aPtYW8JwMVNDL4shq6yAKsqII5Nw6mpHwtYGWh1xLRk
        J+TrrWIK+Jy8+Aup+Cz+T07xnQ==
X-Google-Smtp-Source: ALg8bN6eJMVhvueQhK5gMoovSnrfMbkM0Rsbw0mcoPdCGI+oVpbNIPAeYc7bMCyRD5MSLYvKDVDfUw==
X-Received: by 2002:ac8:32b2:: with SMTP id z47mr36186503qta.209.1548989924561;
        Thu, 31 Jan 2019 18:58:44 -0800 (PST)
Received: from localhost (rrcs-108-176-24-99.nyc.biz.rr.com. [108.176.24.99])
        by smtp.gmail.com with ESMTPSA id u7sm11111412qkg.79.2019.01.31.18.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 18:58:44 -0800 (PST)
Date:   Thu, 31 Jan 2019 21:58:43 -0500
From:   Chris Down <chris@chrisdown.name>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: Expose THP events on a per-memcg basis
Message-ID: <20190201025843.GA19018@chrisdown.name>
References: <20190129205852.GA7310@chrisdown.name>
 <201902011021.dwu1fKhG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <201902011021.dwu1fKhG%fengguang.wu@intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot writes:
>Thank you for the patch! Yet something to improve:
>
>[auto build test ERROR on linus/master]
>[also build test ERROR on v5.0-rc4]

This was already fixed and is now in linux-next.
