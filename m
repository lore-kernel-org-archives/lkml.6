Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D89C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8592208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DqwkF5Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8592208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeJFELb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:11:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37375 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeJFELa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:11:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so5631320pfi.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wGy//HQwhqscXC6lsBjXKnKYPtpcCKQ+qCrfTXP967I=;
        b=DqwkF5YiyBXVcwfa/GCZ61Vex0ZUV6pvFE5RkYST1ihqFWuagLRXeFRHcM0rhXVdBn
         XlQxCNhZ52H5euD584o12V0M+UYpNHNHH3u9dk8/wUnqOuvftiqkLIAZYU0TKW0ShMM1
         T0PaWWo9UeRI/bRAKuV4NOT6hLpPw2QX8fDsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wGy//HQwhqscXC6lsBjXKnKYPtpcCKQ+qCrfTXP967I=;
        b=HTBbc+pJez8YC+CU6DL0sCUgN5UzhMG3csJH6FaTNwUBchiYil3E70Ql+xbU/kR2RZ
         gvCP/CJCUB0itfMnFDu+60odb0xwjjIofZ9Pa29iuiegMRr0S7zblVetYXwfOtWNDXVh
         N2RmyNF6dxg7759bZ7HI92B8g96n1ZaonxmEDyYdl+NAHpkWmHrNECY+x0rukPanvhXZ
         C72wr7fSbrxeiOxtTXC98yGij4zn9Ww8CfFADJxmWiWSGiWP1lPJt8lBlrOuVYG8c0E4
         yqY9Il2tuCIFpXiIEzDSafL2qtbZmqPX94M84hj2MZ+osJDICDDigo/Bw0aTanNoTmlx
         /L6g==
X-Gm-Message-State: ABuFfogTkMyK6/cZee08G0FuskJMo+tE9Ezyat0SS5jjhCTfpcA24HR3
        OLwYVOSYVbbBKs2pVuEAnKD0Mw==
X-Google-Smtp-Source: ACcGV610KjZudh+bb+PkF25XPlLd6B4+kwpMw1KYqdZ0BUk6LsCl73L0b0XH+JFZY8/to5m2MtsLWQ==
X-Received: by 2002:a62:808c:: with SMTP id j134-v6mr13483800pfd.47.1538773860245;
        Fri, 05 Oct 2018 14:11:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id d2-v6sm12876614pfd.100.2018.10.05.14.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 14:10:59 -0700 (PDT)
Date:   Fri, 5 Oct 2018 14:10:58 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        jreck@google.com, john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, Al Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC] mm: Add an fs-write seal to memfd
Message-ID: <20181005211058.GA193964@joelaf.mtv.corp.google.com>
References: <20181005192727.167933-1-joel@joelfernandes.org>
 <20181005125339.f6febfd3fcfdc69c6f408c50@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005125339.f6febfd3fcfdc69c6f408c50@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 12:53:39PM -0700, Andrew Morton wrote:
> On Fri,  5 Oct 2018 12:27:27 -0700 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
> > prevents any future mmap and write syscalls from succeeding while
> > keeping the existing mmap active. The following program shows the seal
> > working in action:
> 
> Please be prepared to create a manpage patch for this one.

Sure, I will do that. thanks,

 - Joel

