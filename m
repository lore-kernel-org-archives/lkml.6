Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10835C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36A620877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36A620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeGJJQD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:16:03 -0400
Received: from smtp-out4.electric.net ([192.162.216.195]:59096 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeGJJQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:16:01 -0400
Received: from 1fcokO-0008Db-UM by out4c.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcokY-0000mU-TF; Tue, 10 Jul 2018 02:15:58 -0700
Received: by emcmailer; Tue, 10 Jul 2018 02:15:58 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4c.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcokO-0008Db-UM; Tue, 10 Jul 2018 02:15:48 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 10 Jul 2018 10:17:27 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 10 Jul 2018 10:17:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jon Maxwell' <jmaxwell37@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "edumazet@google.com" <edumazet@google.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmaxwell@redhat.com" <jmaxwell@redhat.com>
Subject: RE: [net-next,v3] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
Thread-Topic: [net-next,v3] tcp: Improve setsockopt() TCP_USER_TIMEOUT
 accuracy
Thread-Index: AQHUGBrUFQL61i2aaU+ln/VrOCot4aSIK9yQ
Date:   Tue, 10 Jul 2018 09:17:27 +0000
Message-ID: <5f34e43135ed4948bbc32849289aeb20@AcuMS.aculab.com>
References: <20180710065147.27647-1-jmaxwell37@gmail.com>
In-Reply-To: <20180710065147.27647-1-jmaxwell37@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Maxwell
> Sent: 10 July 2018 07:52
...
> +static __u32 tcp_clamp_rto_to_user_timeout(struct sock *sk)
> +{
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +	__u32 elapsed, user_timeout;
> +	u32 start_ts;
> +
> +	start_ts = tcp_retransmit_stamp(sk);
> +	if (!icsk->icsk_user_timeout || !start_ts)
> +		return icsk->icsk_rto;
> +	elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
> +	user_timeout = jiffies_to_msecs(icsk->icsk_user_timeout);
> +	if (elapsed >= user_timeout)
> +		return 1; /* user timeout has passed; fire ASAP */
> +	else
> +		return (icsk->icsk_rto < msecs_to_jiffies(user_timeout - elapsed)) ?
> +			icsk->icsk_rto : msecs_to_jiffies(user_timeout - elapsed);

You've not looked at what the above actually does - something like:
msecs_to_jiffies() probably rounds up, the old code rounded down
so dividing by HZ is probably right.

	int new_tmo = icsk->icsk_user_timeout - (tcp_time_stamp(tcp_sk(sk)) - start_ts)/HZ;

	if (new_tmo > (int) icsk->icsk_rto;
		return icsk->icsk_rto;
	return new_tmo <= 0 ? 1 : new_tmo;
}
