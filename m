Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137C5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C776D21473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Adu4puUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C776D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeK3ULM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:11:12 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:20800 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK3ULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543568554; x=1575104554;
  h=subject:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=GSRV80gTSrJaxDAn0y2krrNxtusgJJvLW5bQ5LSMzxk=;
  b=Adu4puUlMn1FkbaC19y4jxPnoIEV+jk3NOncPnGEOT55WerZRimlk/YZ
   AOZoiwl3H5792+TeLyhZmNdXjgxn9F3ryYSAUaaamBVZHt0KaivMaCvOs
   3KfKO4PRwURYxBVXclLt45Bpl5eqlvzpFqINwQVt4t0YK+RCbkp1zBiyR
   M=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="747917917"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Nov 2018 09:02:32 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wAU92QUg038041
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 30 Nov 2018 09:02:30 GMT
Received: from EX13D08EUC004.ant.amazon.com (10.43.164.176) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 30 Nov 2018 09:02:30 +0000
Received: from [10.28.86.8] (10.43.161.74) by EX13D08EUC004.ant.amazon.com
 (10.43.164.176) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 30 Nov
 2018 09:02:25 +0000
Subject: Re: [PATCH v2] fs: fix lost error code in dio_complete
CC:     Christoph Hellwig <hch@lst.de>, Torsten Mehlan <tomeh@amazon.de>,
        "Uwe Dannowski" <uwed@amazon.de>, Amit Shah <aams@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>, <stable@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181108185835.17803-1-mheyne@amazon.de>
From:   Maximilian Heyne <mheyne@amazon.de>
Message-ID: <83319cde-9855-d544-8079-15e028f4458f@amazon.de>
Date:   Fri, 30 Nov 2018 10:02:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108185835.17803-1-mheyne@amazon.de>
Content-Language: en-US
X-Originating-IP: [10.43.161.74]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D08EUC004.ant.amazon.com (10.43.164.176)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvOC8xOCA3OjU4IFBNLCBNYXhpbWlsaWFuIEhleW5lIHdyb3RlOgo+IGNvbW1pdCBlMjU5
MjIxNzYzYTQwNDAzZDViYjIzMjIwOTk5OGU4YzQ1ODA0YWI4ICgiZnM6IHNpbXBsaWZ5IHRoZQo+
IGdlbmVyaWNfd3JpdGVfc3luYyBwcm90b3R5cGUiKSByZXdvcmtlZCBjYWxsZXJzIG9mIGdlbmVy
aWNfd3JpdGVfc3luYygpLAo+IGFuZCBlbmRlZCB1cCBkcm9wcGluZyB0aGUgZXJyb3IgcmV0dXJu
IGZvciB0aGUgZGlyZWN0aW8gcGF0aC4gUHJpb3IgdG8KPiB0aGF0IGNvbW1pdCwgaW4gZGlvX2Nv
bXBsZXRlKCksIGFuIGVycm9yIHdvdWxkIGJlIGJ1YmJsZWQgdXAgdGhlIHN0YWNrLAo+IGJ1dCBh
ZnRlciB0aGF0IGNvbW1pdCwgZXJyb3JzIHBhc3NlZCBvbiB0byBkaW9fY29tcGxldGUgd2VyZSBl
YXRlbiB1cC4KPgo+IFRoaXMgd2FzIHJlcG9ydGVkIG9uIHRoZSBsaXN0IGVhcmxpZXIsIGFuZCBh
IGZpeCB3YXMgcHJvcG9zZWQgaW4KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTYw
OTIxMTQxNTM5LkdBMTc4OThAaW5mcmFkZWFkLm9yZy8sIGJ1dAo+IG5ldmVyIGZvbGxvd2VkIHVw
IHdpdGguICBXZSByZWNlbnRseSBoaXQgdGhpcyBidWcgaW4gb3VyIHRlc3Rpbmcgd2hlcmUKPiBm
ZW5jaW5nIGlvIGVycm9ycywgd2hpY2ggd2VyZSBwcmV2aW91c2x5IGVycm9yaW5nIG91dCB3aXRo
IEVJTywgd2VyZQo+IGJlaW5nIHJldHVybmVkIGFzIHN1Y2Nlc3Mgb3BlcmF0aW9ucyBhZnRlciB0
aGlzIGNvbW1pdC4KSSBqdXN0IHdhbnRlZCB0byBmb2xsb3cgdXAgb24gdGhpcy4gSGFzIGFueW9u
ZSBwaWNrZWQgdXAgdGhpcyBwYXRjaD8KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocmVyOiBD
aHJpc3RpYW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoClVzdC1JRDogREUgMjg5IDIzNyA4NzkK
RWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCgo=

