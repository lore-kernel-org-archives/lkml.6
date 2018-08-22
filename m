Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A802C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9EF21480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxLCjBAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9EF21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeHVSYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:24:04 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41684 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbeHVSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:24:04 -0400
Received: by mail-yw1-f65.google.com with SMTP id q129-v6so745911ywg.8;
        Wed, 22 Aug 2018 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Z9ZfxIvUwL3fTrnXWg72P1xFzFw2cH2SiyagF+m3Ms=;
        b=cxLCjBAFu7j/d2L0Tm6YIzL3cE2bztqZbmJR4SvwQ3gHVGDljOrSHO6Xni3bAUQVrM
         m4iub27LZ/QhR2ie5ktWFPELifPMo0GQ1G25G5Tbj3jRi8AkQU+KKGlYd/Q6u/rVeSgF
         G6fYjy3lHgw7Pey5/vTx3bUMTVqhlbwLSjn4pvbLveTgbwHdDT+2PxdIWk/DHwASAD9v
         svkpoMB6qxbrD60qRwLwcRmxjCmlfbXQ04JcDRMAamicEXm/yLwy5EqKhcglZDJCvtJg
         tYpYXxoHeXMbk61oVIRomfksz3nH5Bg6k9gD5pIl0a70VGr1AlUHGskCBRWX2lZbDmjh
         YfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Z9ZfxIvUwL3fTrnXWg72P1xFzFw2cH2SiyagF+m3Ms=;
        b=QCh2XuOangzFhw++tZIGHus8UyFACK0/g2g7npfhQGoqCQ1NutW9MvgfBTtyn1Sono
         KDis0ZXGuAXiE/iqiSQYc+9NLF24TSL6E2m+/x87bO+qccbtF1BPiNCkypxqer8T0/fc
         U7cykCLhORQqAdtqI83zh83qrNq2rUj6aI/8TxLURasoRFnHK74N5i8IUljdr9JrYKgo
         Gn5/m2bvbdvpknRoADvzJ1psE5qMJq7MCAtKPCncTO9NuG1Z7wjkNCxBTyX0rrXBxSKP
         XSqke/NsKJXPKwJEqcftWG9ORjsu0yuTSm8+q1EG8dbHH8maxumsnGqlNvz/7GQs3v0U
         0wsw==
X-Gm-Message-State: APzg51DdSTJ3ugCsYFUu8NXogkUVDHLCDzJDQQ26Euy7WMxVaApq8iQF
        t4A5DkdUILRoXUOOWJOj67g=
X-Google-Smtp-Source: ANB0VdaDEFwm3mGaXegcmWVdfbGZV5o3GyAu/nZN/cPH8ouddyoJpzjLu4qXfetOja2j2tvFODojqQ==
X-Received: by 2002:a81:6e07:: with SMTP id j7-v6mr174848ywc.495.1534949929896;
        Wed, 22 Aug 2018 07:58:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1dc9])
        by smtp.gmail.com with ESMTPSA id 203-v6sm808027ywv.34.2018.08.22.07.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 07:58:48 -0700 (PDT)
Date:   Wed, 22 Aug 2018 07:58:46 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC 2/3] proc/kpagecgroup: report also inode numbers of
 offline cgroups
Message-ID: <20180822145846.GT3978217@devbig004.ftw2.facebook.com>
References: <153414348591.737150.14229960913953276515.stgit@buzz>
 <153414348994.737150.10057219558779418929.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153414348994.737150.10057219558779418929.stgit@buzz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 13, 2018 at 09:58:10AM +0300, Konstantin Khlebnikov wrote:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 19a4348974a4..7ef6ea9d5e4a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -333,6 +333,7 @@ struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page)
>  /**
>   * page_cgroup_ino - return inode number of the memcg a page is charged to
>   * @page: the page
> + * @online: return closest online ancestor
>   *
>   * Look up the closest online ancestor of the memory cgroup @page is charged to
>   * and return its inode number or 0 if @page is not charged to any cgroup. It
> @@ -343,14 +344,14 @@ struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page)
>   * after page_cgroup_ino() returns, so it only should be used by callers that
>   * do not care (such as procfs interfaces).
>   */
> -ino_t page_cgroup_ino(struct page *page)
> +ino_t page_cgroup_ino(struct page *page, bool online)
>  {
>  	struct mem_cgroup *memcg;
>  	unsigned long ino = 0;
>  
>  	rcu_read_lock();
>  	memcg = READ_ONCE(page->mem_cgroup);
> -	while (memcg && !(memcg->css.flags & CSS_ONLINE))
> +	while (memcg && online && !(memcg->css.flags & CSS_ONLINE))
>  		memcg = parent_mem_cgroup(memcg);
>  	if (memcg)
>  		ino = cgroup_ino(memcg->css.cgroup);

We pin the ino till the cgroup is actually released now but that's an
implementation detail which may change in the future, so I'm not sure
this is a good idea.  Can you instead use the 64bit filehandle exposed
by kernfs?  That's currently also based on ino (+gen) but it's
something guarnateed to stay unique per cgroup and you can easily get
to the cgroup using the fh too.

Thanks.

-- 
tejun
