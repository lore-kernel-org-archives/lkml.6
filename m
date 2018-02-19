Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeBSMSb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:18:31 -0500
Received: from smtp-out4.electric.net ([192.162.216.187]:64664 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbeBSMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:18:29 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Colin King'" <colin.king@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][V2] net: dsa: mv88e6xxx: avoid unintended sign extension
 on a 16 bit shift
Thread-Topic: [PATCH][V2] net: dsa: mv88e6xxx: avoid unintended sign extension
 on a 16 bit shift
Thread-Index: AQHTp0cbonxYOOkZgUazFRmiXgJlqaOrqFlg
Date: Mon, 19 Feb 2018 12:19:16 +0000
Message-ID: <a97bab4dc79c4b7da76826843909cae9@AcuMS.aculab.com>
References: <20180216165505.20058-1-colin.king@canonical.com>
In-Reply-To: <20180216165505.20058-1-colin.king@canonical.com>
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
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King
> Sent: 16 February 2018 16:55
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The shifting of timehi by 16 bits to the left will be promoted to
> a 32 bit signed int and then sign-extended to an u64. If the top bit
> of timehi is set then all then all the upper bits of ns end up as also
> being set because of the sign-extension. Fix this by making timehi and
> timelo u64.  Also move the declaration of ns.
> 
> Detected by CoverityScan, CID#1465288 ("Unintended sign extension")
> 
> Fixes: c6fe0ad2c349 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/dsa/mv88e6xxx/hwtstamp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
> index b251d534b70d..2149d332dea0 100644
> --- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
> +++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
> @@ -293,7 +293,8 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
>  			       struct sk_buff *skb, u16 reg,
>  			       struct sk_buff_head *rxq)
>  {
> -	u16 buf[4] = { 0 }, status, timelo, timehi, seq_id;
> +	u16 buf[4] = { 0 }, status, seq_id;
> +	u64 ns, timelo, timehi;
>  	struct skb_shared_hwtstamps *shwt;
>  	int err;
> 
> @@ -321,7 +322,7 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
>  	 */
>  	for ( ; skb; skb = skb_dequeue(rxq)) {
>  		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
> -			u64 ns = timehi << 16 | timelo;
> +			ns = timehi << 16 | timelo;

This seems to be somewhat excessive 64bit maths on a 32bit system.
It is more than enough to make timelo/timehi 'unsigned int'.

	David
