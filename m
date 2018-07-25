Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A42BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CC320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zbe0N03n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CC320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeGYP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:26:38 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43411 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbeGYP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:26:38 -0400
Received: by mail-yw0-f194.google.com with SMTP id l189-v6so2899765ywb.10;
        Wed, 25 Jul 2018 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AFEdrCnPLio2AtW9WGKB9yNRB5Gbbpv616xvzBH8Jf4=;
        b=Zbe0N03nKVOv2Q7VE7D9yngV67nKRE/Frp2YrmkOUdnlVUyJKCLFYpOpcsZNMPY1BR
         d8l3ZXL0lSqSkFL5RWtluMUEN/mjpfISNDGYnxlPbrwG2vkoFNiXB3BNvHbhvCn7hvfZ
         vfpUZmuHyxff2vTc2MIUDOGZvtZyynKz23sDpeoOBHQ6nW2TXgLJrLR1ZcZZl7bfqEnI
         9Vo3yxyqwpxNXHY+p6H352wkUfX2XaKHNbcu4RpeHVrbxaEr9KXKSUNrIeR+UE71vw30
         hLx63h1kBwAx11hGhxdW/ec1oCbMItdBU2m1vWsMc1+u4N558ht3H8sJtUVazJMtyvCa
         bYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AFEdrCnPLio2AtW9WGKB9yNRB5Gbbpv616xvzBH8Jf4=;
        b=kC4yhLHDqcaNiPArcQBWYP0LLhYg8UulSi8+21p3oglP2IOm6pPaf0gD/0bvIaJUJL
         lRSxvK5hMkoTxMhhiqr6UjpV5XYADXfeOFOQMB58VrS1uBZTVZEqlW8RRi5pOjqfCWX8
         u3ahJ4dfk8Ffv4pcwLxB2I0qkZDQSGxmbfdLqCacZkKvO6AEyvRlJ7NKKJ1N/YKUe5UX
         Ttb+DHPz7lBnoBIG/wxOclUf4MW+r1AXRR0JLJuGDF3PHRncXjlxgokcKByO+OLFMMGJ
         06TIWXR8R0kht21bZ8zNcHgbAS6EB6NrZ9HhqTNBh2M8mga8XCJByJSz4Pat+ACo+NlR
         XDcg==
X-Gm-Message-State: AOUpUlHPvTyFOT+yq2UFBYi5fJSHzdm6gMCmBTuh1dhmzUebg559Dssp
        ZcMc7DDhTmMR6zKYUVxZHuQ=
X-Google-Smtp-Source: AAOMgpf0/kIqyQhYcA4cScur51XXwguVZBa+0YhnYPYZRGR5vWZMddSQz16MHIkAP4TisjVr2XjikA==
X-Received: by 2002:a81:497:: with SMTP id 145-v6mr11011387ywe.212.1532528085634;
        Wed, 25 Jul 2018 07:14:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:e939])
        by smtp.gmail.com with ESMTPSA id e72-v6sm13388362ywa.61.2018.07.25.07.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 07:14:44 -0700 (PDT)
Date:   Wed, 25 Jul 2018 07:14:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Georgi Nikolov <gnikolov@icdsoft.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: cgroups iptables-restor: vmalloc: allocation failure
Message-ID: <20180725141443.GS1934745@devbig577.frc2.facebook.com>
References: <a1a4eb7c-e85c-dc6d-cfac-6d40af302182@icdsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a4eb7c-e85c-dc6d-cfac-6d40af302182@icdsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 02:50:01PM +0300, Georgi Nikolov wrote:
> I posted a kernel bug https://bugzilla.kernel.org/show_bug.cgi?id=200651 and
> i hope this is the correct place to discuss this.

That's just NORETRY vmalloc allocation failing under memory pressure.
Doesn't have much to do with cgroups except that there are also a
bunch of cgroups consuming memory.

Thanks.

-- 
tejun
