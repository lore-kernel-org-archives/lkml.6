Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFB12174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FDKHNa1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFB12174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeHCLFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:05:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34533 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732294AbeHCLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:05:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180803091012euoutp013b8f6bf24a8ac221ea209b6dad6b72c5~HVMc-eBHy0481704817euoutp01p
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 09:10:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180803091012euoutp013b8f6bf24a8ac221ea209b6dad6b72c5~HVMc-eBHy0481704817euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533287412;
        bh=parlEGmxng2k+/GuNcWnkufUYjJq0a7BM3a7WVy1nT4=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=FDKHNa1SPtp4Ei26GJmLX/6EnHBLHdJzZJXUOFVpJS9bemkSAMkZ5AFzaAwhty1eJ
         ZfQ2lx0D1dEpGlQWMz3hMPVREoyUxhA5qOXc3fAJaD3hUWSIb5df/c3PhL4Bd4UpMQ
         bxYh8JvHBTvyjUMTrhQsJ3nNOPtvcf47Wr3luauc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180803091012eucas1p29128ef2e4c49c8fbaa1b2883e85de426~HVMcRS0Fu2733627336eucas1p2K;
        Fri,  3 Aug 2018 09:10:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EB.90.04627.3FB146B5; Fri,  3
        Aug 2018 10:10:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663~HVMbjcXDZ2739127391eucas1p2M;
        Fri,  3 Aug 2018 09:10:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180803091011eusmtrp1b120b77a9bd3b870b461f19a8515af09~HVMbUr5oS2355223552eusmtrp1C;
        Fri,  3 Aug 2018 09:10:11 +0000 (GMT)
X-AuditID: cbfec7f2-0edff70000021213-22-5b641bf37659
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.28.04178.2FB146B5; Fri,  3
        Aug 2018 10:10:11 +0100 (BST)
Received: from [106.120.51.16] (unknown [106.120.51.16]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180803091010eusmtip2f60b72ea94342a079afd269695c63c45~HVMa1Dk6P2073820738eusmtip2y;
        Fri,  3 Aug 2018 09:10:10 +0000 (GMT)
From:   Piotr Sawicki <p.sawicki2@partner.samsung.com>
Subject: Re: [PATCH v1 20/22] Move common usercopy into
 security_getpeersec_stream
To:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.lsm,gmane.comp.security.selinux
X-Mozilla-News-Host: news://news.gmane.org
Date:   Fri, 3 Aug 2018 11:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH973nuecel7PHIZ9Qtks2JqLWnq1mrPvj6Y+2stoamxyeYbnD
        PUdo4xZSnKXzh7k7ISlpiPw6oaXyIza/Zkk/KNaknRHVzh/k7tHy3+vz+bw/P97ffUlMOiv0
        IJNUGlatUiTLCDHeMWAdO7ruGR91zGIIoWfqqwX0545Ngm5qrhXQQxsFBD1arKSnuk0Evar7
        StAf9OU4bcxfEdKvntdidNliP05P17WIwhwZg7aEYIzaCZwxNzYImNqe7wKm2LiFM7o/cUxj
        7xJi3ry4TzDt5dtCZr310HlxpPh0PJuclMGqg0JjxIkFzZ9QaheZuVDzVKhFelERIkmgTkBV
        /v4iJCalVD2C2fFCjA82EDy5USHig3UEeSazsAg52DtGOycRX3iEYND8ezewIFjTz4lsKmJH
        pWuy4jZ2oS5CXqXWLnKlpjCwaL/ZRRgVAgNFFoGNnagLUNLdjvEr/OGt2WxvxikfMFp7CBu7
        UZfh9XwNsrGEcobhikXcZsKBkkOv6Sw/0h1mF6sEPHtDp8Vk9wPUXRJmpn8QfG8GGIeHcX6X
        HObWVkQ8u8DyYNsue8FImW5XkwslzQMEP0iHoKD9HsEXTsG6vg2zHYFRftDcHcSnw2G5wIj4
        B3aCGYszf48T6DvKMT4tgVs3paXIx7DHjGGPA8MeB4b/86sR3oDc2XROmcBywSr2WiCnUHLp
        qoTAuBRlK9r5cSNbgz+70K/J2H5EkUjmKBk/EhclFSoyuCxlPwISk7lKLLd3UpJ4RVY2q065
        ok5PZrl+5EniMnfJxzvRUVIqQaFhr7JsKqv+VxWQDh5alP04QPaFzqmOdHPOionYPChp2Wqa
        CXi5GFs4KQ9plcd6p3mdmRjXzIdm9pmmrGXHw3wjTgpbvPK2w8TUsCawp3QlIik1p+ZB5bnc
        3H35KlqzIG7tO2DUR5cnZVo3lihfrKzB7/CqaGpIJFfU5T98N5vBvX+Wdt08dsklXJJVKsO5
        REWwP6bmFH8BpUV8G20DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42I5/e/4Pd3P0inRBu/vMlncWLGAyeLetl9s
        FuvWL2ayOPGllc3iTHeuxeVdc9gsPvQ8YrO4PWk6i8XslnesFod3L2a2mPzkEIvF1aUb2R14
        PGY19LJ5zG64yOKxc+0qJo/Fe14yeXTP/sfi0fM92WPt3heMHkf3L2Lz2Dr9P6vH501yAVxR
        ejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmt6+8y
        FuzgqHi8cANrA+Mk9i5GTg4JAROJM9svMXYxcnEICSxllNh3ZzkrREJKYu6/vVBFwhJ/rnWx
        QRS9ZpSY9mYXG0iCDai7Z91PFhBbWCBEonluA9gkEYHrzBLPZu1iBEkwCxhJHOt6ywRi8wkE
        SvTu2soMYgsJ1ErcvHaOGWKDlsSpnTuBBnFw8Aq4SUycEAkSZhFQkZj9cw/YLlGBCInVy1+A
        HccrIChxcuYTsHJOAReJvXM8ITapS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMIrOQdM9C0jIL
        ScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBKaAbcd+bt7BeGlj8CFGAQ5GJR7e
        C6rJ0UKsiWXFlbmHGCU4mJVEeN92AoV4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5H5ie8kri
        DU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MKrznvO5xK376GTCvT3v
        N35qOH8/qlyMOWbyp41TOfw87i2Qey6cFtEklyg6teGM45mdBw9N/bFTsMP0SticXYtWGHOf
        vq9TH8ayxmB9J7djxEqxgj+tlycZtKmKc1j8KJ36OyfMOrNe8aD/N9v216p5nJOuGBQY7ihg
        +byhJ4eZefsHwdmNMkosxRmJhlrMRcWJADlvbo8XAwAA
Message-Id: <20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663~HVMbjcXDZ2739127391eucas1p2M@eucas1p2.samsung.com>
X-CMS-MailID: 20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
        <ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
        <CGME20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 08:24 PM, Casey Schaufler wrote:
> [PATCH 20/22] Move common usercopy into security_getpeersec_stream
> 
> The modules implementing hook for getpeersec_stream
> don't need to be duplicating the copy-to-user checks.
> Moving the user copy part into the infrastructure makes
> the security module code simpler and reduces the places
> where user copy code may go awry.

Hi,

This change will break the API. Some clients may call getsockopt(..,SO_PEERSEC,..) twice. Firstly, to fetch the length. In that case xxx_socket_getpeersec_stream should return -ERANGE and set *optlen. Secondly, to retrieve a proper security label.

Please take a look at the implementation of the getClientSmackLabel() function in Cynara: https://review.tizen.org/gerrit/#/c/26888/6/src/helpers/creds-socket/creds-socket-inner.cpp
Also there is an email thread about this socket option which tells us why it is made this way: "[RFC] SO_PEERSEC - security credentials for Unix stream sockets"

http://lists.jammed.com/linux-security-module/2003/12/0029.html

Regards,
Piotr
