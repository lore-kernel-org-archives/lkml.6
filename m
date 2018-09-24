Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD02ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6A220C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F0TTupto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6A220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbeIXXkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:40:37 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:38314 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbeIXXkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:40:37 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F32FE24E069A;
        Mon, 24 Sep 2018 10:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537810642; bh=IpPoN/0J2PbTDlM2rwLk1dHmy5VfvEmEaWmjE7IQhg8=;
        h=From:To:CC:Subject:Date:References:From;
        b=F0TTuptod4RuGbsCNghGc8WvMiOTJb187CLA/rt8Fndhk26HvLMCnepSwHYqtcbKb
         UMndwqYp8Os4EFCPgHj9GaB3UiKrseAkvjY2AsjLTD3VxTVcN7/BIW0zb1IZfDZPtr
         QcGd0hwPfkvScYjZgHqv68o3YC5AWj3hNs1JqgvwKUKct11ZNzUysIinZzUTzAzsK8
         /hbFHkv44IpJkH/Bz3//WPj7Pqp6mHSeEujVgT/cRaC5tlUHru/cO+tF1i+Dx/lM4G
         mjic3RQi2cl2N08N+HI3qwNRCefUnarYUN8gSUHN310xaTDc7+jOc9eqsWg+UeO53j
         +KFwe7vWPPEiw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id DFD2C3BC8;
        Mon, 24 Sep 2018 10:37:21 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 24 Sep 2018 10:37:21 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [REVIEW][PATCH 1/2] signal/arc: Push siginfo generation into
 unhandled_exception
Thread-Topic: [REVIEW][PATCH 1/2] signal/arc: Push siginfo generation into
 unhandled_exception
Thread-Index: AQHUVBXSFg7RvEfFQUmIDPf8jdiEXw==
Date:   Mon, 24 Sep 2018 17:37:20 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B096A87@us01wembx1.internal.synopsys.com>
References: <874lef2bqn.fsf@xmission.com>
 <20180924144910.14902-1-ebiederm@xmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 07:49 AM, Eric W. Biederman wrote:=0A=
> Pass signr, sicode, and address into unhandled_exception as explicit=0A=
> parameters instead of members of struct siginfo.  Then in unhandled=0A=
> exception generate and send the siginfo using force_sig_fault.=0A=
>=0A=
> This keeps the code simpler and less error prone.=0A=
>=0A=
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>=0A=
=0A=
LGTM.=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
Thx,=0A=
-Vineet=0A=
