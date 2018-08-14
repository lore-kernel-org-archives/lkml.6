Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A22C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC37420657
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CGWX4cqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC37420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeHNXW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:22:26 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36860 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbeHNXW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:22:26 -0400
Received: by mail-yw1-f67.google.com with SMTP id v197-v6so17238105ywg.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/HuVb+KM5t4Vplsxq78fofWF1t1zw/7fZoV478EKSbQ=;
        b=CGWX4cqrGDfQVcIvWrobVb0+M3H2VzRIlkkJA3rV/9Es3vO9XNzmqg4p0vbNmsklc9
         /bmX5EgiQ/6E8yaT+V2fXP0af5UP5iikxWeMkjJNA8bb5baQzcSIqfR8As43SLfYCzdh
         diFe5j9057ioVBNsv8dl8iRqkbq7koEQlerkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/HuVb+KM5t4Vplsxq78fofWF1t1zw/7fZoV478EKSbQ=;
        b=Q0k+bDQnb97kaKnyn6ROLPg1fld7lDhR5FfZznKV85FH0j23GN5WmPAhe3vitQ05Ix
         G41Nxr+wHvTYPC9hIwNPtT4r3id0Adpsy++QM4Nza0Ef5tGDvZrpQqFKM9ERIb4a1d1o
         lB2G0+J9ryRXUrv2GhVrsv1UeZXiMoxIt+7SZ704FbOkE51o4Qhi/oqyyIFsUxVD35mG
         MxY+xQXX8h96CXWI/BKtMo8eGa1h+SRZPZR33DgZeRih6bk3IXL2tMJRftItKJH0UMuA
         f6LwHmBZdXk7uHI/psOA5cmVvtVs8wb8qoJYJDC4WKOtPmyU6Te3VlK4P+r/Kd2gUpPo
         AlCQ==
X-Gm-Message-State: AOUpUlEQTO4UM81xDBQa7aIJM2rnRhnNQd6Q0qW+E3oaP3lGqylKeV9T
        oMqgz/GnDxljxRBf9J/lBZlc1kE1jIY=
X-Google-Smtp-Source: AA+uWPy2l5ZJi+Q0Y4xRk+TmJz+XG3TRhYYPkrKXqnPAtEzsrCHGYJBHem6GE+Y6wfAQvfbdgNLLRA==
X-Received: by 2002:a25:187:: with SMTP id 129-v6mr11645332ybb.158.1534278811529;
        Tue, 14 Aug 2018 13:33:31 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id 64-v6sm8747991ywg.106.2018.08.14.13.33.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 13:33:30 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id r3-v6so17237331ywc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:33:29 -0700 (PDT)
X-Received: by 2002:a25:af4a:: with SMTP id c10-v6mr13461023ybj.463.1534278809236;
 Tue, 14 Aug 2018 13:33:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2316:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 13:33:28
 -0700 (PDT)
In-Reply-To: <CAJuCfpHSZuabLr6+t_n7UDamJCAP6EPTNEZ6kNqWOhk2mpYADg@mail.gmail.com>
References: <20180813223910.26276-1-surenb@google.com> <20180814095413.vbjkcjkmytkffyaz@mwanda>
 <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com> <CAJuCfpHSZuabLr6+t_n7UDamJCAP6EPTNEZ6kNqWOhk2mpYADg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 14 Aug 2018 13:33:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKqcpbpG0Ky4-yXV4d5q10HtGwJtdyPKcrwkJUPhA_Mpg@mail.gmail.com>
Message-ID: <CAGXu5jKqcpbpG0Ky4-yXV4d5q10HtGwJtdyPKcrwkJUPhA_Mpg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Security Officers <security@kernel.org>,
        Kevin Deus <kdeus@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 1:26 PM, Suren Baghdasaryan <surenb@google.com> wrote:
> On Tue, Aug 14, 2018 at 9:57 AM, Suren Baghdasaryan <surenb@google.com> wrote:
>> On Tue, Aug 14, 2018 at 2:54 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>> Thanks.  This is great.  I'm so glad these are finally getting fixed.
>>>
>>> Do we need to fix nfc_hci_msg_rx_work() and nfc_hci_recv_from_llc() as
>>> well?  In nfc_hci_recv_from_llc() we allow pipe to be NFC_HCI_FRAGMENT
>>> (0x7f) so that's one element beyond the end of the array and the
>>> NFC_HCI_HCP_RESPONSE isn't checked.
>>>
>>> Also nci_hci_msg_rx_work() and nci_hci_data_received_cb() use
>>> NCI_HCP_MSG_GET_PIPE() so those could be off by one.
>>
>> Good point. From hci.h:
>>
>> /*
>>  * According to specification 102 622 chapter 4.4 Pipes,
>>  * the pipe identifier is 7 bits long.
>>  */
>> #define NFC_HCI_MAX_PIPES 127
>>
>> And then:
>>
>> struct nfc_hci_dev {
>>   ...
>>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES];
>>   ...
>> }
>>
>> I think the correct fix would be to change it to:
>>
>>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES + 1];
>>
>> What do you think?
>>
>
> Just to be clear, this would fix the problem Dan described in his
> reply and it should be implemented in a separate patch. The original
> fix is still valid.

I think you could merge the fixes into a single patch.

-Kees

-- 
Kees Cook
Pixel Security
