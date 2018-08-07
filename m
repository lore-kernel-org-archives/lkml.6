Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F32C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1531E217D1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr10qgcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1531E217D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbeHGR0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:26:36 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:43409 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403820AbeHGR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:26:36 -0400
Received: by mail-yb0-f193.google.com with SMTP id u7-v6so2714880ybu.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bS+cUPtn3PD58LVABGjFnzNroeIh662wUjfFNil4uaU=;
        b=sr10qgcfrvj4qGjUK5zmxS6PH1+ACcoulC1q+6Nfxu3LQj7Q39mdsiqtA+IT1fOFRS
         cPlYdJdWq02WfreOzPAJe16jh1936/UhB6lbWuQaEyrpPngzNX+A3R9xHcqSpm9UzcjA
         aD5uoveiS3tlT3pHgRVDQJuJhd0BFS0MerJLFTBxi0kV23sWSIk1aQMl62erTMdCrXYP
         nRH+iStwoArBt9hAeuwVkwC6PN6Xx1Og8tBmyEdPSRHiDEKLts6ZEEzs5+Jr2FlBSIO/
         lFae412EElCt+Om4V9i3pKhAV6FRq1kWTS0KFjAJ9ww4JvzlT4y0huQR7fHBq3p3Fi46
         h/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bS+cUPtn3PD58LVABGjFnzNroeIh662wUjfFNil4uaU=;
        b=RuTfCR9RRr8qLz2YF6mTwVKm01Rz5lSCAq8qETmOeYKkDQvMMiJdL2XjOMMO/nrT0q
         y9vfCxRMyjfLXhN+/fdJQI35jFspTg5Cjtesn5XdFpa+QaHsBoQdvL8fnZAjdvj6ssFB
         OP5gXNVX8FqiMWX7WLHI/ErKJepmJZDtVfcHQbs1H/s/CnvpBhei1uOJIA6D4xoVjO/d
         fQAzQFlg4bN3nJtiauGk/99UXFj/MDFP3efpckFE1Z3ZdMVB55QUeMaOG7ebo7dJodvZ
         +v+maoVSBAlwhwFF2IcbKnogQFGtnXJ67nKmLq3Y2W5UUG7QgM3xPEz8xGYCP9EBA2Ly
         NdOg==
X-Gm-Message-State: AOUpUlFgO5vVuYumaZpZbq1XCvzfA8lkhVEZahcZa/jdHiopNj+yyjbS
        BepC5mV1y3Sx8jwQTEUznzA=
X-Google-Smtp-Source: AAOMgpeqVSnFN1NJc1UQMDEeiU+KSh3394muVRGtleNYuW4vPslXEFRDbjuMHpKo8+WoLVaoFNe1ig==
X-Received: by 2002:a5b:ad0:: with SMTP id a16-v6mr6338942ybr.245.1533654709169;
        Tue, 07 Aug 2018 08:11:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:2c4b])
        by smtp.gmail.com with ESMTPSA id t4-v6sm912670ywg.98.2018.08.07.08.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 08:11:48 -0700 (PDT)
Date:   Tue, 7 Aug 2018 08:11:46 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Dennis Zhou <dennisszhou@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: add percpu populated pages count to meminfo
Message-ID: <20180807151146.GB3978217@devbig004.ftw2.facebook.com>
References: <20180807005607.53950-1-dennisszhou@gmail.com>
 <0100016514bb069d-a6532c9a-b1ca-4eba-8644-c5b3935e3bd8-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100016514bb069d-a6532c9a-b1ca-4eba-8644-c5b3935e3bd8-000000@email.amazonses.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 07, 2018 at 02:12:06PM +0000, Christopher Lameter wrote:
> > @@ -121,6 +122,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >  		   (unsigned long)VMALLOC_TOTAL >> 10);
> >  	show_val_kb(m, "VmallocUsed:    ", 0ul);
> >  	show_val_kb(m, "VmallocChunk:   ", 0ul);
> > +	show_val_kb(m, "PercpuPopulated:", pcpu_nr_populated_pages());
> 
> Populated? Can we avoid this for simplicities sake: "Percpu"?
> 
> We do not count pages that are not present elsewhere either and those
> counters do not have "populated" in them.

Yeah, let's do "Percpu".

Thanks.

-- 
tejun
