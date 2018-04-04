Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeDDOoT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:44:19 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:49037 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeDDOoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:44:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DLAAAM4sRa/5pdJa1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNCgVAyi1WNCIF0gQ+SVYF6C4UDAoQ+ITQYAQIBAQEBAQE?=
 =?us-ascii?q?CbCiFIgEBAQECAScTPxACAQg2EDIlAgQODYR9CK1VM4hBgiWHYoFUP4QQikM?=
 =?us-ascii?q?Clz4IAo4ngTqDWYcxK48rAhETAYEkARw4gVJwFYJ+gh8XEY4GjUmBFwEB?=
X-IronPort-AV: E=Sophos;i="5.48,406,1517875200";
   d="scan'208";a="93533460"
From: "Jon Rosen (jrosen)" <jrosen@cisco.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Mike Maloney" <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] packet: mark ring entry as in-use inside spin_lock to
 prevent RX ring overrun
Thread-Topic: [RFC PATCH] packet: mark ring entry as in-use inside spin_lock
 to prevent RX ring overrun
Thread-Index: AQHTy5aFtVi5IJ8ejEig7CpBQEL4WqPv73kAgAC8vKA=
Date: Wed, 4 Apr 2018 14:34:48 +0000
Message-ID: <54c7cbde468c45609e36738baa5ea084@XCH-RTP-016.cisco.com>
References: <20180403215526.15934-1-jrosen@cisco.com>
 <20180403161630.24f8339c@xeon-e3>
In-Reply-To: <20180403161630.24f8339c@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.82.254.164]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34EiM0V021616



> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index e0f3f4a..264d7b2 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2287,6 +2287,15 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> >  		if (po->stats.stats1.tp_drops)
> >  			status |= TP_STATUS_LOSING;
> >  	}
> > +
> > +        /*
> > +         * Mark this entry as TP_STATUS_IN_PROGRESS to prevent other
> > +         * kernel threads from re-using this same entry.
> > +         */
> > +#define TP_STATUS_IN_PROGRESS TP_STATUS_LOSING
> > +	if (po->tp_version <= TPACKET_V2)
> > +            __packet_set_status(po, h.raw, TP_STATUS_IN_PROGRESS);
> > +
> >  	po->stats.stats1.tp_packets++;
> >  	if (copy_skb) {
> >  		status |= TP_STATUS_COPY;
> 
> This patch looks correct. Please resend it with proper signed-off-by
> and with a kernel code indenting style (tabs).  Is this bug present
> since the beginning of af_packet and multiqueue devices or did it get
> introduced in some previous kernel?

Sorry about the tabs, I'll fix that and try to figure out what I did wrong with
the signed-off-by.

I've looked back as far as I could find online (2.6.11) and it would appear that
this bug has always been there.

Thanks, jon.
