Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5087DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5EC2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwsT6ulz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5EC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeIAD5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:57:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44886 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIAD5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:57:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id ba4-v6so6105832plb.11;
        Fri, 31 Aug 2018 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LKoqYV3fRAHxp+shYU2I064FBWusEefvf3+MemRkTLo=;
        b=uwsT6ulzy/AxpwfEkm6zmLFkc04MMmE8J2BjtM6SyBh1Gc/L/k/g+nh+avqiELhYgE
         jkklSS7IfDKeu67nbH26+79vauYy1F4G59/qRD5LqFZb5UikbhNooOad7K6xVr/XXMfa
         Cpi6mdBmhfk4G+GGY09nLZJLD8qLJru98GaXZw7lQ4tURfg+5846vPrhdiGLdx9rR0UF
         wZl73S5L8lOehKCQt1Of+PYWt8uzlKtovZU+FgtDwjXGqK6g4G6ckdMahbA3BQuus+H3
         hX8f/S1E9eApT479t76dcBdoKWPmPTEiFke0ZVIYy37JNG4v/x23cTr7cXmmj1MnuG2P
         JRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LKoqYV3fRAHxp+shYU2I064FBWusEefvf3+MemRkTLo=;
        b=bfSZbwb/km80S7LBCY4+Vr4Q5mFdYX0z5WbEP0curpGvJNMEEcYzkuNeCbw1vnP9QC
         +xq6O3dkL0TtIV6XPqazt7ib6H/Gtj0qSkss2e+b+P+V564v8KHy9gV7YVWUeUz7fGUb
         3nEeDfhrSAEe40NVNcTlsnyL1Sq7MRJQSoAVVwFJFxKuXkv4DMMOPE6b6cfY5/behks2
         O3etmEc3qm3Hxrpmtk1g3gb5vW0COvqZcUsIdwbTaPNr2SfaXSwbPnuO/UXxB8HulGMz
         zToGxWtLAdLRhiehK0UJw03fs++TxZ/obQ33RoCeA6bR+/j4SE0sQlKqY/08/TbZxxHd
         B2tw==
X-Gm-Message-State: APzg51AAm5Pqq4WNAaLjECLLVmY6GM0JX1p3ExB8jhH2lckoyJIt47tK
        eJi/4wKQh/CoN+PKLTYwwV8=
X-Google-Smtp-Source: ANB0VdZPsVrx+OLaO/GZw9yk25ctDQzJKMsUWJkiJBrPv+g6XPsZ/gC2b7ld6yoywdht8h4g+4Zv7g==
X-Received: by 2002:a17:902:5617:: with SMTP id h23-v6mr17688491pli.324.1535759282779;
        Fri, 31 Aug 2018 16:48:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id r19-v6sm15914407pgg.39.2018.08.31.16.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:48:02 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:47:59 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] blkcg: associate a blkg for pages being evicted by
 swap
Message-ID: <20180831234759.GF1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-9-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-9-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:49PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> A prior patch in this series added blkg association to bios issued by
> cgroups. There are two other paths that we want to attribute work back
> to the appropriate cgroup: swap and writeback. Here we modify the way
> swap tags bios to include the blkg. Writeback will be tackle in the next
> patch.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
