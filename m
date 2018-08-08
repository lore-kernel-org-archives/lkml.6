Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6BCC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3702B21708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3702B21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeHHJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:31:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41146 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:31:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so675003pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 00:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCbvOFDDLeDU+hnXN70xASJgsQYq7jvnvp/nFdlEMBQ=;
        b=AOZrjTP12Zfaq6uXW5PypQgXlvSEUYJq0WFhBJE/CGoapZ6y1gz1NlbOzAbM1P/sQV
         5JQK3BD83wmQsWvX20HfYH9zv9wwthd+hCF6C2SiK5F5TRKTHvcoHQy47XYLClrmkKDA
         x2DIFaLysbyXLJzg096t1wtgw3c/E6VVrC3Hx9XGA0TmqbdbfJ3l8DI9rtZn22DR+0S9
         jahbY96D86N/rTBH/cscjVkiWJOCcww4lVLgR03nQcVUiG7ttHc2/718bPxNLofZNRk1
         0evmVu/DKH5bP5Yu/5YygZ96MpMaYn45cfnjf9O3wFuFCKj9b52rOBms7SiPjAKk0dLX
         RWPw==
X-Gm-Message-State: AOUpUlFNabFy68jcTiExAOR301vzXM4QRpdbmZ+yUjUWrplIJdfKjbzU
        rsXdmFg3ghfV6Q55MQO6WmY=
X-Google-Smtp-Source: AA+uWPzFPzZIGCZGmnVq+op8IKBKr6DR/7UNNEdaWuniBjgUfA1cSzdpItvafQshrrZXugZJ1zKy1Q==
X-Received: by 2002:a63:2359:: with SMTP id u25-v6mr1412145pgm.220.1533712391450;
        Wed, 08 Aug 2018 00:13:11 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n9-v6sm5517945pfg.21.2018.08.08.00.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 00:13:10 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, oom: be careful about races when warning about no reclaimable task
Date:   Wed,  8 Aug 2018 09:12:59 +0200
Message-Id: <20180808071301.12478-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808064414.GA27972@dhcp22.suse.cz>
References: <20180808064414.GA27972@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-08-18 08:44:14, Michal Hocko wrote:
> On Tue 07-08-18 16:54:25, Johannes Weiner wrote:
[...]
> > What the global OOM killer does in that situation is dump the header
> > anyway:
> > 
> > 	/* Found nothing?!?! Either we hang forever, or we panic. */
> > 	if (!oc->chosen && !is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
> > 		dump_header(oc, NULL);
> > 		panic("Out of memory and no killable processes...\n");
> > 	}
> > 
> > I think that would make sense here as well - without the panic,
> > obviously, but we can add our own pr_err() line following the header.
> > 
> > That gives us the exact memory situation of the cgroup and who is
> > trying to allocate and from what context, but in a format that is
> > known to users without claiming right away that it's a kernel issue.
> 
> I was considering doing that initially but then decided that warning is
> less noisy and still a good "let us know" trigger. It doesn't give us
> the whole picture which is obviously a downside but we would at least
> know that something is going south one have the trace to who that might
> be should this be a bug rather than a misconfiguration.
> 
> But I do not mind doing dump_header as well. Care to send a patch?

OK, so I found few spare cycles and here is what I came up with. The
first patch fixes the spurious warning and I have separated the check
and added a comment as you asked. The second patch replaces warning with
oom report.

Does that look better?


