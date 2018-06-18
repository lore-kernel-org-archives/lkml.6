Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8022C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C436208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C436208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933445AbeFRNIM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:08:12 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.229]:17635 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753766AbeFRNIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:08:11 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 7E57B3F59
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:08:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id UtsgfnGgbBcCXUtszfaxm1; Mon, 18 Jun 2018 08:08:10 -0500
X-Authority-Reason: nr=8
Received: from [189.250.78.11] (port=58928 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fUtsf-0005gs-UT; Mon, 18 Jun 2018 08:07:38 -0500
Date:   Mon, 18 Jun 2018 08:07:37 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [smb3] unreachable code and memory leaks
Message-ID: <20180618130737.GA13880@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.11
X-Source-L: No
X-Exim-ID: 1fUtsf-0005gs-UT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.11]:58928
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

While doing some static analysis I came across the following piece of code at fs/cifs/smb2pdu.c:2017:

2017                if (n_iov > 2) {
2018                        struct create_context *ccontext =
2019                            (struct create_context *)iov[n_iov-1].iov_base;
2020                        ccontext->Next =
2021                                cpu_to_le32(iov[n_iov-1].iov_len);
2022                }

The code above is unreachable because n_iov is initialized to 2 and, its value is never updated.
I'm not sure how to fix this.

Also, it seems there are multiple places in which memory allocated for *path* is leaking:

1946        else
1947                return -EIO;

1951        if (rc)
1952                return rc;

1987                if (rc) {
1988                        cifs_small_buf_release(req);
1989                        return rc;
1990                }

and more...

Thanks
--
Gustavo
