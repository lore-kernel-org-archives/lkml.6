Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F969C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1EE2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1EE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLKXjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:39:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35044 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:39:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so15906573otj.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZ+c/zPZIl/2ZFGhTHuBpV4gAexNl5wODnJ7t/X6I6M=;
        b=SK3oUtyJK96DOkxpnVQsljLKXxSB2AOT8DF/VdOMsl8WP2bswHT/WMH6fvfiyTgImH
         f2DFBTitwGNC6d31nbjGqtUukNgTVvGjtsjSBagpEroR8e/Z6LjKYVjWu732vWFHU82A
         2IgR24rCQpedZCc0mHD1vUQ7CAQJ7db5uz6gnSZuqYIoM79bIbkmT3Qoep3xdrKVwSCC
         ezW30wAaVaq+MV/x1N0phyvC9ZQ/psn29+cGcoYqH8/q+LiU3B6m7+IainfQqVreLTK/
         F+Uw6U5Eb60krazQUrTgC1UbpwIxncczCnAROhnMQ7dFcqsbkvWrBeioyGx5W3G6ybgV
         5D3A==
X-Gm-Message-State: AA+aEWZeZB4Xj9OSA2wN6YnhbSVYffzDwUTT9zbEhV1NX5yBeq+WsQGC
        4KMzYYH+hRDl1umwmuwHxXw=
X-Google-Smtp-Source: AFSGD/UBBvUdUiBTKCJYMBRCB6vb1Il2tnSdemydMJuX7WjX8gBgFM/KK0moPnwhSXm+VtuxQsSD1g==
X-Received: by 2002:a9d:a78:: with SMTP id 111mr12577789otg.229.1544571541120;
        Tue, 11 Dec 2018 15:39:01 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l1sm7815580oib.10.2018.12.11.15.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:39:00 -0800 (PST)
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
To:     Jaesoo Lee <jalee@purestorage.com>, nitzanc@mellanox.com
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de,
        Roland Dreier <roland@purestorage.com>,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
 <b7b26a7a-70be-d805-ee64-67fba0b4efa8@mellanox.com>
 <CAJX3Cti_ZJF5E+NRuRzSeEUgaXsbA2U9C+Rh5OdYd4EMwXC1gw@mail.gmail.com>
 <773bb91f-40a4-a525-f7b8-db821b402821@mellanox.com>
 <CAJX3Ctjtt2zebuLfzKM30PV1x3fm8HaJJFJw3zZSOShWnQnu=Q@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c645f196-3fbb-c9b9-5686-730ceed102fa@grimberg.me>
Date:   Tue, 11 Dec 2018 15:38:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJX3Ctjtt2zebuLfzKM30PV1x3fm8HaJJFJw3zZSOShWnQnu=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I cannot reproduce the bug with the patch; in my failure scenarios, it
> seems that completing the request on errors in nvme_rdma_send_done
> makes __nvme_submit_sync_cmd to be unblocked. Also, I think this is
> safe from the double completions.
> 
> However, it seems that nvme_rdma_timeout code is still not free from
> the double completion problem. So, it looks promising to me if you
> could separate out the nvme_rdma_wr_error handling code as a new
> patch.

Guys, can you please send proper patches so we can review properly?
