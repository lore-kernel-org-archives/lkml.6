Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD25C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D935B24B02
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxAd4KzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D935B24B02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965395AbeF0NYN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:24:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36563 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934033AbeF0NYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:24:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id o26-v6so1629451ljg.3;
        Wed, 27 Jun 2018 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3eW17YlJ/uM4OID45YjBGd2lOBT6qkl7DNtiwzvpnWA=;
        b=BxAd4KzIvYJzTQpGfqvtCKvp4j6KJcIOdApzRsT6dvor/+ERVQzoUz57YOs6/nlt+n
         nPOuQgQ6ia8t/3jVnFBwfT0/+4wNx7/Z+pnPB5G87WCELsvy8gBY7EYHsyWDJP8pm97f
         XmkHM7CMcj4oZSMzC3JDhEkVNnzJzOFaY4MjVDhOBBUk/ChzayW6sVQl1XuQSGx4NVkL
         or4RrAFkx/Vi1Rv38vX6K974BERj4XT+58iX9nOmMMzvrpZQJWq5s+BSewMdxWPbeXM1
         37vxomJpsDOafX3hyCpfNHxcOO2+sCFXwSMJ1dy2mJgjEyi7sPe/9QnVDHD4z75Ic1Sj
         8z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3eW17YlJ/uM4OID45YjBGd2lOBT6qkl7DNtiwzvpnWA=;
        b=r07AHvxsvPTq5zIsFyaqU63W5+Q4QpMo0/Q9PujQzHR7tqnWDNQt//gwkCCssdrMfI
         O818zlBTkhcgLBwqmmzni/T5tJRvAdHrGVuwPLdRsAY2Oe2HHzXMZiofYcTW6skTmS8j
         Ecq4vkAXcv9cK26VQCsPt2OQLeTR6aeOZKK7sJ64LTWV2CrspJ/9T3TfycrSrHVAYFyQ
         tYHw/AC/A6ia2XPlOaRpm6Bb1kUMZWeO6PmRDm/D2ii6wNkDxNQbHL6+6nx/aR2KPPjs
         Oyy47kiNtSQ159CGgtNnZChU3SzOwkT1b5w6v0C9n6KPwnYpCkrKMe0jecsbRVjHPkRt
         4m6g==
X-Gm-Message-State: APt69E17BrjUiKh4TnDaa5qir0VPpuwc+F2FNsrLQkObpYQthd7hp8b1
        on6PcMpfhTYEf9Bu6qabQpRKfT5U+iiFXwpL2kw=
X-Google-Smtp-Source: ADUXVKK20jw/JYewBbjoEwIAmehjr7vMwS933Fw7y1UTVaAJiUa/lkKKPUTvxVmt84TaBals3fXF9MNOdx2iKJ5D3+o=
X-Received: by 2002:a2e:401b:: with SMTP id n27-v6mr4378333lja.6.1530105849245;
 Wed, 27 Jun 2018 06:24:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 06:24:08
 -0700 (PDT)
In-Reply-To: <20180623000137.GA17264@ssaleem-MOBL4.amr.corp.intel.com>
References: <20180618144443.137068-1-arnd@arndb.de> <20180623000137.GA17264@ssaleem-MOBL4.amr.corp.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Jun 2018 15:24:08 +0200
X-Google-Sender-Auth: SWkSb_TvfGC8KmwG0X7aICnjno4
Message-ID: <CAK8P3a2NVHFLGd58+1p-ZAr9RQoyC4nbcE+Q29R+_xY0oa-tOg@mail.gmail.com>
Subject: Re: [PATCH] infiniband: i40iw, nes: don't use wall time for TCP
 sequence numbers
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Orosco, Henry" <henry.orosco@intel.com>,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Kees Cook <keescook@chromium.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 2:01 AM, Shiraz Saleem <shiraz.saleem@intel.com> wrote:

>> @@ -2164,7 +2165,6 @@ static struct i40iw_cm_node *i40iw_make_cm_node(
>>                                  struct i40iw_cm_listener *listener)
>>  {
>>       struct i40iw_cm_node *cm_node;
>> -     struct timespec ts;
>>       int oldarpindex;
>>       int arpindex;
>>       struct net_device *netdev = iwdev->netdev;
>> @@ -2214,8 +2214,10 @@ static struct i40iw_cm_node *i40iw_make_cm_node(
>>       cm_node->tcp_cntxt.rcv_wscale = I40IW_CM_DEFAULT_RCV_WND_SCALE;
>>       cm_node->tcp_cntxt.rcv_wnd =
>>                       I40IW_CM_DEFAULT_RCV_WND_SCALED >> I40IW_CM_DEFAULT_RCV_WND_SCALE;
>> -     ts = current_kernel_time();
>> -     cm_node->tcp_cntxt.loc_seq_num = ts.tv_nsec;
>> +     cm_node->tcp_cntxt.loc_seq_num = secure_tcp_seq(htonl(cm_node->loc_addr[0]),
>> +                                                     htonl(cm_node->rem_addr[0]),
>> +                                                     htons(cm_node->loc_port),
>> +                                                     htons(cm_node->rem_port));
>
> Should we not be using secure_tcpv6_seq() when we are ipv6?

I had not realized that there is a difference, but yes, from looking
at that function it seems that we should. v2 coming now.

       Arnd
